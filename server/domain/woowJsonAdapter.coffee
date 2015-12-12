_ = require("lodash")
SDK = require("producteca-sdk")
Adjustment = SDK.Sync.Adjustment

module.exports =
class WoowJsonAdapter
  adapt: (json) =>
    orEmpty = (str) -> str or ''
    mainPictureUrl = json.pictures[0]
    notes = """
<div class="container_12 title_block grey_border rounded_corners margin_bottom_20"
style="font-family: Arial; color: #444444; width: 92%; margin-left: 4%; margin-right: 4%; margin-bottom: 20px; height: 110px; -webkit-border-radius: 5px; -moz-border-radius: 5px; border-radius: 5px; border: 2px solid #d9dadc;">
<div class="grid_12" style="font-family: Arial; color: #444444; display: inline; float: left; position: relative; margin-left: 1%; margin-right: 1%; width: 98.0%;">
    <p class="text_code" style="font-size: 10px; color: #999; margin: 4px 0 0 0; text-align: right;">
        COD: #{ json.code }</p>
        <h1 style="text-align: center; font-size: 42px; margin: 23px 0 0 0;">
        #{ json.title }</h1>
    </div>
    <div class="clear" style="font-family: Arial; color: #444444; clear: both; display: block; overflow: hidden; visibility: hidden; width: 0; height: 0;">
    </div>
</div>
<div class="container_12 content_block margin_bottom_20" style="font-family: Arial; color: #444444; width: 92%; margin-left: 4%; margin-right: 4%; margin-bottom: 20px;">
<div class="grid_6 image_block" style="font-family: Arial; color: #444444; display: inline; float: left; position: relative; margin-left: 1%; margin-right: 1%; width: 48.0%;">
    <img alt="Imagen de producto" src="#{ mainPictureUrl }"
    width="100%"></div>
    <div class="grid_6 description_block" style="font-family: Arial; color: #444444; display: inline; float: left; position: relative; margin-left: 1%; margin-right: 1%; width: 48.0%;">
    <h1 style="text-align: left; margin: 17px 0 0px 40px; font-size: 25px; letter-spacing: 0.7px;;">
        PRECIO: $ #{ json.coupon_price }</h1>
        <h1 style="text-align: left; margin: 17px 0 0px 40px; font-size: 25px; letter-spacing: 0.7px; color: #025496;">
        #{ json.price_oca }</h1>
        <h2 style="text-align: left; margin: 0px 0px 30px 40px; font-size: 16px; letter-spacing: 0.7px; color: #025496;">
        <br>
        DESCRIPCI&Oacute;N DE LA PUBLICACI&Oacute;N:</h2>#{ json.details }<br>
        #{ json.description }
    </div>
    <div class="clear" style="font-family: Arial; color: #444444; clear: both; display: block; overflow: hidden; visibility: hidden; width: 0; height: 0;">
    </div>
</div>
<div class="container_12 delivery_block grey_border rounded_corners margin_bottom_20"
style="font-family: Arial; color: #444444; width: 92%; margin-left: 4%; margin-right: 4%; margin-bottom: 0; -webkit-border-radius: 5px; -moz-border-radius: 5px; border-radius: 5px; border: 2px solid #d9dadc; border-bottom: 0; border-bottom-right-radius: 0; border-bottom-left-radius: 0;">
<div class="content" style="font-family: Arial; color: #444444; padding-left: 20px; padding-right: 20px;">
    <h2 style="text-align: left; font-size: 16px; margin: 17px 0 0 0; letter-spacing: 0.7px; color: #025496;">
        C&Oacute;MO HACERTE DE TU COMPRA: #{ orEmpty(json.delivery_time) }</h2>
</div>
</div>
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
