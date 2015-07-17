IkonoAdjustmentsAdapter = require("./IkonoAdjustmentsAdapter")

describe "IkonoAdjustmentsAdapter", ->
  it "can adapt the ugly parsed xml to a pretty list of adjustments", ->
    parsedXml =
      Response: ErrorCode: [0]
      Message: ["NO ERROR"]
      TotalItems: ["2"]
      Items: [
        {
          item: [
            { UrbPartNum: ["600001"], UsbDescrip: ["Studio Live 16"], Warehouse01: ["27.0000"], Warehouse02: ["0.0000"], Warehouse03: ["1.0000"], Lista01: ["19909.4991"], Lista02: ["153"], Lista03: ["-1"] }
            { UrbPartNum: ["600050"], UsbDescrip: ["Audiobox!"], Warehouse01: ["47.0000"], Warehouse02: ["0.0000"], Warehouse03: ["0.0000"], Lista01: ["2615.3843"], Lista02: ["-1"], Lista03: ["-1"] }
          ]
        }
      ]

    mappings = [
      { from: "Warehouse01", to: "El primer warehouse" }
      { from: "Warehouse03", to: "El tercer warehouse" }
      { from: "Lista01", to: "La primer priceList" }
      { from: "Lista02", to: "La segunda priceList" }
    ]

    new IkonoAdjustmentsAdapter().adapt(parsedXml, mappings).should.eql [
      {
        identifier: "600001"
        name: "Studio Live 16"
        stocks: [
          { warehouse: "El primer warehouse", quantity: 27 }
          { warehouse: "El tercer warehouse", quantity: 1 }
        ]
        prices: [
          { priceList: "La primer priceList", value: 19909.4991 }
          { priceList: "La segunda priceList", value: 153 }
        ]
      }
    ,
      {
        identifier: "600050"
        name: "Audiobox!"
        stocks: [
          { warehouse: "El primer warehouse", quantity: 47 }
          { warehouse: "El tercer warehouse", quantity: 0 }
        ]
        prices: [
          { priceList: "La primer priceList", value: 2615.3843 }
          # -1 => don't update the price
        ]
      }
    ]
