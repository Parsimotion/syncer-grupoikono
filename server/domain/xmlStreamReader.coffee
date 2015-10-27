request = require("request")
XmlStream = require("xml-stream")
Promise = require("bluebird")
MemoryStream = require("memorystream")

module.exports =
class XmlStreamReader
  read: (options, callback) =>
    new Promise (resolve, reject) =>
      stream = request.get(options.url)
      xml = new XmlStream(stream.pipe(new MemoryStream()))
      xml.collect(options.collect) if options.collect
      xml.on 'endElement: ' + options.element, (data) ->
        xml.pause()
        callback(data).then -> xml.resume()
      xml.on 'end', -> resolve()