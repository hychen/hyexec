should = (require \chai).should!
expect = (require \chai).expect

Cmd = require \../lib/cmd .Cmd
$ = require \../lib/cmd .$
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
  describe 'metho $opts handles options manuplation', -> ``it``
    .. 'should be able to add option(s)', (done) ->
      new Cmd 'rsync'
        .$opts rsh:\ssh .$command! .should.eq 'rsync --rsh=ssh'
      new Cmd 'rsync'
        .$opts rsh:\ssh, op:1 .$command! .should.eq 'rsync --rsh=ssh --op=1'
      done!
    .. 'should be able to add option(s) in chain style.', (done) ->
      new Cmd 'rsync'
        .$opts rsh:\ssh
        .$opts op:1
        .$command! .should.eq 'rsync --rsh=ssh --op=1'
      done!
    .. 'should return current options.', (done) ->
      new Cmd 'rsync'
        .$opts rsh:\ssh
        .$opts op:1
        .$opts! .should.deep.eq [{rsh:\ssh}, {op:1}]
      done!
    .. .skip 'should be able to remove option(s) in chain style.', (done) ->
      new Cmd 'rsync'
        .$opts rsh:\ssh
        .$opts rsh: off
        .$command! .should.eq 'rsync'
      done!
  describe 'method $flags handles flags manuplation', -> ``it``
    .. 'should be able to add flags(s)', (done) ->
      new Cmd 'ls'
        .$flags 'l', 'a'
        .$command! .should.eq 'ls -l -a'
      done!
    .. 'should return current flags.', (done) ->
      new Cmd 'rsync'
        .$flags 'a', 'b'
        .$flags! .should.deep.eq [{a:on}, {b:on}]
      done!
    .. .skip 'should be able to remove flags(s).', (done) ->
      new Cmd 'rsync'
        .$flags 'rsh'
        .$flags 'rsh', off
        .$command! .should.eq 'rsync'
      done!

describe '$, a.k.a HyExec', ->
  describe 'builds command queue in fulent-style..', -> ``it``
    .. 'should be able to config current built command in chain.', (done) ->
      ls = $ 'ls'
      ls.$args '/tmp/a'
        .$opts a:on
        .$end!
        .$jobs! .0.$command! .should.eq 'ls /tmp/a -a'
      done!
