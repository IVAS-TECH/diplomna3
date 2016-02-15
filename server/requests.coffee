{join} = require "path"
{createWriteStream} = require "fs"
bodyParser = require "body-parser"
errorLogger = require "./errorLogger"
errorHandler = require "./errorHandler"
sendFileMiddleware = require "./routes/sendFileMiddleware"

errorStream = createWriteStream (join __dirname, "error.log"), flags: "a"

sendDir = join __dirname, 'send'

sendFile = sendFileMiddleware sendDir

module.exports =

  beforeEach: [bodyParser.json(), errorLogger errorStream]

  get: sendFile "index.html"

  api: require "./routes/routes"

  "favicon.ico": get: sendFile "favicon.ico"

  "bundle.js": get: sendFile "bundle.js"

  "style.css": get: sendFile "style.css"

  afterEach: [
    (req, res, next) -> next new Error "Not Found"
    errorHandler errorStream, "/#!/notfound"
  ]
