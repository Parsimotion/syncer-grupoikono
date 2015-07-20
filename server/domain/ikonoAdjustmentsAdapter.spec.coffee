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

    mappings =
      Warehouse01: "El primer warehouse"
      Warehouse03: "El tercer warehouse"
      Lista01: "La primer priceList"
      Lista02: "La segunda priceList"

    new IkonoAdjustmentsAdapter(mappings).adapt(parsedXml).should.eql [
      {
        identifier: "600001"
        name: "Studio Live 16"
        stocks: [
          { warehouse: "El primer warehouse", quantity: "27.0000" }
          { warehouse: "El tercer warehouse", quantity: "1.0000" }
        ]
        prices: [
          { priceList: "La primer priceList", value: "19909.4991" }
          { priceList: "La segunda priceList", value: "153" }
        ]
      }
    ,
      {
        identifier: "600050"
        name: "Audiobox!"
        stocks: [
          { warehouse: "El primer warehouse", quantity: "47.0000" }
          { warehouse: "El tercer warehouse", quantity: "0.0000" }
        ]
        prices: [
          { priceList: "La primer priceList", value: "2615.3843" }
          # -1 => don't update the price
        ]
      }
    ]
