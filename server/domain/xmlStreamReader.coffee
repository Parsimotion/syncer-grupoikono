request = require("request")
XmlStream = require("xml-stream")
Promise = require("bluebird")

module.exports =
class XmlStreamReader
  read: (options, callback) =>
    new Promise (resolve, reject) =>
      stream = request.get(options.url)
      xml = new XmlStream(stream)
      xml.collect(options.collect) if options.collect
      xml.on 'endElement: ' + options.element, callback
      xml.on 'end', -> resolve()