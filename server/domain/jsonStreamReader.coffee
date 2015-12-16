request = require("request")
JSONStream = require("JSONStream")
Promise = require("bluebird")
MemoryStream = require("memorystream")

module.exports =
class JsonStreamReader
  read: (options, callback) =>
    console.log 'reading json...'
    new Promise (resolve, reject) =>
      stream = request.get(options.url)
      .pipe(new MemoryStream())
      .pipe(JSONStream.parse('*'))

      stream.on 'data', (data) ->
        stream.pause()
        callback(data).then ->
          stream.resume()

      stream.on 'end', ->
        resolve()

      stream.on 'error', (err) ->
        reject(err)