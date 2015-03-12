sep = (inputHrStr) ->
  width = if process.stdout.isTTY then process.stdout.getWindowSize()[0] else 0
  hrStr = if inputHrStr.length > 0 then inputHrStr else '='
  out = Array(Math.floor(width / hrStr.length) + 1).join(hrStr)
  partialLen = width - Math.floor(width / hrStr.length) * hrStr.length
  out += hrStr.substring(0, partialLen)
  out

module.exports = sep