require '../' .global!

describe 'global', ->
  describe 'bounds some useful commands to global namespace', -> ``it``
    excepted-cmds =
      * \ls
      * \which
      * \sed
      * \cat
      * \mkdir
      * \cp
      * \git
      * \bzr
    for cmd in excepted-cmds
      global[cmd].should.be.ok
    .. 'the option style of ls should be posix.', (done) ->
      ls.$opts a:on, l:on .$command! .should.eq 'ls -a -l'
      done!
