Promise = require("bluebird")
soap = Promise.promisifyAll require("soap")
xml2js = Promise.promisifyAll require("xml2js")
read = require("fs").readFileSync
module.exports =

class IkonoSyncer
  constructor: ->
    @config =
      wsdlUrl: "http://www.portalul.com.ar/ws_urb/pna.php?wsdl"
      xml: read("#{__dirname}/stocksAndPrices.xml", "ascii")
        .replace "$token", process.env.IKONO_TOKEN

  synchronize: =>
    @getAdjustments()

  getAdjustments: =>
    soap.createClientAsync(@config.wsdlUrl).then (client) =>
      client = Promise.promisifyAll client

      client.GetPnAAsync(name: @config.xml).spread (data) =>
        xml = data.return.$value
        xml2js.parseStringAsync(xml).then (stocksAndPrices) =>
          console.log JSON.stringify stocksAndPrices
