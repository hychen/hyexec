{filter} = require 'prelude-ls'
{transform-kwarg} = require \../lib/option

exclude-element-by-type = (op, type, e) -->
    if typeof e is \object
      for k,v of e
        if op is \is
          return true if typeof v is type
        else if op is \isnt
          return true if typeof v isnt type
        else
          throw "err"
    return false

compile = ([hd, ...tl]:lst, style='gnu') ->
  compiled-hd = ->
    if typeof hd is \object
      transform-kwarg style, hd
    else
      [hd]
  aux = -->
    | lst.length == 0 =>
      throw "try to compiled to a empty list"
    | tl.length == 0 =>
      compiled-hd!
    | typeof hd is \object and tl.length > 0 =>
      compiled-hd! ++ compile tl, style
    | _ =>
      [hd] ++ compile tl, style
  aux!

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
      filter (exclude-element-by-type \isnt, \boolean), @_args

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
      filter (exclude-element-by-type \is, \boolean), @_args

  $command: ->
    compile [@name] ++ @_args, @_opt_style .join ' '

exports.Cmd = Cmd
exports.compile = compile
