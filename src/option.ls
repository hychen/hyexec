dash2camel = -> it.replace /(?:^|\s)\S/g, -> it.toUpperCase!
camel2dash = -> it.replace /([a-z\d])([A-Z])/g, '$1-$2' .toLowerCase!

optname = (style, key) -->
  | typeof key isnt \string =>
    throw "key is not string."
  | key.length == 0 =>
    "key can not be empty string"
  | key.length == 1 =>
    "-#{key}"
  | _ =>
    prefix = style in <[posix gnu]> and '--' or '-'
    "#{prefix}#{camel2dash key}"

transform-kwarg = (style, kwargs) -->
  args = []
  for k,v of kwargs
    styled-optname = optname style, k
    if typeof v is \boolean and v is true
      args.push styled-optname
    else
      if style in <[java gnu]>
        args.push "#{styled-optname}=#{v}"
      else
        args.push styled-optname
        args.push "#{v}"
  args

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

exports.optname = optname
exports.transform-kwarg = transform-kwarg
exports.compile = compile
