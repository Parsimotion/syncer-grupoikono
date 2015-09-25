request = require("bluebird").promisifyAll require("request")

SDK = require("producteca-sdk")
ProductecaApi = SDK.Api
Syncer = SDK.Sync.Syncer
iconvlite = require('iconv-lite')

module.exports =

class HttpSyncer
  constructor: (user, @options) ->
    @productecaApi = new ProductecaApi
      accessToken: user.tokens.producteca

  synchronize: =>
    @getAdjustments().then (adjustments) =>
      @productecaApi.getProducts().then (products) =>
        new Syncer(@productecaApi, @options.sync, products).execute(adjustments)

  getAdjustments: =>
    request.getAsync(@options.url, {}).spread ({body: xml}) =>
      @options.adapter.parse iconvlite.decode(xml, 'latin1')