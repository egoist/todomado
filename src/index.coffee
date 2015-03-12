global.chalk = require 'chalk'
todo = require './todo'

module.exports = (argv) ->
  if argv._.length is 0 and not argv.v
    todo.list()
  else if checkTopCommand()
    switch argv._[0]
      when 'init' then todo.init()
      when 'add' then todo.add()
    switch argv._[1]
      when 'done' then todo.done()
      when 'undone' then todo.undone()
  else if argv.m
    todo.modify()
  else if argv.d
    todo.drop()
  else if argv.v
    console.log 'todo.md ~ ' + chalk.cyan require('../package').version
  else if argv.done
    todo.done()
  else if argv.undone
    todo.undone()
  else
    console.log chalk.red 'err: Unknown method'

checkTopCommand = ->
  commands = ['init', 'add', 'done', 'undone']
  return true if argv._[0] in commands
  return true if argv._[1] in commands
  return false
