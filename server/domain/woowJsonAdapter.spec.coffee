JsonStreamReader = require("./jsonStreamReader")
WoowJsonAdapter = require("./woowJsonAdapter")
_ = require("lodash")
path = require("path")
fs = require("fs")
nock = require("nock")

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
        notes: "<div class=\"product-description\"><b>Absorbe mucho más que las toallas comunes</b><br/><b>Peso: </b>260g.<br/><b>Medida:</b> 140 cm. x 70 cm.<br/><b>Disponible en:</b><br/>- Azul<br/><b>Composición: </b>100% polyester.<br/></div>\n<div class=\"product-details\">Toalla de microfibra, tendencia en los últimos años!<br/>¿Por qué? La toalla de microfibra requiere poco espacio físico para guardarse. <br/>A su vez, es especialmente útil para su transporte y uso fuera del ámbito doméstico.<br/>Su absorción es óptima y seca más que el algodón.<br/>Ideal para llevar al gimnasio, la piscina, o al camping!<br/>El principal secreto de ese tipo de toallas es su composición, las fibras son casi tres veces menores a las convencionales que componen las toallas de algodón.<br/>Tienen una gran resistencia a los lavados frecuentes y no quedan acartonadas.<br/>No se arrugan.<br/><span> <b>Importante:</b> a la hora del lavado se aconseja separar las prendas blancas de las de color. Este producto podría desteñir en sus primeros lavados</span><br/></div>"
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
        notes: "<div class=\"product-description\">Medidas tulipa: 15 x 17 cm. - Tulipa simil mimbre</div>\n<div class=\"product-details\"><ul><li><b>Lámpara de suspensión rústica.</b><br/></li><li>Materiales delicados y elegantes.</li><li>Detalles:</li><li>Tres plafones en forma de tulipa con entramado símil mimbre.</li><li>Interior: vidrio blanco.</li><li>Medidas tulipa: 17 x 15 cm.</li><li><b>Colores disponibles:</b></li><li>Marrón.</li><li>Blanco.</li><li>Alturas regulables a gusto.</li><li>¡Ideas..!</li><li>Baja: Colgala sobre una mesa de comedor.</li><li>Larga: vestí tu living creando un ambiente cálido y elegante.</li><li><b>La lámpara se entrega desarmada.</b></li><li>La imagen es ilustrativa. Algunos detalles del producto pueden diferir de la imagen<br/></li></ul></div>"
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
        notes: "<div class=\"product-description\"><ul><li>Diseño ergonómico, en materiales antideslizantes.</li><li>Con posición para llegar a los lugares más difíciles</li></ul></div>\n<div class=\"product-details\"><ul><li><b>Destornillador a batería con 6 puntas.</b></li><li>6 puntas incorporadas en el mismo destornillador.</li><li>Posición para atornillar y destornillar.</li><li>Luz led asistente.</li><li>Funciona a batería. (Incluye cargador).</li><li>Puedes utilizarlo a 90° o a casi 180° girando el mango.<br/></li></ul></div>"
       ]

    clean(adjustments).should.eql expected
