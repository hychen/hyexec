{map, filter} = require 'prelude-ls'
proxy = require 'node-proxy'
{compile} = require \../lib/option

include-element-by-type = (op, type, e) -->
  | typeof e is \object =>
    for k,v of e
      switch op
      | \is => typeof v is type
      | \isnt => typeof v isnt type
      | _ => throw "err"
  | _ => false

parse-op-args = (args)->
  set = true
  if args[args.length-1] is false
    set = false
    args = args[0 to args.length-2]
  [set, args]

class Cmd
  (name, style='gnu') ->
    @name = name
    @_args = []
    @_opt_style = style
    @_debug = false

  _dbg: ->
    console.log it if @_debug

  $args: (...args) ->
    # the operation is to unset command arguments if
    # the last function argument is false.
    [set, args] = parse-op-args args

    if args.length > 0
      if set
        @_dbg "set argument '#{args}', current held arguments: '#{@_args}'"
        @_args = @_args ++ args
      else
        @_dbg "unset argument '#{args}', current held arguments: '#{@_args}'"
        @_args = filter (-> it not in args), @_args
      @
    else
      @_dbg "returns current held arguments."
      # only list command arguments run called without function arguments.
      filter (-> typeof it isnt \object), @_args

  $opts: (...args) ->
    if args.length > 0
      for opt in args
        for k,v of opt
          # $opts(k:1) adds optoin k that the value is 1.
          if v isnt false
            @_args.push {"#{k}":v}
          else
            # $opts(k:off) removes option k.
            ...
      @
    else
      # $opts() list command options.
      filter (include-element-by-type \isnt, \boolean), @_args

  $flags: (...args) ->
    if args.length > 0
      [set, flags] = parse-op-args args
      if set
        for flag in flags
          @_args.push {"#{flag}":on}
      else
        ...
      @
    else
      filter (include-element-by-type \is, \boolean), @_args

  $command: ->
    if @_parent
      prefix = [@_parent.name, @name]
    else
      prefix = [@name]
    compile prefix ++ @_args, @_opt_style .join ' '

  $parent: ->
    if it
      @_parent = it
    else
      @_parent

class HyExec
  (current) ->
    @current-cmd = new Cmd current
    @jobs = []
  $end: ->
    if @current-cmd
      @jobs.push @current-cmd
      @current-cmd = null
    @
  $jobs: ->
    @jobs
  $command: ->
    @$end!
    map (-> it.$command!), @jobs .join ';'

hyexec = (name) ->
  handlers = (obj) ->
    has: (name) -> name in obj
    get: (recv, name) ->
      if obj[name]?
        if typeof obj[name] is \function
          return obj[name].bind obj
        else
          return obj[name]
        # commit built command and start building new command
        # if method name does not include $.
      else if (name.indexOf '$') != 0
        # if Cmd is Cmd Group and sub command is called first time.
        if not obj.group
          obj.group = obj.current-cmd
          obj.current-cmd = null
        cmd = new Cmd name
        cmd.$parent obj.group
        obj.$end!
        obj.current-cmd = cmd
        return recv
      # otherwise keep to config current command.

      prop = obj.current-cmd[name]
      if typeof prop is \function
        (...args)->
          val = prop.apply obj.current-cmd, args
          # return HyExec proxy if we are in the setting chain.
          if args.lenght > 0
            val
          else
            recv
      else
        prop
  proxy.create handlers new HyExec name

exports.hyexec = hyexec
exports.$ = hyexec
exports.Cmd = Cmd
