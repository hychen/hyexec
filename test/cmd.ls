should = (require \chai).should!
expect = (require \chai).expect

Cmd = require \../lib/cmd .Cmd
compile = require \../lib/cmd .compile

describe 'compile function', ->
  describe 'replaces all command options to apporiate string.', -> ``it``
    .. 'should not modify arguments.', (done) ->
      compile ['lsc','file','abc','def']
        .should.deep.eq ['lsc','file','abc','def']
      done!
    .. 'should transform gnu style options.', (done) ->
      compile [{k1:1}]
        .should.deep.eq ['--k1=1']
      done!
    .. 'should transform posix style options.', (done) ->
      compile [{k1:1}], 'posix'
        .should.deep.eq ['--k1', '1']
      compile [{k1:1}, {k2:2}], 'posix'
        .should.deep.eq ['--k1', '1', '--k2', '2']
      done!
    .. 'should transform java style options.', (done) ->
      compile [{k1:1}], 'java'
        .should.deep.eq ['-k1=1']
      compile [{k1:1}, {k2:2}], 'java'
        .should.deep.eq ['-k1=1', '-k2=2']
      done!

describe 'Cmd', ->
  describe 'method $args handles arguments manuplation.', -> ``it``
    .. 'should be able to add argument(s) by given argument name.', (done) ->
      cmd = new Cmd 'ls' .$args '/tmp/a', '/tmp/b'
      cmd.$command! .should.eq 'ls /tmp/a /tmp/b'
      done!
    .. 'should be able to add argument(s) in chain style.', (done) ->
      cmd = new Cmd 'ls'
        .$args '/tmp/a'
        .$args '/tmp/b'
        .$args '/tmp/c'
        .$command! .should.eq 'ls /tmp/a /tmp/b /tmp/c'
      done!
    .. 'should return current arguments without argument name.', (done) ->
      cmd = new Cmd 'ls'
      cmd.$args! .should.deep.eq []
      cmd.$args 'gogo' .$args! .should.deep.eq ['gogo']
      done!
    .. 'should be able to remove argument(s) by given arguemtn name.', (done) ->
      cmd = new Cmd 'ls' .$args '/tmp/a', '/tmp/b', off
      cmd.$command! .should.eq 'ls'
      done!
    .. 'should be able to remove argument(s) in chain style.', (done) ->
      cmd = new Cmd 'ls'
        .$args '/tmp/a'
        .$args '/tmp/b'
        .$args '/tmp/c'
        .$args '/tmp/a', off
        .$args '/tmp/b', off
        .$command! .should.eq 'ls /tmp/c'
      done!
