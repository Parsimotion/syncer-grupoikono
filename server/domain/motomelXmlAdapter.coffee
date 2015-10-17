_ = require("lodash")
Promise = require("bluebird")
xml2js = Promise.promisifyAll require("xml2js")
SDK = require("producteca-sdk")
Adjustment = SDK.Sync.Adjustment

module.exports =

class MotomelXmlAdapter
  adapt: (item) =>
    adjustment = new Adjustment
      identifier: item.code
      name: item.description
      stocks: [
        warehouse: 'Default'
        quantity: item.stock
      ]
      prices: [
        priceList: 'Default'
        value: item.price
      ]

    return [ adjustment ]