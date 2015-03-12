check = (line) ->
  symbol = get line
  return false if symbol is ' '
  return true if symbol is 'x'

get = (line) ->
  line.substr 3, 1

getStatus = (line) ->
  status = get line
  if status is ' '
    return 'undone'
  else if status is 'x'
    return 'done'

clean = (line) ->
  line.substr 6

module.exports = 

  check: check,
  get: get,
  getStatus: getStatus,
  clean: clean