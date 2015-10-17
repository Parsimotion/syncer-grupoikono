nock = require("nock")
NetshoesXmlAdapter = require("./netshoesXmlAdapter")
fs = require("fs")
path = require("path")
_ = require("lodash")
clean = (collection) -> collection.map (o) -> _.omit o, _.isFunction
XmlStreamReader = require('./xmlStreamReader')

describe "NetshoesXmlAdapter", ->
  adjustments = []

  beforeEach ->
    filename = path.join __dirname, 'netshoes.xml'
    domain = 'http://www.netshoes.com.mx'
    url = '/template-resources/export/catalogo.xml'
    xml = fs.readFileSync filename

    nock(domain).get(url).reply 200, xml

    adjustments = []
    options =
      url: domain + url
      element: 'document'
      collect: 'attribute'

    adapter = new NetshoesXmlAdapter()
    new XmlStreamReader().read options, (item) ->
      adjustments = adjustments.concat adapter.adapt item

  it "can adapt the xml to a list of adjustments with numerical size", ->
    expexted = [
      brand: "Umbro"
      category: "Jerseys"
      description: "Jersey Infantil Umbro Cruz Azul Casa 13/14 s/n°"
      identifier: "010-0040-005-08"
      name: "Jersey Infantil Umbro Cruz Azul Casa 13/14 s/n°"
      pictures: [url: "http://images.mx.netshoes.net/mx/produtos/05/010-0040-005/010-0040-005_detalhe1.jpg"]
      primaryColor: "Azul marino"
      secondaryColor: "Blanco"
      size: 8
      stocks: [{ warehouse: "Default", quantity: 0 }]
      prices: [{ priceList: "Default", value: 1419 }]
      code: "112789"
      notes: "Continuando con el estilo característico de la <i>máquina celeste</i>, el Jersey Umbro Cruz Azul Local 13/14 s/n° Infantil, llega para cautivar a todos los pequeños apasionados, al conjunto de la noria. El comienzo de liga MX está por llegar, y las esperanzas de todos los niños recaen nuevamente en éste equipo, que ha sido protagonista en la fase final de cada torneo. La nueva piel está confeccionada en material suave y ligero, posee un diseño ergonómico el cual se adapta al cuerpo de forma natural, facilitando sus movimientos dentro y fuera de las canchas. Además posee inserciones de malla en las axilas, que controlan el sudor manteniéndolos secos y muy cómodos. En cuestión de estilo, sus logos esenciales y color característico de la prenda, sumado al logo bordado en la manga, que los acredita como campeones de la copa MX, los hará ver geniales cada vez que asistan al llamado estadio azul.<li>Jersey Infantil Umbro Cruz Azul local 13/14.<li>Modelo infantil.<li>Sin número.<li>Manga corta.<li>Cuello en especial construcción.<li>Diseño ergonómico que se adapta a la forma del cuerpo.<li>Paneles de malla en axilas.<li>Logo campeón copa MX, estampado en la manga derecha.<li>Logo Umbro lado derecho.<li>Escudo del club lado izquierdo.<li>Diseño en destaque en la parte central.<li>No se recomienda planchar.<li>Tamaños de las tallas (aproximadamente):<br><b>08:</b> 34x45 cm.<br><b>10:</b> 36x47 cm.<br><b>12:</b> 38x49 cm.<br><b>14:</b> 40x51 cm.<br><br><b>Composición:</b> 100% poliéster.<br><b>Garantía del fabricante:</b> contra defecto de fábrica.<BR><BR><BR><BR><br><b>Origen:</b> Nacional"
    ,
      brand: "Umbro"
      category: "Jerseys"
      description: "Jersey Infantil Umbro Cruz Azul Casa 13/14 s/n°"
      identifier: "010-0040-005-10"
      name: "Jersey Infantil Umbro Cruz Azul Casa 13/14 s/n°"
      pictures: [url: "http://images.mx.netshoes.net/mx/produtos/05/010-0040-005/010-0040-005_detalhe1.jpg"]
      primaryColor: "Azul marino"
      secondaryColor: "Blanco"
      size: 10
      stocks: [{ warehouse: "Default", quantity: 0 }]
      prices: [{ priceList: "Default", value: 1419 }]
      code: "112789"
      notes: "Continuando con el estilo característico de la <i>máquina celeste</i>, el Jersey Umbro Cruz Azul Local 13/14 s/n° Infantil, llega para cautivar a todos los pequeños apasionados, al conjunto de la noria. El comienzo de liga MX está por llegar, y las esperanzas de todos los niños recaen nuevamente en éste equipo, que ha sido protagonista en la fase final de cada torneo. La nueva piel está confeccionada en material suave y ligero, posee un diseño ergonómico el cual se adapta al cuerpo de forma natural, facilitando sus movimientos dentro y fuera de las canchas. Además posee inserciones de malla en las axilas, que controlan el sudor manteniéndolos secos y muy cómodos. En cuestión de estilo, sus logos esenciales y color característico de la prenda, sumado al logo bordado en la manga, que los acredita como campeones de la copa MX, los hará ver geniales cada vez que asistan al llamado estadio azul.<li>Jersey Infantil Umbro Cruz Azul local 13/14.<li>Modelo infantil.<li>Sin número.<li>Manga corta.<li>Cuello en especial construcción.<li>Diseño ergonómico que se adapta a la forma del cuerpo.<li>Paneles de malla en axilas.<li>Logo campeón copa MX, estampado en la manga derecha.<li>Logo Umbro lado derecho.<li>Escudo del club lado izquierdo.<li>Diseño en destaque en la parte central.<li>No se recomienda planchar.<li>Tamaños de las tallas (aproximadamente):<br><b>08:</b> 34x45 cm.<br><b>10:</b> 36x47 cm.<br><b>12:</b> 38x49 cm.<br><b>14:</b> 40x51 cm.<br><br><b>Composición:</b> 100% poliéster.<br><b>Garantía del fabricante:</b> contra defecto de fábrica.<BR><BR><BR><BR><br><b>Origen:</b> Nacional"
    ,
      brand: "Umbro"
      category: "Jerseys"
      description: "Jersey Infantil Umbro Cruz Azul Casa 13/14 s/n°"
      identifier: "010-0040-005-12"
      name: "Jersey Infantil Umbro Cruz Azul Casa 13/14 s/n°"
      pictures: [url: "http://images.mx.netshoes.net/mx/produtos/05/010-0040-005/010-0040-005_detalhe1.jpg"]
      primaryColor: "Azul marino"
      secondaryColor: "Blanco"
      size: 12
      stocks: [{ warehouse: "Default", quantity: 2 }]
      prices: [{ priceList: "Default", value: 1419 }]
      code: "112789"
      notes: "Continuando con el estilo característico de la <i>máquina celeste</i>, el Jersey Umbro Cruz Azul Local 13/14 s/n° Infantil, llega para cautivar a todos los pequeños apasionados, al conjunto de la noria. El comienzo de liga MX está por llegar, y las esperanzas de todos los niños recaen nuevamente en éste equipo, que ha sido protagonista en la fase final de cada torneo. La nueva piel está confeccionada en material suave y ligero, posee un diseño ergonómico el cual se adapta al cuerpo de forma natural, facilitando sus movimientos dentro y fuera de las canchas. Además posee inserciones de malla en las axilas, que controlan el sudor manteniéndolos secos y muy cómodos. En cuestión de estilo, sus logos esenciales y color característico de la prenda, sumado al logo bordado en la manga, que los acredita como campeones de la copa MX, los hará ver geniales cada vez que asistan al llamado estadio azul.<li>Jersey Infantil Umbro Cruz Azul local 13/14.<li>Modelo infantil.<li>Sin número.<li>Manga corta.<li>Cuello en especial construcción.<li>Diseño ergonómico que se adapta a la forma del cuerpo.<li>Paneles de malla en axilas.<li>Logo campeón copa MX, estampado en la manga derecha.<li>Logo Umbro lado derecho.<li>Escudo del club lado izquierdo.<li>Diseño en destaque en la parte central.<li>No se recomienda planchar.<li>Tamaños de las tallas (aproximadamente):<br><b>08:</b> 34x45 cm.<br><b>10:</b> 36x47 cm.<br><b>12:</b> 38x49 cm.<br><b>14:</b> 40x51 cm.<br><br><b>Composición:</b> 100% poliéster.<br><b>Garantía del fabricante:</b> contra defecto de fábrica.<BR><BR><BR><BR><br><b>Origen:</b> Nacional"
    ,
      brand: "Umbro"
      category: "Jerseys"
      description: "Jersey Infantil Umbro Cruz Azul Casa 13/14 s/n°"
      identifier: "010-0040-005-14"
      name: "Jersey Infantil Umbro Cruz Azul Casa 13/14 s/n°"
      pictures: [url: "http://images.mx.netshoes.net/mx/produtos/05/010-0040-005/010-0040-005_detalhe1.jpg"]
      primaryColor: "Azul marino"
      secondaryColor: "Blanco"
      size: 14
      stocks: [{ warehouse: "Default", quantity: 1 }]
      prices: [{ priceList: "Default", value: 1419 }]
      code: "112789"
      notes: "Continuando con el estilo característico de la <i>máquina celeste</i>, el Jersey Umbro Cruz Azul Local 13/14 s/n° Infantil, llega para cautivar a todos los pequeños apasionados, al conjunto de la noria. El comienzo de liga MX está por llegar, y las esperanzas de todos los niños recaen nuevamente en éste equipo, que ha sido protagonista en la fase final de cada torneo. La nueva piel está confeccionada en material suave y ligero, posee un diseño ergonómico el cual se adapta al cuerpo de forma natural, facilitando sus movimientos dentro y fuera de las canchas. Además posee inserciones de malla en las axilas, que controlan el sudor manteniéndolos secos y muy cómodos. En cuestión de estilo, sus logos esenciales y color característico de la prenda, sumado al logo bordado en la manga, que los acredita como campeones de la copa MX, los hará ver geniales cada vez que asistan al llamado estadio azul.<li>Jersey Infantil Umbro Cruz Azul local 13/14.<li>Modelo infantil.<li>Sin número.<li>Manga corta.<li>Cuello en especial construcción.<li>Diseño ergonómico que se adapta a la forma del cuerpo.<li>Paneles de malla en axilas.<li>Logo campeón copa MX, estampado en la manga derecha.<li>Logo Umbro lado derecho.<li>Escudo del club lado izquierdo.<li>Diseño en destaque en la parte central.<li>No se recomienda planchar.<li>Tamaños de las tallas (aproximadamente):<br><b>08:</b> 34x45 cm.<br><b>10:</b> 36x47 cm.<br><b>12:</b> 38x49 cm.<br><b>14:</b> 40x51 cm.<br><br><b>Composición:</b> 100% poliéster.<br><b>Garantía del fabricante:</b> contra defecto de fábrica.<BR><BR><BR><BR><br><b>Origen:</b> Nacional"
    ]
    clean(_.take adjustments, 4).should.eql expexted

  it "can adapt the xml to a list of adjustments with fixed size", ->
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
      prices: [{ priceList: "Default", value: 1799 }]
      code: "129520"
      notes: "Prepárate al estilo de los jugadores <i>cementeros</i> con la Playera Under Armour Cruz Azul Training. El sobrio diseño, que presenta cuello de construcción especial y manga corta, incorpora tecnología <i>HeatGear</i> que ayudará a que te mantengas seco y ligero durante tus rutinas de ejercicio. El escudo del equipo se encuentra a la izquierda del pecho, mientras que el logo de la marca a la derecha, distintivos que la hacen una atractiva pieza para el seguidor <i>cruzazulino</i>. Porque las leyendas de la <i>máquina celeste</i> se forjaron en cada entrenamiento. <li>Playera Under Armour Cruz Azul Training. <li>Modelo masculino. <li>Cuello de construcción especial. <li>Manga corta. <li>Tecnología <i>HeatGear</i>. <li>Escudo del club. <li>Logo de la marca. <li>Tamaños de las tallas (aproximadamente): <br><b>CH:</b> 42x71 cm. <br><b>M:</b> 44x73 cm. <br><b>G:</b> 46x75 cm. <br><b>XG:</b> 48x77 cm. <br><br><b>Composición:</b> poliéster. <br><b> Garantía del fabricante:</b> contra defecto de fábrica.<br><b>Origen:</b> Importado"
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
      prices: [{ priceList: "Default", value: 1799 }]
      code: "129520"
      notes: "Prepárate al estilo de los jugadores <i>cementeros</i> con la Playera Under Armour Cruz Azul Training. El sobrio diseño, que presenta cuello de construcción especial y manga corta, incorpora tecnología <i>HeatGear</i> que ayudará a que te mantengas seco y ligero durante tus rutinas de ejercicio. El escudo del equipo se encuentra a la izquierda del pecho, mientras que el logo de la marca a la derecha, distintivos que la hacen una atractiva pieza para el seguidor <i>cruzazulino</i>. Porque las leyendas de la <i>máquina celeste</i> se forjaron en cada entrenamiento. <li>Playera Under Armour Cruz Azul Training. <li>Modelo masculino. <li>Cuello de construcción especial. <li>Manga corta. <li>Tecnología <i>HeatGear</i>. <li>Escudo del club. <li>Logo de la marca. <li>Tamaños de las tallas (aproximadamente): <br><b>CH:</b> 42x71 cm. <br><b>M:</b> 44x73 cm. <br><b>G:</b> 46x75 cm. <br><b>XG:</b> 48x77 cm. <br><br><b>Composición:</b> poliéster. <br><b> Garantía del fabricante:</b> contra defecto de fábrica.<br><b>Origen:</b> Importado"
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
      prices: [{ priceList: "Default", value: 1799 }]
      code: "129520"
      notes: "Prepárate al estilo de los jugadores <i>cementeros</i> con la Playera Under Armour Cruz Azul Training. El sobrio diseño, que presenta cuello de construcción especial y manga corta, incorpora tecnología <i>HeatGear</i> que ayudará a que te mantengas seco y ligero durante tus rutinas de ejercicio. El escudo del equipo se encuentra a la izquierda del pecho, mientras que el logo de la marca a la derecha, distintivos que la hacen una atractiva pieza para el seguidor <i>cruzazulino</i>. Porque las leyendas de la <i>máquina celeste</i> se forjaron en cada entrenamiento. <li>Playera Under Armour Cruz Azul Training. <li>Modelo masculino. <li>Cuello de construcción especial. <li>Manga corta. <li>Tecnología <i>HeatGear</i>. <li>Escudo del club. <li>Logo de la marca. <li>Tamaños de las tallas (aproximadamente): <br><b>CH:</b> 42x71 cm. <br><b>M:</b> 44x73 cm. <br><b>G:</b> 46x75 cm. <br><b>XG:</b> 48x77 cm. <br><br><b>Composición:</b> poliéster. <br><b> Garantía del fabricante:</b> contra defecto de fábrica.<br><b>Origen:</b> Importado"
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
      prices: [{ priceList: "Default", value: 1799 }]
      code: "129520"
      notes: "Prepárate al estilo de los jugadores <i>cementeros</i> con la Playera Under Armour Cruz Azul Training. El sobrio diseño, que presenta cuello de construcción especial y manga corta, incorpora tecnología <i>HeatGear</i> que ayudará a que te mantengas seco y ligero durante tus rutinas de ejercicio. El escudo del equipo se encuentra a la izquierda del pecho, mientras que el logo de la marca a la derecha, distintivos que la hacen una atractiva pieza para el seguidor <i>cruzazulino</i>. Porque las leyendas de la <i>máquina celeste</i> se forjaron en cada entrenamiento. <li>Playera Under Armour Cruz Azul Training. <li>Modelo masculino. <li>Cuello de construcción especial. <li>Manga corta. <li>Tecnología <i>HeatGear</i>. <li>Escudo del club. <li>Logo de la marca. <li>Tamaños de las tallas (aproximadamente): <br><b>CH:</b> 42x71 cm. <br><b>M:</b> 44x73 cm. <br><b>G:</b> 46x75 cm. <br><b>XG:</b> 48x77 cm. <br><br><b>Composición:</b> poliéster. <br><b> Garantía del fabricante:</b> contra defecto de fábrica.<br><b>Origen:</b> Importado"
    ]
    clean(adjustments.slice 4, 8).should.eql expexted

  it "can adapt the xml to a single product", ->
    expexted = [
      brand: "Under Armour"
      category: "Gorras"
      description: "Gorra Under Armour Original Skull Ii"
      identifier: "181-0135-129-01"
      name: "Gorra Under Armour Original Skull Ii"
      pictures: [url: "http://images.mx.netshoes.net/mx/produtos/29/181-0135-129/181-0135-129_detalhe1.jpg"]
      stocks: [{ warehouse: "Default", quantity: 5 }]
      prices: [{ priceList: "Default", value: 1299 }]
      code: "128939"
      notes: "Salta al <i>emparrillado</i> con los mejores accesorios y dispuesto a vencer al rival, portando la Gorra Under Armour Original Skull Ii. Su increíble diseño llamativo, está confeccionado con tecnología <i>HeatGear</i>, que absorbe el sudor y es de secado rápido. La banda elástica, proporciona un ajuste personalizado. El sistema anti olor previene el crecimiento de microbios. Por último, la fabricación <i>4-Way Stretch</i>, permite mayor movilidad y mantiene la forma.<li>Gorra Under Armour Original Skull Ii.<li>Modelo masculino.<li>Tecnología <i>HeatGear</i>.<li>Sistema anti olor.<li>Banda elástica de ajuste.<li>Fabricación <i>4-Way Stretch</i>.<br><br><b>Composición:</b> poliéster / elastano.<br><b>Garantía del fabricante:</b> contra defecto de fábrica.<br><b>Origen:</b> Importado"
    ]
    clean(adjustments.slice 8, 9).should.eql expexted

  it "should add shipping cost (58) when price is under 900", ->
    expexted = [
      brand: "Under Armour"
      category: "Gorras"
      description: "Gorra Under Armour Original Skull Ii"
      identifier: "181-0135-129-01"
      name: "Gorra Under Armour Original Skull Ii"
      pictures: [url: "http://images.mx.netshoes.net/mx/produtos/29/181-0135-129/181-0135-129_detalhe1.jpg"]
      stocks: [{ warehouse: "Default", quantity: 5 }]
      prices: [{ priceList: "Default", value: 357 }]
      code: "128939"
      notes: "Salta al <i>emparrillado</i> con los mejores accesorios y dispuesto a vencer al rival, portando la Gorra Under Armour Original Skull Ii. Su increíble diseño llamativo, está confeccionado con tecnología <i>HeatGear</i>, que absorbe el sudor y es de secado rápido. La banda elástica, proporciona un ajuste personalizado. El sistema anti olor previene el crecimiento de microbios. Por último, la fabricación <i>4-Way Stretch</i>, permite mayor movilidad y mantiene la forma.<li>Gorra Under Armour Original Skull Ii.<li>Modelo masculino.<li>Tecnología <i>HeatGear</i>.<li>Sistema anti olor.<li>Banda elástica de ajuste.<li>Fabricación <i>4-Way Stretch</i>.<br><br><b>Composición:</b> poliéster / elastano.<br><b>Garantía del fabricante:</b> contra defecto de fábrica.<br><b>Origen:</b> Importado"
    ]
    clean(adjustments.slice 9, 10).should.eql expexted      