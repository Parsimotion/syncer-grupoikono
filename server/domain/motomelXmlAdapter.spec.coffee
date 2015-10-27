nock = require("nock")
MotomelXmlAdapter = require("./motomelXmlAdapter")
fs = require("fs")
path = require("path")
_ = require("lodash")
XmlStreamReader = require('./xmlStreamReader')
Promise = require("bluebird")
clean = (collection) -> collection.map (o) -> _.omit o, _.isFunction

describe "MotomelXmlAdapter", ->
  it "can adapt the xml to a list of adjustments", ->
    filename = path.join __dirname, 'stocksAndPrices.xml'
    xml = fs.readFileSync filename, 'utf8'
    domain = 'http://www.motomel-online.com.ar:8100'
    url = '/Motomel2/harticulostoxml'
    nock(domain).get(url).reply 200, xml

    adjustments = []
    options =
      url: domain + url
      element: 'item'

    adapter = new MotomelXmlAdapter()
    new XmlStreamReader().read options, (item) ->
      Promise.resolve adjustments = adjustments.concat adapter.adapt item
    .then ->
      expexted = [
        identifier: "55056"
        name: "BUJE BOMBA ACEITE"
        stocks: [{ warehouse: "Default", quantity: 3 }]
        prices: [{ priceList: "Default", value: 17.6418 }]
      ,
        identifier: "55073"
        name: "BUJE PLASTICO"
        stocks: [{ warehouse: "Default", quantity: 0 }]
        prices: [{ priceList: "Default", value: 1.1568 }]
      ]
    
      clean(adjustments).should.eql expexted