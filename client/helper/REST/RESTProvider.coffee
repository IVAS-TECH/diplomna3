http = require "http"
Promise = require "promise"

module.exports = ->

  _base = ""

  setBase: (base) -> _base = base

  getBase: -> _base

  $get: ->

    (resource) ->
      _path = "#{_base}/#{resource}"

      make: (method, send) ->
        json = "application/json"
        path = _path
        if method in ["GET", "DELETE"] and send isnt ""
          path += "\/" + send

        new Promise (resolve, reject) ->
          request =
            path: path
            method: method
            responseType: json

          req = http.request request, (res) ->

            response = ""

            res.on "data", (chunk) -> response += chunk

            res.on "end", ->
              resolve
                headers: res.headers
                data: JSON.parse response
                statusCode: res.statusCode

            res.on "error", reject

          if typeof send isnt "string"
            data = JSON.stringify send
            req.setHeader "Content-Type", json
            req.setHeader "Content-Length", data.length
            req.write data

          req.end()

      get: (send = "") -> @make "GET", send
      post: (send = {}) -> @make "POST", send
      put: (send = {}) -> @make "PUT", send
      delete: (send = "") -> @make "DELETE", send
      patch: (send = {}) -> @make "PATCH", send
