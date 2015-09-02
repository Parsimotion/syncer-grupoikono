MotomelXmlAdapter = require("./motomelXmlAdapter")
fs = require("fs")
path = require("path")
_ = require("lodash")
clean = (collection) -> collection.map (o) -> _.omit o, _.isFunction

describe "MotomelXmlAdapter", ->
  it "can adapt the xml to a list of adjustments", ->
    filename = path.join __dirname, 'stocksAndPrices.xml'
    xml = fs.readFileSync filename, 'utf8'

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
    
    new MotomelXmlAdapter().parse(xml).then (adjustments) ->
      clean(adjustments).should.eql expexted
