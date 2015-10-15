Promise = require("bluebird")
request = Promise.promisifyAll require("request")

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
    xml = ""
    new Promise (resolve, reject) =>
      request.get(@options.url)
      .on 'data', (data) =>
        decoded = iconvlite.decode(data, @options.encoding or 'utf8')
        console.log decoded
        xml += decoded
      .on 'end', =>
        resolve @options.adapter.parse xml
      .on 'error', (err) -> reject err
