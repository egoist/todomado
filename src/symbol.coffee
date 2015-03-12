check = (line) ->
  symbol = get line
  return false if symbol is ' '
  return true if symbol is 'x'

get = (line) ->
  line.substr 3, 1

clean = (line) ->
  line.substr 5

module.exports = 

  check: check,
  get: get,
  clean: clean