_ = require("lodash")
SDK = require("producteca-sdk")
Adjustment = SDK.Sync.Adjustment

module.exports =
class WoowJsonAdapter
  adapt: (json) =>
    orEmpty = (str) -> str or ''
    mainPictureUrl = json.pictures[0]
    numberToNiceString = (number) ->
      Math.floor(number).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ".")
    
    coupon_price = numberToNiceString(json.coupon_price)
    try
      priceOcaString = json.price_oca.match(/(?:PAGANDO CON OCA: \$)([\d\.]+)/)[1]
      priceOca = parseFloat priceOcaString
      price_oca = json.price_oca.replace priceOcaString, numberToNiceString(priceOca)
    catch e
      price_oca = json.price_oca
      
    notes = """
    <div class="container_12 title_block grey_border rounded_corners margin_bottom_20" style="font-family: Arial; color: #444444; width: 92%; margin-left: 4%; margin-right: 4%; margin-bottom: 20px; height: 110px; -webkit-border-radius: 5px; -moz-border-radius: 5px; border-radius: 5px; border: 2px solid #d9dadc;">
        <div class="grid_12" style="font-family: Arial; color: #444444; display: inline; float: left; position: relative; margin-left: 1%; margin-right: 1%; width: 98.0%;">
            <p class="text_code" style="font-size: 10px; color: #999; margin: 4px 0 0 0; text-align: right;">COD: #{ json.code }</p>
            <h1 style="text-align: center; font-size: 40px; margin: 23px 0 0 0;">#{ json.title }</h1>
        </div>
        <div class="clear" style="font-family: Arial; color: #444444; clear: both; display: block; overflow: hidden; visibility: hidden; width: 0; height: 0;"></div>
    </div>
    <div class="container_12 content_block margin_bottom_20" style="font-family: Arial; color: #444444; width: 92%; margin-left: 4%; margin-right: 4%; margin-bottom: 20px;">
        <div class="grid_6 image_block" style="font-family: Arial; color: #444444; display: inline; float: left; position: relative; margin-left: 1%; margin-right: 1%; width: 48.0%;"><img src="#{ mainPictureUrl }" alt="Imagen de producto" width="100%" />
        </div>
        <div class="grid_6 description_block" style="font-family: Arial; color: #444444; display: inline; float: left; position: relative; margin-left: 1%; margin-right: 1%; width: 48.0%;">
            <h1 style="text-align: left; margin: 17px 0 0px 40px; font-size: 25px; letter-spacing: 0.7px;;">PRECIO: $ #{ coupon_price }</h1>
            <h1 style="text-align: left; margin: 17px 0 0px 40px; font-size: 25px; letter-spacing: 0.7px; color: #025496;">#{ price_oca }</h1>
            <h2 style="text-align: left; margin: 0px 0px 30px 40px; font-size: 16px; letter-spacing: 0.7px; color: #025496;"><br/>DESCRIPCI&Oacute;N DE LA PUBLICACI&Oacute;N:</h2>     #{ json.description }
        </br></br>#{ json.details }
        </div>
        <div class="clear" style="font-family: Arial; color: #444444; clear: both; display: block; overflow: hidden; visibility: hidden; width: 0; height: 0;"></div>
    </div>
    <div class="clear" style="font-family: Arial; color: #444444; clear: both; display: block; overflow: hidden; visibility: hidden; width: 0; height: 0;"></div>
    <div class="container_12 atention_block orange_bg orange_border rounded_corners margin_bottom_20" style="font-family: Arial; color: #444444; width: 92%; margin-left: 4%; margin-right: 4%; margin-bottom: 20px; -webkit-border-radius: 5px; -moz-border-radius: 5px; border-radius: 5px; border: 2px solid #f89f1d; background: #f89f1d;">
        <div class="content" style="font-family: Arial; color: #fff; padding: 15px 25px;">
            <table style="width: 100%;">
                <tbody>
                    <tr>
                        <td style="font-size: 19px; letter-spacing: 0.4px; font-weight: bold;"><img src="http://a03c5e2e3ebd1e46d96f-16c9a80647c59aa386db9fc9784890ec.r92.cf2.rackcdn.com/exclamacion.png" alt="ATENCI&Oacute;N!" />
                        </td>
                        <td style="font-size: 17px; letter-spacing: 0.4px; font-weight: bold;"><span class="white_text" style="color: #FFFFFF;">PRECIO Y STOCK GARANTIZADO SOLO POR HOY!</span>
                            </br>Al realizar la compra, <span class="yellow_text" style="color: #ffea00;">TE ENVIAREMOS UN MAIL AUTOM&Aacute;TICO CON INSTRUCCIONES</span> para
                            <br /> que puedas seleccionar la <span style="text-decoration: underline;">forma de pago y opci&oacute;n de entrega.</br>Tu compra es un compromiso.</span>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
    <div style="height: 274px;"></div>
    <div class="container_12 delivery_block grey_border rounded_corners margin_bottom_20" style="background-color:#6f8b25; font-family: Arial; color: #444444; width: 92%; margin-left: 4%; margin-right: 4%; margin-bottom: 20px; -webkit-border-radius: 5px; -moz-border-radius: 5px; border-radius: 5px; border: 2px solid #6f8b25; position: absolute; bottom: 701px;"><div class="content" style="font-family: Arial; color: #444444; padding-left: 20px; padding-right: 20px;">
            <h2 style="text-align: left; font-size: 16px; margin: 17px 0 0 0; letter-spacing: 0.7px; color: #fff;">#{ orEmpty(json.delivery_time) }</h2>
            <br/>
            <center>
                <img src="http://a03c5e2e3ebd1e46d96f-16c9a80647c59aa386db9fc9784890ec.r92.cf2.rackcdn.com/entregas.png" alt="woOw Uruguay" />
            </center>
            <p class="muted" style="color: #fff; font-size: 12px;">
                La fecha de entrega prometida es pagando hoy para retirar un nuestro pickup center de pocitos, la misma puede variar según fecha de pago y punto de retiro seleccionado.
                <br>
                Algunas formas de entrega pueden tener costo extra, podrás consultar los mismos al momento de elegir el lugar siguiendo las instrucciones que te enviamos por correo electrónico inmediatamente después de realizada la compra en Mercado Libre.
                <br>
                Atención: sólo se entregan productos, no se realizan ventas en el lugar.
            </p>
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
