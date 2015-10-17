SDK = require("producteca-sdk")
ProductecaApi = SDK.Api
Syncer = SDK.Sync.Syncer
XmlStreamReader = require('./xmlStreamReader')

module.exports =

class HttpSyncer
  constructor: (user, @options) ->
    @productecaApi = new ProductecaApi
      accessToken: user.tokens.producteca

  synchronize: =>
    @productecaApi.getProducts().then (products) =>
      syncer = new Syncer @productecaApi, @options.sync, products
      new XmlStreamReader().read @options, (item) =>
        adjustments = @options.adapter.adapt item
        syncer.execute adjustments
