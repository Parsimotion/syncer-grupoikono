_ = require("lodash")
Promise = require("bluebird")
xml2js = Promise.promisifyAll require("xml2js")
SDK = require("producteca-sdk")
Adjustment = SDK.Sync.Adjustment

module.exports =

class MotomelXmlAdapter
  parse: (xml) =>
    xml2js.parseStringAsync(xml).then (parsedXml) =>
      items = @_clean parsedXml.Motomel.item
      items.map (it) ->
        new Adjustment
          identifier: it.code
          name: it.description
          stocks: [
            warehouse: 'Default'
            quantity: it.stock
          ]
          prices: [
            priceList: 'Default'
            value: it.price
          ]

  _clean: (collection) -> collection.map (it) -> _.mapValues it, (it) -> it[0]
