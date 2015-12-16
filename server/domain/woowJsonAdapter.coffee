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
<div class="container_12 title_block grey_border rounded_corners margin_bottom_20" id="extincss_4">
    <div class="grid_12" id="extincss_5">
        <p class="text_code" id="extincss_6">COD: #{ json.code }</p>
        <h1 id="extincss_7">#{ json.title }</h1>
    </div>
    <div class="clear" id="extincss_8"></div>
</div>
<div class="container_12 content_block margin_bottom_20" id="extincss_9">
    <div class="grid_6 image_block" id="extincss_10"><img src="#{ mainPictureUrl }" alt="Imagen de producto" width="100%">
    </div>
    <div class="grid_6 description_block" id="extincss_11">
        <h1 id="extincss_12">PRECIO: $ #{ coupon_price }</h1>
        <h1 id="extincss_13">#{ price_oca }</h1>
        <h2 id="extincss_14"><br>DESCRIPCIÓN DE LA PUBLICACIÓN:</h2>     #{ json.description }
    <br><br>#{ json.details }
    </div>
    <div class="clear" id="extincss_15"></div>
</div>
<div class="clear" id="extincss_16"></div>
<div class="container_12 atention_block orange_bg orange_border rounded_corners margin_bottom_20" id="extincss_17">
    <div class="content" id="extincss_18">
        <table id="extincss_19">
            <tbody>
                <tr>
                    <td id="extincss_20"><img src="http://a03c5e2e3ebd1e46d96f-16c9a80647c59aa386db9fc9784890ec.r92.cf2.rackcdn.com/exclamacion.png" alt="ATENCIÓN!">
                    </td>
                    <td id="extincss_21"><span class="white_text" id="extincss_22">PRECIO Y STOCK GARANTIZADO SOLO POR HOY!</span>
                        <br>Al realizar la compra, <span class="yellow_text" id="extincss_23">TE ENVIAREMOS UN MAIL AUTOMÁTICO CON INSTRUCCIONES</span> para
                        <br> que puedas seleccionar la <span id="extincss_24">forma de pago y opción de entrega.<br>Tu compra es un compromiso.</span>
                    </td>
                </tr>
            </tbody>
        </table>
    </div>
</div>
<div class="container_12 transaction_block grey_border grey_bg rounded_corners margin_bottom_20" id="extincss_25">
    <div class="grid_3 price_range transaction_block_pad_top" id="extincss_26">
        <p id="extincss_27">Productos de $0 a $1.000</p>
        <p id="extincss_28">De $1.001 a $2.000</p>
        <p id="extincss_29">De $2.001 a $3.000</p>
        <p id="extincss_30">De $3.001 a $4.000</p>
        <p id="extincss_31">De $4.001 a $5.000</p>
        <p id="extincss_32">De $5.001 a más</p>
    </div>
    <div class="grid_1 transaction_block_pad_top" id="extincss_33">
        <p id="extincss_34">1 cuota</p>
        <p id="extincss_35">2 cuotas</p>
        <p id="extincss_36">3 cuotas</p>
        <p id="extincss_37">4 cuotas</p>
        <p id="extincss_38">5 cuotas</p>
        <p id="extincss_39">6 cuotas</p>
    </div>
    <div class="grid_5 transaction_block_pad_top center_block" id="extincss_40"><img src="http://a03c5e2e3ebd1e46d96f-16c9a80647c59aa386db9fc9784890ec.r92.cf2.rackcdn.com/compra_segura.png" alt="Transacción Segura">
    </div>
    <div class="grid_3 transaction_block_pad_top" id="extincss_41"><img src="http://a03c5e2e3ebd1e46d96f-16c9a80647c59aa386db9fc9784890ec.r92.cf2.rackcdn.com/metodos_de_pago.png" alt="Métodos de pago">
    </div>
</div>
<div class="container_12 delivery_block grey_border rounded_corners margin_bottom_20" id="extincss_42"><div class="content" id="extincss_43">
        <h2 id="extincss_44">#{ orEmpty(json.delivery_date) }</h2>
        <br>
        <center>
            <img src="http://a03c5e2e3ebd1e46d96f-16c9a80647c59aa386db9fc9784890ec.r92.cf2.rackcdn.com/entregas.png" alt="woOw Uruguay">
        </center>
        <p class="muted" id="extincss_45">
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
