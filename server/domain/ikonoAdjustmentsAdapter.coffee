_ = require("lodash")
Adjustment = require("producteca-sdk").Sync.Adjustment

module.exports =

class IkonoAdjustmentsAdapter
  # mappings = {
  #  Warehouse01: "El primer warehouse"
  #  Warehouse03: "El tercer warehouse"
  #  Lista01: "La primer priceList"
  #  Lista02: "La segunda priceList"
  # }
  constructor: (@mappings) ->

  adapt: (stocksAndPrices) =>
    items = @clean _.first(stocksAndPrices.Items).item

    items.map (it) =>
      new Adjustment
        identifier: it.UrbPartNum
        name: it.UsbDescrip
        stocks: @filterNulls [
          @stockAdjustmentIfExists "Warehouse01", it
          @stockAdjustmentIfExists "Warehouse02", it
          @stockAdjustmentIfExists "Warehouse03", it
        ]
        prices: @filterNulls [
          @priceAdjustmentIfExists "Lista01", it
          @priceAdjustmentIfExists "Lista02", it
          @priceAdjustmentIfExists "Lista03", it
        ]

  clean: (collection) =>
    collection.map (it) => _.mapValues it, (it) => it[0]

  filterNulls: (collection) =>
    collection.filter (it) => it?

  stockAdjustmentIfExists: (name, item) =>
    if @mappings[name]?
      warehouse: @mappings[name], quantity: item[name]

  priceAdjustmentIfExists: (name, item) =>
    if @mappings[name]? and item[name] >= 0
      priceList: @mappings[name], value: item[name]
