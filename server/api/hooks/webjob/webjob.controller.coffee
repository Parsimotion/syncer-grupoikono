User = include("api/user/user.model")
HttpSyncer = include("domain/httpSyncer")
MotomelXmlAdapter = include("domain/motomelXmlAdapter")
NetshoesXmlAdapter = include("domain/netshoesXmlAdapter")

exports.notification = (req, res) ->
  if not isSignatureValid req
    return res.send 403, "Invalid signature"

  User.findOneAsync(_id: req.body.userId)
    .then (user) =>
      motomelOptions =
        adapter: new MotomelXmlAdapter()
        url: 'http://www.motomel-online.com.ar:8100/Motomel2/harticulostoxml'
        sync:
          synchro: prices: true, stocks: true
          identifier: "barcode"

      netshoesOptions =
        adapter: new NetshoesXmlAdapter()
        url: 'http://www.tiendacruzazulonline.com.mx/template-resources/export/catalogo.xml'
        encoding: 'latin1'
        sync:
          synchro: prices: true, stocks: true, data: true
          createProducts: true
          identifier: "barcode"

      options = if user.source is "netshoes" then netshoesOptions else motomelOptions
      
      new HttpSyncer(user, options).synchronize().then (results) =>
        res.json 200, results

isSignatureValid = (req) ->
  req.headers["signature"] is (process.env.WEBJOB_SIGNATURE or "default")
