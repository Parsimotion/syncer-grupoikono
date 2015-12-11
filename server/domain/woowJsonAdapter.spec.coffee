JsonStreamReader = require("./jsonStreamReader")
WoowJsonAdapter = require("./woowJsonAdapter")
_ = require("lodash")
path = require("path")
fs = require("fs")
nock = require("nock")
Promise = require("bluebird")

clean = (collection) -> collection.map (o) -> _.omit o, _.isFunction

describe 'WoowJsonAdapter', ->
  adjustments = []

  beforeEach ->
    filename = path.join __dirname, 'woow.json'
    domain = 'https://imagesproducteca.blob.core.windows.net'
    url = '/jsons/woow.json'
    json = fs.readFileSync filename

    nock(domain).get(url).reply 200, json

    adjustments = []
    options =
      url: domain + url

    adapter = new WoowJsonAdapter()
    new JsonStreamReader().read options, (item) ->
      Promise.resolve adjustments = adjustments.concat adapter.adapt item

  it 'can adapt a json to a product', ->
    expected =
      [
        code: "132934"
        brand: "woOw"
        category: "Toallas"
        name: "Toalla de microfibra de rápido secado color blanca"
        description: "Toalla de microfibra de rápido secado color blanca"
        identifier: "CJTX1110562"
        stocks: [{ warehouse: "Default", quantity: 420 }]
        prices: [{ priceList: "Default", value: 250 }]
        partNumber: "http://www.woow.com.uy/frontend/buy/index/132934/1?utm_campaign=ML_Sale&utm_source=MercadoLibre&utm_term=132934&utm_medium=satellite"
        pictures: [ url: "https://68b70847b87fa4ca414b-2a9b9aa40f6a1fb4934d31fcacd61214.ssl.cf2.rackcdn.com/e0/0e/e00e7c26ed586693507729504d585f27_630x315.jpg" ]
        notes: "<div class=\"container_12 title_block grey_border rounded_corners margin_bottom_20\"\nstyle=\"font-family: Arial; color: #444444; width: 92%; margin-left: 4%; margin-right: 4%; margin-bottom: 20px; height: 110px; -webkit-border-radius: 5px; -moz-border-radius: 5px; border-radius: 5px; border: 2px solid #d9dadc;\">\n<div class=\"grid_12\" style=\"font-family: Arial; color: #444444; display: inline; float: left; position: relative; margin-left: 1%; margin-right: 1%; width: 98.0%;\">\n    <p class=\"text_code\" style=\"font-size: 10px; color: #999; margin: 4px 0 0 0; text-align: right;\">\n        COD: 132934</p>\n        <h1 style=\"text-align: center; font-size: 42px; margin: 23px 0 0 0;\">\n        Toalla de microfibra de rápido secado color blanca</h1>\n    </div>\n    <div class=\"clear\" style=\"font-family: Arial; color: #444444; clear: both; display: block; overflow: hidden; visibility: hidden; width: 0; height: 0;\">\n    </div>\n</div>\n<div class=\"container_12 content_block margin_bottom_20\" style=\"font-family: Arial; color: #444444; width: 92%; margin-left: 4%; margin-right: 4%; margin-bottom: 20px;\">\n<div class=\"grid_6 image_block\" style=\"font-family: Arial; color: #444444; display: inline; float: left; position: relative; margin-left: 1%; margin-right: 1%; width: 48.0%;\">\n    <img alt=\"Imagen de producto\" src=\"https://68b70847b87fa4ca414b-2a9b9aa40f6a1fb4934d31fcacd61214.ssl.cf2.rackcdn.com/e0/0e/e00e7c26ed586693507729504d585f27_630x315.jpg\"\n    width=\"100%\"></div>\n    <div class=\"grid_6 description_block\" style=\"font-family: Arial; color: #444444; display: inline; float: left; position: relative; margin-left: 1%; margin-right: 1%; width: 48.0%;\">\n    <h1 style=\"text-align: left; margin: 17px 0 0px 40px; font-size: 25px; letter-spacing: 0.7px;;\">\n        PRECIO: $ undefined</h1>\n        <h1 style=\"text-align: left; margin: 17px 0 0px 40px; font-size: 25px; letter-spacing: 0.7px; color: #025496;\">\n        undefined</h1>\n        <h2 style=\"text-align: left; margin: 0px 0px 30px 40px; font-size: 16px; letter-spacing: 0.7px; color: #025496;\">\n        <br>\n        DESCRIPCI&Oacute;N DE LA PUBLICACI&Oacute;N:</h2>Toalla de microfibra, tendencia en los últimos años!<br/>¿Por qué? La toalla de microfibra requiere poco espacio físico para guardarse. <br/>A su vez, es especialmente útil para su transporte y uso fuera del ámbito doméstico.<br/>Su absorción es óptima y seca más que el algodón.<br/>Ideal para llevar al gimnasio, la piscina, o al camping!<br/>El principal secreto de ese tipo de toallas es su composición, las fibras son casi tres veces menores a las convencionales que componen las toallas de algodón.<br/>Tienen una gran resistencia a los lavados frecuentes y no quedan acartonadas.<br/>No se arrugan.<br/><span> <b>Importante:</b> a la hora del lavado se aconseja separar las prendas blancas de las de color. Este producto podría desteñir en sus primeros lavados</span><br/><br>\n        <b>Absorbe mucho más que las toallas comunes</b><br/><b>Peso: </b>260g.<br/><b>Medida:</b> 140 cm. x 70 cm.<br/><b>Disponible en:</b><br/>- Azul<br/><b>Composición: </b>100% polyester.<br/>\n    </div>\n    <div class=\"clear\" style=\"font-family: Arial; color: #444444; clear: both; display: block; overflow: hidden; visibility: hidden; width: 0; height: 0;\">\n    </div>\n</div>"
      ,
        code: "132945"
        brand: "woOw"
        category: "Iluminación"
        name: "Lámpara de suspensión blanco"
        description: "Lámpara de suspensión blanco"
        identifier: "CJXX1111124"
        stocks: [{ warehouse: "Default", quantity: 0 }]
        prices: [{ priceList: "Default", value: 1660 }]
        partNumber: "http://www.woow.com.uy/frontend/buy/index/132945/1?utm_campaign=ML_Sale&utm_source=MercadoLibre&utm_term=132945&utm_medium=satellite"
        pictures: [ url: "https://68b70847b87fa4ca414b-2a9b9aa40f6a1fb4934d31fcacd61214.ssl.cf2.rackcdn.com/d2/25/d22592fc5b9c5b02593d242c155edea9_630x315.jpg" ]
        notes: "<div class=\"container_12 title_block grey_border rounded_corners margin_bottom_20\"\nstyle=\"font-family: Arial; color: #444444; width: 92%; margin-left: 4%; margin-right: 4%; margin-bottom: 20px; height: 110px; -webkit-border-radius: 5px; -moz-border-radius: 5px; border-radius: 5px; border: 2px solid #d9dadc;\">\n<div class=\"grid_12\" style=\"font-family: Arial; color: #444444; display: inline; float: left; position: relative; margin-left: 1%; margin-right: 1%; width: 98.0%;\">\n    <p class=\"text_code\" style=\"font-size: 10px; color: #999; margin: 4px 0 0 0; text-align: right;\">\n        COD: 132945</p>\n        <h1 style=\"text-align: center; font-size: 42px; margin: 23px 0 0 0;\">\n        Lámpara de suspensión blanco</h1>\n    </div>\n    <div class=\"clear\" style=\"font-family: Arial; color: #444444; clear: both; display: block; overflow: hidden; visibility: hidden; width: 0; height: 0;\">\n    </div>\n</div>\n<div class=\"container_12 content_block margin_bottom_20\" style=\"font-family: Arial; color: #444444; width: 92%; margin-left: 4%; margin-right: 4%; margin-bottom: 20px;\">\n<div class=\"grid_6 image_block\" style=\"font-family: Arial; color: #444444; display: inline; float: left; position: relative; margin-left: 1%; margin-right: 1%; width: 48.0%;\">\n    <img alt=\"Imagen de producto\" src=\"https://68b70847b87fa4ca414b-2a9b9aa40f6a1fb4934d31fcacd61214.ssl.cf2.rackcdn.com/d2/25/d22592fc5b9c5b02593d242c155edea9_630x315.jpg\"\n    width=\"100%\"></div>\n    <div class=\"grid_6 description_block\" style=\"font-family: Arial; color: #444444; display: inline; float: left; position: relative; margin-left: 1%; margin-right: 1%; width: 48.0%;\">\n    <h1 style=\"text-align: left; margin: 17px 0 0px 40px; font-size: 25px; letter-spacing: 0.7px;;\">\n        PRECIO: $ undefined</h1>\n        <h1 style=\"text-align: left; margin: 17px 0 0px 40px; font-size: 25px; letter-spacing: 0.7px; color: #025496;\">\n        undefined</h1>\n        <h2 style=\"text-align: left; margin: 0px 0px 30px 40px; font-size: 16px; letter-spacing: 0.7px; color: #025496;\">\n        <br>\n        DESCRIPCI&Oacute;N DE LA PUBLICACI&Oacute;N:</h2><ul><li><b>Lámpara de suspensión rústica.</b><br/></li><li>Materiales delicados y elegantes.</li><li>Detalles:</li><li>Tres plafones en forma de tulipa con entramado símil mimbre.</li><li>Interior: vidrio blanco.</li><li>Medidas tulipa: 17 x 15 cm.</li><li><b>Colores disponibles:</b></li><li>Marrón.</li><li>Blanco.</li><li>Alturas regulables a gusto.</li><li>¡Ideas..!</li><li>Baja: Colgala sobre una mesa de comedor.</li><li>Larga: vestí tu living creando un ambiente cálido y elegante.</li><li><b>La lámpara se entrega desarmada.</b></li><li>La imagen es ilustrativa. Algunos detalles del producto pueden diferir de la imagen<br/></li></ul><br>\n        Medidas tulipa: 15 x 17 cm. - Tulipa simil mimbre\n    </div>\n    <div class=\"clear\" style=\"font-family: Arial; color: #444444; clear: both; display: block; overflow: hidden; visibility: hidden; width: 0; height: 0;\">\n    </div>\n</div>"
      ,
        code: "135603"
        brand: "woOw"
        category: "Ferretería"
        name: "Destornillador a batería con 6 puntas"
        description: "Destornillador a batería con 6 puntas"
        identifier: "CJXX1111129"
        stocks: [{ warehouse: "Default", quantity: 0 }]
        prices: [{ priceList: "Default", value: 890 }]
        partNumber: "http://www.woow.com.uy/frontend/buy/index/135603/1?utm_campaign=ML_Sale&utm_source=MercadoLibre&utm_term=135603&utm_medium=satellite"
        pictures: [
          url: "https://68b70847b87fa4ca414b-2a9b9aa40f6a1fb4934d31fcacd61214.ssl.cf2.rackcdn.com/11/ab/11abb4ca848020238cd5464c76515ee7_630x315.jpg"
        ,
          url: "https://68b70847b87fa4ca414b-2a9b9aa40f6a1fb4934d31fcacd61214.ssl.cf2.rackcdn.com/8b/f4/8bf480fefc6e42f7dea5e59cec7ef19d_630x315.jpg"
        ,
          url: "https://68b70847b87fa4ca414b-2a9b9aa40f6a1fb4934d31fcacd61214.ssl.cf2.rackcdn.com/5c/e9/5ce9f675789e5c602d11f6000634e1bc_630x315.jpg"
         ]
        notes: "<div class=\"container_12 title_block grey_border rounded_corners margin_bottom_20\"\nstyle=\"font-family: Arial; color: #444444; width: 92%; margin-left: 4%; margin-right: 4%; margin-bottom: 20px; height: 110px; -webkit-border-radius: 5px; -moz-border-radius: 5px; border-radius: 5px; border: 2px solid #d9dadc;\">\n<div class=\"grid_12\" style=\"font-family: Arial; color: #444444; display: inline; float: left; position: relative; margin-left: 1%; margin-right: 1%; width: 98.0%;\">\n    <p class=\"text_code\" style=\"font-size: 10px; color: #999; margin: 4px 0 0 0; text-align: right;\">\n        COD: 135603</p>\n        <h1 style=\"text-align: center; font-size: 42px; margin: 23px 0 0 0;\">\n        Destornillador a batería con 6 puntas</h1>\n    </div>\n    <div class=\"clear\" style=\"font-family: Arial; color: #444444; clear: both; display: block; overflow: hidden; visibility: hidden; width: 0; height: 0;\">\n    </div>\n</div>\n<div class=\"container_12 content_block margin_bottom_20\" style=\"font-family: Arial; color: #444444; width: 92%; margin-left: 4%; margin-right: 4%; margin-bottom: 20px;\">\n<div class=\"grid_6 image_block\" style=\"font-family: Arial; color: #444444; display: inline; float: left; position: relative; margin-left: 1%; margin-right: 1%; width: 48.0%;\">\n    <img alt=\"Imagen de producto\" src=\"https://68b70847b87fa4ca414b-2a9b9aa40f6a1fb4934d31fcacd61214.ssl.cf2.rackcdn.com/11/ab/11abb4ca848020238cd5464c76515ee7_630x315.jpg\"\n    width=\"100%\"></div>\n    <div class=\"grid_6 description_block\" style=\"font-family: Arial; color: #444444; display: inline; float: left; position: relative; margin-left: 1%; margin-right: 1%; width: 48.0%;\">\n    <h1 style=\"text-align: left; margin: 17px 0 0px 40px; font-size: 25px; letter-spacing: 0.7px;;\">\n        PRECIO: $ undefined</h1>\n        <h1 style=\"text-align: left; margin: 17px 0 0px 40px; font-size: 25px; letter-spacing: 0.7px; color: #025496;\">\n        undefined</h1>\n        <h2 style=\"text-align: left; margin: 0px 0px 30px 40px; font-size: 16px; letter-spacing: 0.7px; color: #025496;\">\n        <br>\n        DESCRIPCI&Oacute;N DE LA PUBLICACI&Oacute;N:</h2><ul><li><b>Destornillador a batería con 6 puntas.</b></li><li>6 puntas incorporadas en el mismo destornillador.</li><li>Posición para atornillar y destornillar.</li><li>Luz led asistente.</li><li>Funciona a batería. (Incluye cargador).</li><li>Puedes utilizarlo a 90° o a casi 180° girando el mango.<br/></li></ul><br>\n        <ul><li>Diseño ergonómico, en materiales antideslizantes.</li><li>Con posición para llegar a los lugares más difíciles</li></ul>\n    </div>\n    <div class=\"clear\" style=\"font-family: Arial; color: #444444; clear: both; display: block; overflow: hidden; visibility: hidden; width: 0; height: 0;\">\n    </div>\n</div>"
       ]

    clean(adjustments).should.eql expected
