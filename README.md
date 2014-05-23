# HyExec - Fluent Style Shell Command Wrapper for JavaScript

All Unix shell commands can be wrraped by symbol `$`. Its command arguments,
command options, standard output handler and standard error handler can be
manipulate by special methods that the name starts with `$`.

In other words, methods that the name starts with `$` acts as a DSL.

Here is an example that we use the shorthand helper of `hyexec`, which bounds
some useful Unix command wrapper to global namespace.

```JavaScript
hyexec = require 'hyexec'
hyexec.global()
git.add.$args('.').commit.push.$run()
```

```LiveScript
require \hyexec .global!
git.add.$args \. .commit.push.$run!
```

## Symbole $

creates a dynamic wrapper to an existed Unix command.

```javascript
{$} = require \hyexec
```

`$args` is used to add a argument,

```
ls = $ 'ls'
ls.$args '/tmp'
ls.$command!             # ls /tmp
```

or remove a argument.

```
ls
  .$args '/tmp', false   # remove /tmp from arguments.
  .$command!             # ls
```

`$opts` is used to add a option.

```JavaScript
ls.$opts a:on,l:on
ls.$command! # ls -al
```

or remove a option.

```
ls.$opts 'a', 'l', false # remove -a -l from options.
ls.$command!             # ls
```

`$flags` is a shorthand of `$opts` for boolean type command option.

```
ls.$flags 'f'
ls.$command! # ls -a -l -f
```

besides, `$args`,`$opts`, `flags` can be used together.

```javascript
rsync = $ 'rsync'
rsync
  .$opts rsh:\ssh
  .$flags 'a', 'z'
  .$args '/tmp'
  .$args 'server:dest'
  .$command!             # rsync -a -z --rsh='ssh' /tmp server:dest
```

`$` supports Command Group also, such as git, bzr.

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
