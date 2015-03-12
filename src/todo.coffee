fs = require 'fs'
lineReader = require 'line-reader'
trim = require 'trim'
symbol = require('./symbol')
sep = require './sep'
cwd = process.cwd()
encoding = 'utf-8'
home = process.env.HOME or process.env.HOMEPATH or process.env.USERPROFILE
lineNumber = argv._[0]
filename = if argv.g then home + '/TODO.md' else cwd + '/TODO.md'

todo = module.exports =
  
  list: ->
    fs.exists filename, (exists) ->
      if not exists
        console.log chalk.red 'You don\'t have any TODO.'
        console.log '      usage:' + chalk.cyan ' $ todo add -m "what am i going todo"'
        return
      else
        i = 0
        lineReader.eachLine filename, (line, last) ->
          hr()
          if symbol.check line
            mark = chalk.green i
          else
            mark = chalk.red i
          console.log mark + '.' + symbol.clean line
          i++
        .then ->
          hr()

  init: ->

    init('My first todo')
    console.log chalk.green('It\'s done! Now use ') + 
    chalk.underline('todo 0 -m "what to do"') + 
    chalk.green(' to update it!')

  add: ->
    if not argv._[1]
      console.log chalk.red 'No todo given!'
      return
    fs.exists filename, (exists) ->
      if not exists
        init(argv._[1])
        console.log chalk.green('Added, It\'s you first TODO!')
      else
        fs.appendFileSync filename, '- [ ] ' + argv._[1] + '\n', encoding
        console.log chalk.green('You added a new TODO, Cheers!')

  modify: ->
    modifyOrDelete 'modify'

  drop: ->
    modifyOrDelete 'delete'

  done: ->
    doneOrUndone 'done'

  undone: ->
    doneOrUndone 'undone'


init = (item) ->
  content = '- [ ] ' + item + '\n'
  fs.writeFileSync filename, content, encoding

modifyOrDelete = (type) ->
  lines = []
  i = 0
  lineReader.eachLine filename, (line, last) ->
    lines[i] = line
    i++
  .then ->
    if not isTask lines
      return
    if type is 'modify'
      lines[lineNumber] = '- [ ] ' + argv.m
      fs.writeFileSync filename, lines.join('\n') + '\n', encoding
      console.log chalk.green 'It\'s been modified!'
    else if type is 'delete'
      position = lines.indexOf lines[lineNumber]
      lines.splice position, 1
      newFile = lines.join('\n') + '\n'
      if trim(newFile) is ''
        newFile = ''
      fs.writeFileSync filename, newFile, encoding
      console.log chalk.green 'Task #' + lineNumber + ' is deleted!'

doneOrUndone = (type) ->
  lines = []
  i = 0
  lineReader.eachLine filename, (line, last) ->
    lines[i] = line
    i++
  .then ->
    if not isTask lines
      return
    status = symbol.getStatus lines[lineNumber]
    if type is status
      console.log chalk.magenta 'You didn\'t make any change, ' + status + ' is still ' + status
      return
    else if type is 'done'   
      newLine = replaceByRange lines[lineNumber], 0, 5, '- [x]'
      console.log 'The following task is ' + chalk.green('done') + ' now:'
    else if type is 'undone'
      newLine = replaceByRange lines[lineNumber], 0, 5, '- [ ]'
      console.log 'The following task is ' + chalk.green('undone') + ' now:'
    lines[lineNumber] = newLine
    fs.writeFileSync filename, lines.join('\n') + '\n', encoding
    console.log chalk.black.bgYellow ' ' + symbol.clean lines[lineNumber] + ' '

replaceByRange = (string, start, end, newString) ->
  string.substring(0, start) +
  newString +
  string.substring end

hr = ->
  console.log chalk.gray sep '-'

isTask = (lines) ->
  position = lines.indexOf lines[lineNumber]
  if not ~position
    console.log chalk.red 'Can\'t find task in this line!'
    return false
  return true
