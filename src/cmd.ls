{filter} = require 'prelude-ls'

compile = ([hd, ...tl]:lst) -->
  | lst.length == 0 => throw "try to compiled to a empty list"
  | tl.length == 0 => [hd]
  | _ => [hd] ++ compile tl

class Cmd
  (name) ->
    @name = name
    @_args = []
    @_kwargs = {}
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

  $command: ->
    if @_args.length == 0
      @name
    else
      @name + ' ' + compile @_args .join ' '

exports.Cmd = Cmd
