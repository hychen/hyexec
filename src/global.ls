{$} = require '../' .cmd!

registed-cmds =
  cat: 'posix'
  which: 'posix'
  ls: 'posix'
  mkdir: 'posix'
  sed: 'posix'
  cp: 'posix'
  git: 'posix'
  bzr: 'posix'

exports.init-env = ->
  for cmdname, cmdoptstyle of registed-cmds
    global[cmdname] = $ cmdname, cmdoptstyle
