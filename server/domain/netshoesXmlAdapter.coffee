_ = require("lodash")
Promise = require("bluebird")
xml2js = Promise.promisifyAll require("xml2js")
SDK = require("producteca-sdk")
Adjustment = SDK.Sync.Adjustment

fixedSizeMapping =
  1: "U"
  2: "S"
  3: "M"
  4: "L"
  5: "XL"
  6: "XXL"

numericSizeMapping =
  '50': 10.5
  '87': 12.5
  '88': 13.5
  '75': 17.5
  '85': 18.5
  '95': 19.5
  '60': 20.5
  '51': 21.5
  '62': 22.5
  '53': 23.5
  '54': 24.5
  '55': 25.5
  '65': 26.5
  '57': 27.5
  '58': 28.5
  '59': 29.5
  '70': 30.5
  '61': 31.5
  '72': 32.5
  '63': 33.5
  '64': 34.5
  '66': 35.5
  '67': 37.5
  '68': 38.5
  '69': 39.5
  '71': 40.5
  '73': 41.5
  '74': 42.5
  '76': 43.5
  '79': 44
  '77': 44.5
  '80': 47.5
  '81': 48.5  

colorMapping =
  'Plata': 'Plateado'
  'Azul Marino': 'Azul marino'
  'Transparente': 'Agua'
  'Naranja.': 'Naranja'
  'Morado': 'Purpura'
  'Marron': 'Ocre'
  'Oro': 'Dorado'
  'Coral': 'Salmon'
  'Azul Cielo': 'Azul cielo'
  'Gris Oxford': 'Gris'
  'Azul Turquesa': 'Azul cielo'
  'Verde Agua': 'Agua'
  'Multicolor': 'Fucsia'
  'Verde Militar': 'Verde oscuro'
  'Verde Fosforescente': 'Verde'
  'Aqua': 'Agua'
  'Pink': 'Rosa'
  'Verde Claro': 'Verde claro'
  'Denim': 'Azul'
  'Amarillo Fosforescente': 'Amarillo'
  'Miel': 'Ocre'
  'Turquesa': 'Azul cielo'

module.exports =

class NetshoesXmlAdapter
  adapt: (parsedXml) =>
    attributes = parsedXml.attribute

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
      size = if sizingType is "numeric" then (numericSizeMapping[sizeId] or sizeId) else fixedSizeMapping[sizeId]
      originalPrice = +getValueFor("Price For")
      price = if originalPrice < 900 then originalPrice + 58 else originalPrice

      adjustment = new Adjustment
        code: getValueFor "Codigo Produto"
        brand: getValueFor "Brand"
        category: getValueFor "Family"
        name: getValueFor "Title"
        description: getValueFor "Title"
        identifier: sku
        stocks: [{ warehouse: "Default", quantity: variation.attribute[0].$.value }]
        prices: [{ priceList: "Default", value: price }]
        pictures: [{ url: getValueFor("DetalheURL") }]
        notes: getValueFor "Description"

      if size != "U"
        adjustment.primaryColor = mapColor colors[0]
        adjustment.secondaryColor = mapColor colors[1]
        adjustment.size = size

      adjustment
