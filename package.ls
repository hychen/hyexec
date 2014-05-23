# !/usr/bin/env lsc -cj
author:
  name: ['Chen Hsin Yi']
  email: 'ossug.hychen@gmail.com'
name: 'hyexec'
description: 'Fluent Style Unix Shell Command Wrapper for Node.js'
repository:
  type: 'git'
  url: 'git://github.com/hychen/hyexec.git'
version: '0.1.1'
main: \lib/index.js
scripts:
  test: """
    mocha
  """
  prepublish: """
    lsc -cj package.ls &&
    lsc -bc -o lib src
  """
  # this is probably installing from git directly, no lib.  assuming dev
  postinstall: """
    if [ ! -e ./lib ]; then npm i LiveScript; lsc -bc -o lib src; fi
  """
engines: {node: '*'}
dependencies:
  'prelude-ls': \1.1.x
  'node-proxy': \0.8.x
devDependencies:
  mocha: \1.14.x
  supertest: \0.7.x
  chai: \1.8.x
  LiveScript: \1.2.x
