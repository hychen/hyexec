should = (require \chai).should!
expect = (require \chai).expect
Cmd = require \../lib/cmd .Cmd

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
    .. 'should be able to remove argument(s) by given arguemtn name.', (done) ->
      cmd = new Cmd 'ls' .$args '/tmp/a', '/tmp/b', false
      cmd.$command! .should.eq 'ls'
      done!
    .. 'should be able to remove argument(s) in chain style.', (done) ->
      cmd = new Cmd 'ls'
        .$args '/tmp/a'
        .$args '/tmp/b'
        .$args '/tmp/c'
        .$args '/tmp/a', false
        .$args '/tmp/b', false
        .$command! .should.eq 'ls /tmp/c'
      done!
