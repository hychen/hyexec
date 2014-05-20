{filter} = require 'prelude-ls'
{transform-kwarg} = require \../lib/option

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

exports.compile = compile
class Cmd
  (name) ->
    @name = name
    @_args = []
    @_kwargs = {}
    @_opt_style = 'gnu'
    @_debug = false

  _dbg: ->
    console.log it if @_debug

  $args: (...args) ->
    # the operation is to unset command arguments if
    # the last function argument is false.
    set = true
    if args[args.length-1] is false
      set = false
      args = args[0 to args.length-2]

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
      filter (-> typeof it is \object), @_args

  $command: ->
    compile [@name] ++ @_args, @_opt_style .join ' '

exports.Cmd = Cmd
