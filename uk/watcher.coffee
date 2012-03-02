EventEmitter = require( "events" ).EventEmitter
fs = require 'fs'

POLLING_INTERVAL = 50

createWatcher = (dirToWatch)->
  emitter = new EventEmitter()

  fs.watchFile dirToWatch, interval: POLLING_INTERVAL, (curr,prev)->
    return if curr.mtime == prev.mtime
    emitter.emit 'change' 

  watcher = 
    onChange: (callback)->
      emitter.addListener 'change', callback

  watcher

exports = module.exports = 
  createWatcher: createWatcher
