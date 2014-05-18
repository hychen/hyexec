should = (require \chai).should!
expect = (require \chai).expect

describe 'HyExec' ->
  describe.skip 'execute commands in flunet API.', -> ``it``
    .. 'should build shell commands automatically.', (done) ->
      $ = new HyExec mode:dry
      $ 'git'
        .add \.
        .commit m:\hello
        .push!
        .queue.should.deep.eq [
          ['git', 'add', '.'],
          ['git', 'commit', '-m', 'hello'],
          ['git', 'push']
        ]
      done!
