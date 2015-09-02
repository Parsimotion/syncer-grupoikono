MotomelXmlAdapter = require("./motomelXmlAdapter")
request = require("bluebird").promisifyAll require("request")

SDK = require("producteca-sdk")
ProductecaApi = SDK.Api
Syncer = SDK.Sync.Syncer

module.exports =

class MotomelSyncer
  constructor: (user) ->
    @productecaApi = new ProductecaApi
      accessToken: user.tokens.producteca

    @config =
      sync:
        synchro: prices: true, stocks: true
        identifier: "barcode"

  synchronize: =>
    @getAdjustments().then (adjustments) =>
      @productecaApi.getProducts().then (products) =>
        new Syncer(@productecaApi, @config.sync, products).execute(adjustments)

  getAdjustments: =>
    request.getAsync('http://www.motomel-online.com.ar:8100/Motomel2/harticulostoxml', {}).spread ({body: xml}) ->
      new MotomelXmlAdapter().parse xml
