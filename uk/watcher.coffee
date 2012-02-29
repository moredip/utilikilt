fs = require 'fs'

POLLING_INTERVAL = 50

createWatcher = (dirToWatch)->
  fs.watchFile dirToWatch, interval: POLLING_INTERVAL, (curr,prev)->
    return if curr.mtime == prev.mtime

    console.log( "#{dirToWatch} changed" )

exports = module.exports = 
  createWatcher: createWatcher
