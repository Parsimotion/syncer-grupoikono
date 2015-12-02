User = include("api/user/user.model")
HttpSyncer = include("domain/httpSyncer")
MotomelXmlAdapter = include("domain/motomelXmlAdapter")
NetshoesXmlAdapter = include("domain/netshoesXmlAdapter")
WoowJsonAdapter = include("domain/woowJsonAdapter")
XmlStreamReader = include('domain/xmlStreamReader')
JsonStreamReader = include('domain/jsonStreamReader')

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
        url: process.env.woowUrl or 'http://az769013.vo.msecnd.net/jsons/woow.json'
        sync:
          synchro: prices: true, stocks: true, data: true
          createProducts: true
          identifier: "barcode"

      options = switch user.source
        when "netshoes" then netshoesOptions
        when "woow" then woowOptions
        else motomelOptions

      new HttpSyncer(user, options).synchronize().then (results) =>
        res.json 200, results

isSignatureValid = (req) ->
  req.headers["signature"] is (process.env.WEBJOB_SIGNATURE or "default")
