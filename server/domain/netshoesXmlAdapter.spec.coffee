NetshoesXmlAdapter = require("./netshoesXmlAdapter")
fs = require("fs")
path = require("path")
_ = require("lodash")
clean = (collection) -> collection.map (o) -> _.omit o, _.isFunction

describe "NetshoesXmlAdapter", ->
  it "can adapt the xml to a list of adjustments", ->
    filename = path.join __dirname, 'netshoes.xml'
    xml = fs.readFileSync filename, 'ascii'
    new NetshoesXmlAdapter().parse(xml).then (adjustments) =>
      expexted = [
        brand: "Umbro"
        category: "Jerseys"
        description: "Jersey Infantil Umbro Cruz Azul Casa 13/14 s/n0"
        identifier: "010-0040-005-08"
        name: "Jersey Infantil Umbro Cruz Azul Casa 13/14 s/n0"
        pictures: [url: "http://images.mx.netshoes.net/mx/produtos/05/010-0040-005/010-0040-005_detalhe1.jpg"]
        stocks: [{ warehouse: "Default", quantity: 0 }]
        prices: [{ priceList: "Default", value: 419 }]
        code: "112789"
      ,
        brand: "Umbro"
        category: "Jerseys"
        description: "Jersey Infantil Umbro Cruz Azul Casa 13/14 s/n0"
        identifier: "010-0040-005-10"
        name: "Jersey Infantil Umbro Cruz Azul Casa 13/14 s/n0"
        pictures: [url: "http://images.mx.netshoes.net/mx/produtos/05/010-0040-005/010-0040-005_detalhe1.jpg"]
        stocks: [{ warehouse: "Default", quantity: 0 }]
        prices: [{ priceList: "Default", value: 419 }]
        code: "112789"
      ,
        brand: "Umbro"
        category: "Jerseys"
        description: "Jersey Infantil Umbro Cruz Azul Casa 13/14 s/n0"
        identifier: "010-0040-005-12"
        name: "Jersey Infantil Umbro Cruz Azul Casa 13/14 s/n0"
        pictures: [url: "http://images.mx.netshoes.net/mx/produtos/05/010-0040-005/010-0040-005_detalhe1.jpg"]
        stocks: [{ warehouse: "Default", quantity: 2 }]
        prices: [{ priceList: "Default", value: 419 }]
        code: "112789"
      ,
        brand: "Umbro"
        category: "Jerseys"
        description: "Jersey Infantil Umbro Cruz Azul Casa 13/14 s/n0"
        identifier: "010-0040-005-14"
        name: "Jersey Infantil Umbro Cruz Azul Casa 13/14 s/n0"
        pictures: [url: "http://images.mx.netshoes.net/mx/produtos/05/010-0040-005/010-0040-005_detalhe1.jpg"]
        stocks: [{ warehouse: "Default", quantity: 0 }]
        prices: [{ priceList: "Default", value: 419 }]
        code: "112789"
      ]
      clean(adjustments).should.eql expexted