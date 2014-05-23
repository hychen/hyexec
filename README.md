# HyExec - Fluent Style Shell Command Wrapper for JavaScript

note: this work is in very early development stage!

To execute commands in fluent api.

Here is the roughly idea...

Any command can be bound to an object by $ symbol,
the object provides some special methods that its name starts with $ for
manipulating arguemtns, handling stdout, stderr, etc.

```javascript
{$} = require \hyexec
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

supports Command Group also, such as git, bzr.

```javascript
git = $ 'git'
git
  .add
  .$args '.'
  .commit
  .$opts m, 'hello'
  .push
  .$command! # git add .; git commit -m hello; git push
```

# TODO

make Cmd.methods that the name starts with $ is callable object to set
command arguements and command options one times as the above example.

```
ls = $ 'ls'
ls '-al'
ls a:on

git = $ 'git'
git
  .add \.
  .commit m:\hello
  .push!
  .$command!
```
