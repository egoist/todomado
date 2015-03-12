todo = require './todo'

module.exports = (argv) ->

  if argv._.length is 0
    todo.list()
  else if argv._[0] is 'init' or argv._[0] is 'add'
    switch argv._[0]
      when 'init' then todo.init()
      when 'add' then todo.add()
  else
    todo.modify()