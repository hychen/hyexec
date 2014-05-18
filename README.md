# HyExec

To execute commands in fluent api.

Here is the roughly idea...

```javascript
require! hyexec
$ = new hyexec.HyExec
$ 'ls', '-al'                         # ls -al
  .cd \/opt/                          # cd /opt
  .then 'git'
    .add \. do                        # git add
      success -> console.log 'ok!'    # print ok! if git add success.
      failure -> console.log 'oops!' # print oops! if git add failure.
    .commit m:'hello'                 # git commit -m hello
    .push!                            # git push
    .cd '-'                           # cd -
    .then 'touch', 'done'             # touch done
    .end!
```
