{join} = require "path"
express = require "express"
bodyParser = require "body-parser"
ip = require "ip"
mongoose = require "mongoose"
session = require "./lib/session/session"
routes = require "./routes/routes"
errorHandler = require "./errorHandler"

port = process.env.PORT ? 3000
address = ip.address()
appDir = join __dirname, '../client/app'
index = join appDir, "index.html"
error = join appDir, "error.html"
app = express()

mongoose.connect "0.0.0.0:27017/db"

app.use bodyParser.json()
app.use session()
app.use "/client", routes
app.get "/final.js", (req, res) -> res.sendFile join appDir , "final.js"
app.get "/favicon.ico", (req, res) -> console.log "add favicon!!!"
app.get "/", (req, res) -> res.sendFile index
app.use (req, res, next) -> next "Not Found"
app.use errorHandler error

app.listen port, -> console.log "Server started at 0.0.0.0:#{port}"
