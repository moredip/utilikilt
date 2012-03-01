EventEmitter = require( "events" ).EventEmitter
fs = require 'fs'

POLLING_INTERVAL = 50

createWatcher = (dirToWatch)->
  emitter = new EventEmitter()

  fs.watchFile dirToWatch, interval: POLLING_INTERVAL, (curr,prev)->
    return if curr.mtime == prev.mtime
    console.log( "#{dirToWatch} changed" )
    emitter.emit 'change' 

  watcher = 
    onChange: (callback)->
      emitter.addListener 'change', callback
      console.log('registered callback')
  watcher

exports = module.exports = 
  createWatcher: createWatcher
