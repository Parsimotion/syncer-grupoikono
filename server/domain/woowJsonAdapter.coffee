_ = require("lodash")
SDK = require("producteca-sdk")
Adjustment = SDK.Sync.Adjustment

module.exports =
class WoowJsonAdapter
  adapt: (json) =>
    orEmpty = (str) -> str or ''
    notes = """
    <div class="product-description">#{ orEmpty(json.description) }</div>
    <div class="product-details">#{ orEmpty(json.details) }</div>
    """

    adjustment = new Adjustment
      code: json.code
      brand: json.brand
      category: json.category
      name: json.title
      description: json.title
      identifier: json.sku
      stocks: [{ warehouse: "Default", quantity: (json.quantity or 0) }]
      prices: [{ priceList: "Default", value: json.coupon_price }]
      partNumber: json.buy_url
      pictures: json.pictures.map (url) -> url: url
      notes: notes

    [ adjustment ]
