transform-arg = require \./ .transform-kwarg

{filter} = require 'prelude-ls'

buildcmd = (style, ...args, {m}:kwargs) ->
  args ++ transform-arg style, kwargs

class Cmd
  (name) ->
    @name = name
    @_args = []
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

    if set
      @_dbg "set argument '#{args}', current held arguments: '#{@_args}'"
      @_args = @_args ++ args
    else
      @_dbg "unset argument '#{args}', current held arguments: '#{@_args}'"
      @_args = filter (-> it not in args), @_args
    @

  $command: ->
    if @_args.length == 0
      @name
    else
      @name + ' ' + @_args.join ' '

exports.Cmd = Cmd
