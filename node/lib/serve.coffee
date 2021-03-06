fs = require 'fs'
express = require 'express'
coffee = require 'coffee-script'

htmlMangler = (req,res,next)->
  origWrite = res.write
  origEnd = res.end

  firstCall = true
  res.write = (chunk,encoding)->
    if firstCall
      isHtml = /^text\/html/.test( res.getHeader('content-type') )
      if isHtml
        origWrite.call(res,'<script type="text/javascript" src="/reload.js"></script>', encoding )
      firstCall = false

    origWrite.call(res,chunk,encoding)

  res.end = (chunk,encoding)->
    res.write( chunk, encoding ) if chunk?
    origEnd.call(res)


  res.on 'header', ->
    res.removeHeader('Content-Length') # coz we're messing with it, innit.
  
  next()


startServer = (publicDir, port)->
  app = express.createServer()
    .use( express.logger({ buffer: 500 }) )
    .use( htmlMangler )
    .use( express.static(publicDir) )
    .use( express.directory(publicDir) )

  app.get '/reload.js', (req,res)->
    res.contentType "text/javascript"
    fs.readFile __dirname+'/reload.coffee', (err,data) =>
      res.send( coffee.compile(data.toString()) )

  app.listen( port )
  console.log('UtiliKilt UP!')
  app

exports = module.exports = startServer
