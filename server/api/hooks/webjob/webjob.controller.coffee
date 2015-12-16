User = include("api/user/user.model")
HttpSyncer = include("domain/httpSyncer")
MotomelXmlAdapter = include("domain/motomelXmlAdapter")
NetshoesXmlAdapter = include("domain/netshoesXmlAdapter")
WoowJsonAdapter = include("domain/woowJsonAdapter")
XmlStreamReader = include('domain/xmlStreamReader')
JsonStreamReader = include('domain/jsonStreamReader')
SDK = require("producteca-sdk")
ProductecaApi = SDK.Api
config = include("config/environment")
Promise = require('bluebird')
request = Promise.promisifyAll require('request')

exports.notification = (req, res) ->
  xmlStreamReader = new XmlStreamReader
  jsonStreamReader = new JsonStreamReader

  if not isSignatureValid req
    return res.send 403, "Invalid signature"

  User.findOneAsync(_id: req.body.userId)
    .then (user) =>
      motomelOptions =
        adapter: new MotomelXmlAdapter()
        reader: xmlStreamReader
        url: 'http://www.motomel-online.com.ar:8100/Motomel2/harticulostoxml'
        element: 'item'
        sync:
          synchro: prices: true, stocks: true
          identifier: "barcode"

      netshoesOptions =
        adapter: new NetshoesXmlAdapter()
        reader: xmlStreamReader
        url: 'http://www.netshoes.com.mx/template-resources/export/catalogo.xml'
        element: 'document'
        collect: 'attribute'
        sync:
          synchro: prices: true, stocks: true, data: true
          createProducts: true
          identifier: "barcode"

      woowOptions =
        adapter: new WoowJsonAdapter()
        reader: jsonStreamReader
        url: process.env.woowUrl
        sync:
          synchro: prices: true, stocks: true, data: true
          createProducts: true
          identifier: "barcode"

      options = switch user.source
        when "netshoes" then netshoesOptions
        when "woow" then woowOptions
        else motomelOptions

      console.log "synchronizing #{ user.source or 'motomel' }"

      new HttpSyncer(user, options).synchronize().then (results) =>
        res.json 200, results

isSignatureValid = (req) ->
  req.headers["signature"] is (process.env.WEBJOB_SIGNATURE or "default")

exports.resetStock = (req, res) ->
  if not isSignatureValid req
    return res.send 403, "Invalid signature"

  User.findOneAsync(_id: req.body.userId).then (user) =>
    console.log "setting all syncrhonized stock to zero"    
    makeUrlAsync = (url) =>
      parts = url.split "." ; parts[0] += "-async" ; parts.join "."

    options =
      url: config.producteca.uri + "/products"
      qs:
        '$filter': 'integrations/any(i i/app eq 2) and variations/any(p p/stocks/any(s s/quantity ne 0))'
      auth: bearer: user.tokens.producteca
      json: true

    request.getAsync(options).spread (__, body) ->
      Promise.all body.results.map (product) ->
        body = product.variations.map (variation) ->
          variation: variation.id
          stocks: variation.stocks.map (stock) ->
            warehouse: stock.warehouse
            quantity: 0

        options =
          url: makeUrlAsync(config.producteca.uri) + "/products/#{product.id}/stocks"
          auth: bearer: user.tokens.producteca
          json: true
          body: body

        request.putAsync(options).then ->
      .then ->
        res.send 200

