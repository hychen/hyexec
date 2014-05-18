transform-arg = require \./ .transform-kwarg

buildcmd = (style, ...args, {m}:kwargs) ->
  args ++ transform-arg style, kwargs
