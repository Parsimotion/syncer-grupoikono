NetshoesXmlAdapter = require("./netshoesXmlAdapter")
fs = require("fs")
path = require("path")
_ = require("lodash")
clean = (collection) -> collection.map (o) -> _.omit o, _.isFunction

describe "NetshoesXmlAdapter", ->
  it "can adapt the xml to a list of adjustments with numerical size", ->
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
        primaryColor: "Azul marino"
        secondaryColor: "Blanco"
        size: 8
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
        primaryColor: "Azul marino"
        secondaryColor: "Blanco"
        size: 10
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
        primaryColor: "Azul marino"
        secondaryColor: "Blanco"
        size: 12
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
        primaryColor: "Azul marino"
        secondaryColor: "Blanco"
        size: 14
        stocks: [{ warehouse: "Default", quantity: 1 }]
        prices: [{ priceList: "Default", value: 419 }]
        code: "112789"
      ]
      clean(_.take adjustments, 4).should.eql expexted

  it "can adapt the xml to a list of adjustments with fixed size", ->
    filename = path.join __dirname, 'netshoes.xml'
    xml = fs.readFileSync filename, 'ascii'
    new NetshoesXmlAdapter().parse(xml).then (adjustments) =>
      expexted = [
        brand: "Under Armour"
        category: "Camisetas"
        description: "Playera Under Armour Cruz Azul Training"
        identifier: "181-0177-005-02"
        name: "Playera Under Armour Cruz Azul Training"
        pictures: [url: "http://images.mx.netshoes.net/mx/produtos/05/181-0177-005/181-0177-005_detalhe1.jpg"]
        primaryColor: "Plateado"
        secondaryColor: undefined
        size: "S"
        stocks: [{ warehouse: "Default", quantity: 0 }]
        prices: [{ priceList: "Default", value: 799 }]
        code: "129520"
      ,
        brand: "Under Armour"
        category: "Camisetas"
        description: "Playera Under Armour Cruz Azul Training"
        identifier: "181-0177-005-03"
        name: "Playera Under Armour Cruz Azul Training"
        pictures: [url: "http://images.mx.netshoes.net/mx/produtos/05/181-0177-005/181-0177-005_detalhe1.jpg"]
        primaryColor: "Plateado"
        secondaryColor: undefined
        size: "M"
        stocks: [{ warehouse: "Default", quantity: 4 }]
        prices: [{ priceList: "Default", value: 799 }]
        code: "129520"
      ,
        brand: "Under Armour"
        category: "Camisetas"
        description: "Playera Under Armour Cruz Azul Training"
        identifier: "181-0177-005-04"
        name: "Playera Under Armour Cruz Azul Training"
        pictures: [url: "http://images.mx.netshoes.net/mx/produtos/05/181-0177-005/181-0177-005_detalhe1.jpg"]
        primaryColor: "Plateado"
        secondaryColor: undefined
        size: "L"
        stocks: [{ warehouse: "Default", quantity: 13 }]
        prices: [{ priceList: "Default", value: 799 }]
        code: "129520"
      ,
        brand: "Under Armour"
        category: "Camisetas"
        description: "Playera Under Armour Cruz Azul Training"
        identifier: "181-0177-005-05"
        name: "Playera Under Armour Cruz Azul Training"
        pictures: [url: "http://images.mx.netshoes.net/mx/produtos/05/181-0177-005/181-0177-005_detalhe1.jpg"]
        primaryColor: "Plateado"
        secondaryColor: undefined
        size: "XL"
        stocks: [{ warehouse: "Default", quantity: 6 }]
        prices: [{ priceList: "Default", value: 799 }]
        code: "129520"
      ]
      clean(adjustments.slice 4).should.eql expexted