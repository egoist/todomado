fs = require 'fs'
lineReader = require 'line-reader'
hr = require 'hr'
chalk = require 'chalk'
symbol = require('./symbol')
cwd = process.cwd()
encoding = 'utf-8'
filename = cwd + '/TODO.md'

todo = module.exports =
  
  list: ->
    fs.exists filename, (exists) ->
      if not exists
        console.log chalk.red 'You don\'t have any TODO.'
        console.log chalk.cyan '     usage: $ todo add -m "what am i going todo"'
        return
      else
        i = 0
        lineReader.eachLine filename, (line, last) ->
          hr.hr('-')
          if symbol.check line
            mark = chalk.green i
          else
            mark = chalk.red i
          console.log mark + '.' + symbol.clean line
          i++
        .then ->
          hr.hr('-')

  init: ->

    init('My first todo')
    console.log chalk.green('It\'s done! Now use ') + 
    chalk.underline('todo 0 -m "what to do"') + 
    chalk.green(' to update it!')

  add: ->
    if not argv.m
      console.log 'No todo given'
      return
    fs.exists filename, (exists) ->
      if not exists
        init(argv.m)
        console.log chalk.green('Added, It\'s you first TODO!')
      else
        fs.appendFileSync filename, '- [ ] ' + argv.m + '\n', encoding
        console.log chalk.green('You added a new TODO, Cheers!')

  modify: ->
    console.log 'modify'
    lineNumber = argv._[0]
    lines = []
    i = 0
    lineReader.eachLine filename, (line, last) ->
      lines[i] = line
      i++
    .then ->
      lines[lineNumber] = '- [ ] ' + argv.m
      fs.writeFileSync filename, lines.join('\n'), encoding
      console.log chalk.green 'It\'s modified!'

init = (item) ->
  content = '- [ ] ' + item + '\n'
  fs.writeFileSync filename, content, encoding


