SDK = require("producteca-sdk")
ProductecaApi = SDK.Api
Syncer = SDK.Sync.Syncer
config = include("config/environment")

module.exports =

class HttpSyncer
  constructor: (user, @options) ->
    @productecaApi = new ProductecaApi
      url: config.producteca.uri
      accessToken: user.tokens.producteca

  synchronize: =>
    @productecaApi.getProducts().then (products) =>
      syncer = new Syncer @productecaApi, @options.sync, products
      @options.reader.read @options, (item) =>
        adjustments = @options.adapter.adapt item
        syncer.execute adjustments
