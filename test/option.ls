should = (require \chai).should!
expect = (require \chai).expect

optname = require \../lib .option! .optname
transform-kwarg = require \../lib .option! .transform-kwarg

describe 'cnverting function arguments to approiate command arguments.', ->
  describe 'in POSIX style', ->
    posix-optname = optname 'posix'
    posix-transform-kwarg = transform-kwarg 'posix'
    describe 'the option prefix', -> ``it``
      .. 'should be - if the keyword is 1 char.', (done) ->
        posix-optname 'k' .should.be.eq '-k'
        done!
      .. 'should be -- if the keyword has more than 1 char.', (done) ->
        posix-optname 'key' .should.be.eq '--key'
        done!
    describe 'the camelcase in keyword argument name', -> ``it``
      .. 'should be dashfied.', (done) ->
        posix-optname 'keyKey' .should.be.eq '--key-key'
        posix-optname 'keyKeyKey' .should.be.eq '--key-key-key'
        done!
    describe 'the option string of a boolean keyword argument', -> ``it``
      .. 'should only present option name.', (done) ->
        posix-transform-kwarg k:on .should.be.deep.eq ['-k']
        posix-transform-kwarg key:on .should.be.deep.eq ['--key']
        posix-transform-kwarg key-key:on .should.be.deep.eq ['--key-key']
        done!
    describe 'the option string of a key-value pair keyword argument', -> ``it``
      .. 'should present in k=v form.', (done) ->
        posix-transform-kwarg k:1 .should.be.deep.eq ['-k', '1']
        posix-transform-kwarg key:1 .should.be.deep.eq ['--key', '1']
        posix-transform-kwarg key-key:1 .should.be.deep.eq ['--key-key', '1']
        done!
  describe 'in GNU style', ->
    gnu-optname = optname 'gnu'
    gnu-transform-kwarg = transform-kwarg 'gnu'
    describe 'the option prefix', -> ``it``
      .. 'should be - if the keyword is 1 char.', (done) ->
        gnu-optname 'k' .should.be.eq '-k'
        done!
      .. 'should be -- if the keyword has more than 1 char.', (done) ->
        gnu-optname 'key' .should.be.eq '--key'
        done!
    describe 'the camelcase in keyword argument name', -> ``it``
      .. 'should be dashfied.', (done) ->
        gnu-optname 'keyKey' .should.be.eq '--key-key'
        gnu-optname 'keyKeyKey' .should.be.eq '--key-key-key'
        done!
    describe 'the option string of a boolean keyword argument', -> ``it``
      .. 'should only present option name.', (done) ->
        gnu-transform-kwarg k:on .should.be.deep.eq ['-k']
        gnu-transform-kwarg key:on .should.be.deep.eq ['--key']
        gnu-transform-kwarg key-key:on .should.be.deep.eq ['--key-key']
        done!
    describe 'the option string of a key-value pair keyword argument', -> ``it``
      .. 'should present in k=v form.', (done) ->
        gnu-transform-kwarg k:1 .should.be.deep.eq ['-k=1']
        gnu-transform-kwarg key:1 .should.be.deep.eq ['--key=1']
        gnu-transform-kwarg key-key:1 .should.be.deep.eq ['--key-key=1']
        done!
  describe 'in GNU style', ->
    java-optname = optname 'java'
    java-transform-kwarg = transform-kwarg 'java'
    describe 'the option prefix', -> ``it``
      .. 'should be - if the keyword is 1 char.', (done) ->
        java-optname 'k' .should.be.eq '-k'
        done!
      .. 'should be - if the keyword has more than 1 char.', (done) ->
        java-optname 'key' .should.be.eq '-key'
        done!
    describe 'the camelcase in keyword argument name', -> ``it``
      .. 'should be dashfied.', (done) ->
        java-optname 'keyKey' .should.be.eq '-key-key'
        java-optname 'keyKeyKey' .should.be.eq '-key-key-key'
        done!
    describe 'the option string of a boolean keyword argument', -> ``it``
      .. 'should only present option name.', (done) ->
        java-transform-kwarg k:on .should.be.deep.eq ['-k']
        java-transform-kwarg key:on .should.be.deep.eq ['-key']
        java-transform-kwarg key-key:on .should.be.deep.eq ['-key-key']
        done!
    describe 'the option string of a key-value pair keyword argument', -> ``it``
      .. 'should present in k=v form.', (done) ->
        java-transform-kwarg k:1 .should.be.deep.eq ['-k=1']
        java-transform-kwarg key:1 .should.be.deep.eq ['-key=1']
        java-transform-kwarg key-key:1 .should.be.deep.eq ['-key-key=1']
        done!
