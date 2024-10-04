import 'package:hive/hive.dart';

class ProductUtils {
  static List<Map<String, dynamic>> loadProducts() {

    Box<Map<String, dynamic>> productBox = Hive.box('productBox');

    Iterable keys = productBox.keys;

    List<Map<String, dynamic>> products = [];
    for (String key in keys) {
      var product = productBox.get(key);
      if (product is Map<String, dynamic>) {
        products.add(product);
      }
    }

    return products;
  }

  static Future<void> saveProducts() async {
    Box<Map<String, dynamic>> productBox = Hive.box('productBox');

    await productBox.clear();

    // Bolsa de leche
    Map<String, dynamic> leche = {
      'name': 'Bolsa de Leche',
      'value': 5500,
      'route': 'assets/productos/leche.png'
    };

    productBox.put('leche', leche);


    // Docena de huevos
    Map<String, dynamic> canastaHuevos = {
      'name': 'Canasta de Huevos',
      'value': 8800,
      'route': 'assets/productos/huevos.png'
    };

    productBox.put('canasta_huevos', canastaHuevos);


    // Libra de arroz
    Map<String, dynamic> arroz = {
      'name': 'Libra de Arroz',
      'value': 2000,
      'route': 'assets/productos/arroz.jpg'
    };

    productBox.put('arroz', arroz);


    // Lata de atún
    Map<String, dynamic> atun = {
      'name': 'Lata de Atún',
      'value': 4500,
      'route': 'assets/productos/atun.png'
    };

    productBox.put('atun', atun);


    // Libra de lentejas
    Map<String, dynamic> lentejas = {
      'name': 'Libra de Lentejas',
      'value': 3300,
      'route': 'assets/productos/lentejas.jpg'
    };

    productBox.put('lentejas', lentejas);


    // Libra de frijoles
    Map<String, dynamic> frijoles = {
      'name': 'Libra de Frijoles',
      'value': 5200,
      'route': 'assets/productos/frijoles.jpg'
    };

    productBox.put('frijoles', frijoles);


    // Pan tajado
    Map<String, dynamic> pan = {
      'name': 'Pan Tajado',
      'value': 3500,
      'route': 'assets/productos/pan.png'
    };

    productBox.put('pan', pan);


    // Arepas
    Map<String, dynamic> arepas = {
      'name': 'Arepas',
      'value': 1600,
      'route': 'assets/productos/arepas.png'
    };

    productBox.put('arepas', arepas);


    // Vinagre
    Map<String, dynamic> vinagre = {
      'name': 'Vinagre',
      'value': 2800,
      'route': 'assets/productos/vinagre.png'
    };

    productBox.put('vinagre', vinagre);


    // 2 libras de sal
    Map<String, dynamic> sal = {
      'name': 'Kilo de Sal',
      'value': 2300,
      'route': 'assets/productos/sal.png'
    };

    productBox.put('sal', sal);


    // 2 libras de azúcar
    Map<String, dynamic> azucar = {
      'name': 'Kilo de Azúcar',
      'value': 4700,
      'route': 'assets/productos/azucar.png'
    };

    productBox.put('azucar', azucar);


    // Tarro de café
    Map<String, dynamic> cafe = {
      'name': 'Tarro de Café',
      'value': 10500,
      'route': 'assets/productos/cafe.png'
    };

    productBox.put('cafe', cafe);


    // Botella de agua
    Map<String, dynamic> agua = {
      'name': 'Botella de Agua',
      'value': 1800,
      'route': 'assets/productos/agua.png'
    };

    productBox.put('agua', agua);


    // 3 barras de jabón
    Map<String, dynamic> jabon = {
      'name': '3 Barras de Jabón',
      'value': 5900,
      'route': 'assets/productos/jabon.png'
    };

    productBox.put('jabon', jabon);


    // Botella de champú
    Map<String, dynamic> champu = {
      'name': 'Botella de Champú',
      'value': 22000,
      'route': 'assets/productos/champu.png'
    };

    productBox.put('champu', champu);


    // Docena de papel higiénico
    Map<String, dynamic> papelHigienico = {
      'name': 'Docena de Papel Higiénico',
      'value': 18000,
      'route': 'assets/productos/papel_higienico.png'
    };

    productBox.put('papel_higienico', papelHigienico);


    // Crema dental
    Map<String, dynamic> cremaDental = {
      'name': 'Crema Dental',
      'value': 10000,
      'route': 'assets/productos/crema_dental.png'
    };

    productBox.put('crema_dental', cremaDental);


    // Detergente en polvo
    Map<String, dynamic> detergente = {
      'name': 'Detergente en Polvo',
      'value': 6000,
      'route': 'assets/productos/detergente.png'
    };

    productBox.put('detergente', detergente);


    // Gaseosa
    Map<String, dynamic> gaseosa = {
      'name': 'Gaseosa',
      'value': 4000,
      'route': 'assets/productos/gaseosa.jpg'
    };

    productBox.put('gaseosa', gaseosa);


    // Paquete de pasta
    Map<String, dynamic> pasta = {
      'name': 'Paquete de Pasta',
      'value': 2100,
      'route': 'assets/productos/pasta.png'
    };

    productBox.put('pasta', pasta);


    // Caja de cereal
    Map<String, dynamic> cereal = {
      'name': 'Caja de Cereal',
      'value': 6500,
      'route': 'assets/productos/cereal.png'
    };

    productBox.put('cereal', cereal);


    // Mantequilla
    Map<String, dynamic> mantequilla = {
      'name': 'Mantequilla',
      'value': 8000,
      'route': 'assets/productos/mantequilla.png'
    };

    productBox.put('mantequilla', mantequilla);


    // Panela
    Map<String, dynamic> panela = {
      'name': 'Panela',
      'value': 7400,
      'route': 'assets/productos/panela.png'
    };

    productBox.put('panela', panela);


    // Harina
    Map<String, dynamic> harina = {
      'name': 'Harina',
      'value': 2200,
      'route': 'assets/productos/harina.png'
    };

    productBox.put('harina', harina);


    // Queso
    Map<String, dynamic> queso = {
      'name': 'Queso',
      'value': 9600,
      'route': 'assets/productos/queso.png'
    };

    productBox.put('queso', queso);


    // Jamón
    Map<String, dynamic> jamon = {
      'name': 'Jamón',
      'value': 12000,
      'route': 'assets/productos/jamon.png'
    };

    productBox.put('jamon', jamon);
  }
}

