request = require("request")
JSONStream = require("JSONStream")
Promise = require("bluebird")
MemoryStream = require("memorystream")

module.exports =
class JsonStreamReader
  read: (options, callback) =>
    new Promise (resolve, reject) =>
      stream = request.get(options.url)
      .pipe(new MemoryStream())
      .pipe(JSONStream.parse('*'))

      stream.on 'data', (data) ->
        callback(data)

      stream.on 'end', ->
        resolve()

      stream.on 'error', (err) ->
        reject(err)