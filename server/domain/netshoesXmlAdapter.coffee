_ = require("lodash")
Promise = require("bluebird")
xml2js = Promise.promisifyAll require("xml2js")
SDK = require("producteca-sdk")
Adjustment = SDK.Sync.Adjustment

sizeMapping =
  1: "U"
  2: "S"
  3: "M"
  4: "L"
  5: "XL"
  6: "XXL"

colorMapping =
  'Plata': 'Plateado'
  'Azul Marino': 'Azul marino'
  'Transparente': 'Agua'
  'Naranja.': 'Naranja'

module.exports =

class NetshoesXmlAdapter
  parse: (xml) =>
    xml2js.parseStringAsync(xml).then (parsedXml) =>
      adjustments = _.flatten parsedXml["update-all-attributes"].document.map (doc) =>
        attributes = doc.attribute

        findTag = (name) ->
          _.find attributes, (it) -> it.$.name is name
        getValueFor = (name) ->
          attribute = findTag name
          attribute?.$.value
        mapColor = (color) ->
          colorMapping[color] or color

        variations = attributes.filter (it) -> it.$.name is "SKU Produto"
        variations.map (variation) =>
          sku = variation.$.value
          colorTag = findTag "Color"
          colors = colorTag?.$.value.split('+').map((it) -> it.replace '-', ' ')

          sizingType = if _.isNaN parseInt(colorTag.attribute[0].$.value) then "fixed" else "numeric"
          sizeId = parseInt _.last sku.split('-')
          size = if sizingType is "numeric" then sizeId else sizeMapping[sizeId]

          adjustment = new Adjustment
            code: getValueFor "Codigo Produto"
            brand: getValueFor "Brand"
            category: getValueFor "Family"
            name: getValueFor "Title"
            description: getValueFor "Title"
            identifier: sku
            stocks: [{ warehouse: "Default", quantity: variation.attribute[0].$.value }]
            prices: [{ priceList: "Default", value: getValueFor("Price For") }]
            pictures: [{ url: getValueFor("DetalheURL") }]
            primaryColor: mapColor colors[0]
            secondaryColor: mapColor colors[1]
            size: size

