should = (require \chai).should!
expect = (require \chai).expect

optname = require \../lib .optname

describe 'converting function arguments to approiate command arguments.', ->
  describe 'keyword of arguments should be converted as approiate option name.', -> ``it``
    .. 'should generate posix and gnu stytle options.', (done) ->
      for style in <[posix gnu]>
        optname 'k', style .should.eq '-k'
        optname 'key', style .should.eq '--key'
        optname 'keyKey', style  .should.eq '--key-key'
        optname 'keyKeyKey', style .should.eq '--key-key-key'
      done!
    .. 'should generate java style options.', (done) ->
      style = 'java'
      optname 'k', style .should.eq '-k'
      optname 'key', style .should.eq '-key'
      optname 'keyKey', style  .should.eq '-key-key'
      optname 'keyKeyKey', style .should.eq '-key-key-key'
      done!
