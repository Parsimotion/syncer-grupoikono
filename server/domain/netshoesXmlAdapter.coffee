_ = require("lodash")
Promise = require("bluebird")
xml2js = Promise.promisifyAll require("xml2js")
SDK = require("producteca-sdk")
Adjustment = SDK.Sync.Adjustment

module.exports =

class NetshoesXmlAdapter
  parse: (xml) =>
    xml2js.parseStringAsync(xml).then (parsedXml) =>
      adjustments = _.flatten parsedXml["update-all-attributes"].document.map (doc) ->
        attributes = doc.attribute
        getValueFor = (name) ->
          attribute = _.find attributes, (it) -> it.$.name is name
          attribute?.$.value

        variations = attributes.filter (it) -> it.$.name is "SKU Produto"
        variations.map (variation) ->
          adjustment = new Adjustment
            code: getValueFor "Codigo Produto"
            brand: getValueFor "Brand"
            category: getValueFor "Family"
            name: getValueFor "Title"
            description: getValueFor "Title"
            identifier: variation.$.value
            stocks: [{ warehouse: "Default", quantity: variation.attribute[0].$.value }]
            prices: [{ priceList: "Mercadolibre", value: getValueFor("Price For") }]
            pictures: [{ url: getValueFor("DetalheURL") }]
