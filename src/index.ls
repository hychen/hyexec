dash2camel = -> it.replace /(?:^|\s)\S/g, -> it.toUpperCase!
camel2dash = -> it.replace /([a-z\d])([A-Z])/g, '$1-$2' .toLowerCase!

exports.optname = (key, style) -->
  | typeof key isnt \string =>
    throw "key is not string."
  | key.length == 0 =>
    "key can not be empty string"
  | key.length == 1 =>
    "-#{key}"
  | _ =>
    prefix = style in <[posix gnu]> and '--' or '-'
    "#{prefix}#{camel2dash key}"
