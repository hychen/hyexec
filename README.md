# HyExec

To execute commands in fluent api.

Here is the roughly idea...

Any command can be bound to an object by $ symbol,
the object provides some special methods that its name starts with $ for
manipulating arguemtns, handling stdout, stderr, etc.

```javascript
require! hyexec
$ = new hyexec.Cmd
ls = $ 'ls'
  .$args '/tmp'
  .$opts 'al'
  .$command!             # ls /tmp -al

ls
  .$args '/tmp', false   # remove /tmp from arguments.
  .$command!             # ls -al

ls.$opts 'a', 'l', false # remove -a -l from options.
ls.$command!             # ls
```

```javascript
rsync = $ 'rsync'
rsync
  .$opts rsh:\ssh
  .$opts 'a', 'z'
  .$args '/tmp'
  .$args 'server:dest'
  .$command!             # rsync -a -z --rsh='ssh' /tmp server:dest
```

```javascript
git = $ 'git'
git
  .add
  .$args '.'
  .commit
  .$opts m, 'hello'
  .$ok (stdout) -> console.log stdout
  .push
  .$watch (code, stdout, stderr)-> console.log stdout
  .$err (err, stderr) -> @$retry 3
  .$command! # git add .; git commit -m hello; git push
```
