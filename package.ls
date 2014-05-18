#!/usr/bin/env lsc -cj
author:
  name: ['Chen Hsin Yi']
  email: 'ossug.hychen@gmail.com'
name: 'hyexec'
description: 'run commands in fluent api.'
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
devDependencies:
  mocha: \1.14.x
  supertest: \0.7.x
  chai: \1.8.x
  LiveScript: \1.2.x
