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
    items = @_clean _.first(stocksAndPrices.Items).item

    items.map (it) =>
      new Adjustment
        identifier: it.UrbPartNum
        name: it.UsbDescrip
        stocks: @_filterNulls [
          @_stockAdjustmentIfExists "Warehouse01", it
          @_stockAdjustmentIfExists "Warehouse02", it
          @_stockAdjustmentIfExists "Warehouse03", it
        ]
        prices: @_filterNulls [
          @_priceAdjustmentIfExists "Lista01", it
          @_priceAdjustmentIfExists "Lista02", it
          @_priceAdjustmentIfExists "Lista03", it
        ]

  _clean: (collection) =>
    collection.map (it) => _.mapValues it, (it) => it[0]

  _filterNulls: (collection) =>
    collection.filter (it) => it?

  _stockAdjustmentIfExists: (name, item) =>
    if @mappings[name]?
      warehouse: @mappings[name], quantity: item[name]

  _priceAdjustmentIfExists: (name, item) =>
    if @mappings[name]? and item[name] isnt "-1"
      priceList: @mappings[name], value: item[name]
