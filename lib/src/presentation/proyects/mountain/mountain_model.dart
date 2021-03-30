import 'package:flutter/material.dart';

class Mountain {
  String name;
  String ranked;
  int elevation;
  String coordinates;
  String country;
  String information;
  List<String> images;
  List<Color> colors;

  Mountain(
      {this.name,
      this.ranked,
      this.elevation,
      this.coordinates,
      this.country,
      this.information,
      this.images,
      this.colors});

  static List<Mountain> defaultList() {
    List<Mountain> list = [];

    Mountain everest = Mountain(
        name: 'Everest',
        ranked: '1st',
        elevation: 8848,
        coordinates: '27°59′17″N 86°55′31″E',
        country: 'Nepal',
        information:
            'El Everest (o Chomolungma como se le denomina en Nepal) se encuentra situado a 8848,43 metros de altura y es el sueño de todo escalador, pero sin duda es el desafío más peligroso y la montaña más mortal de la tierra. Sí, es el lugar más alto de nuestro planeta y la cumbre más famosa que todos los niños de todos los países conocen. Pero la historia de su descubrimiento y de la valerosa gente que intentó encumbrarlo suelen ser desconocidos para el público. Con una forma similar a la de una pirámide debido a la disección de los glaciares, el Everest se alza justo en la frontera entre dos países asiáticos: China y Nepal.\nEste pico es realmente considerado uno de los lugares más magníficos y a la vez más trágicos y peligrosos del mundo. Su abrupta silueta ha atraído a numerosas personas valientes e intrépidas a llegar a la cima. Lamentablemente, muchas de ellas se quedaron en sus nieves y acantilados rocosos para siempre. Más de 235 escaladores y lugareños han muerto intentando subir al pico más alto del mundo, aunque el número exacto sigue siendo desconocido, ya que no todo el mundo se registra antes de su viaje. Esto tiene que ver con la presión y el aire enrarecido, el cual es imposible de respirar durante mucho tiempo. Aunque, a pesar del peligro, del aire gélido y de la falta de oxígeno en el aire que respiran, numerosas personas arriesgan sus vidas por estar un poco de tiempo en la cima del mundo. ¿Qué tiene que lo hace tan especial?\nHoy en día, ésta es una pregunta muy popular ya que, como todos sabemos, las expediciones a gran altura son un juego de “pagar por jugar”, y tienes que estar no sólo preparado físicamente y ser un experto en montañismo, sino que también necesitas estar preparado para pagar por ello. El precio mínimo es de unos 30.000\$ si vas por tu cuenta. Las compañías de viajes ofrecen expediciones guiadas, y el precio de su servicio está alrededor de los 60.000\$. El servicio de expedición VIP, que incluye acceso a Internet y teléfono constante llega a alcanzar los 90.000\$. En general, depende del guía y de la cantidad y calidad de los servicios incluidos en el paquete. Sin embargo, al elegir un guía y la compañía con la que trabajar, es importante considerar no sólo el precio y el nombre del proveedor. Siempre es mejor investigar y ver si el vuelo está incluido. Además, es recomendable ver si el servicio de Sherpas también está incluido.',
        colors: [Color(0xff3580D1), Color(0xff2C2372)],
        images: ['assets/mountain/everes.png']);

    Mountain k2 = Mountain(
        name: 'K2',
        ranked: '2nd',
        elevation: 8610,
        coordinates: '35°52′52″N 76°30′48″E',
        country: 'Pakistán',
        information:
            'El K2 tiene fama de ser la segunda montaña más alta del mundo, y una de las más peligrosas para escalar: se estima que 1 de cada 4 individuos que intentan llegar a la cima, pierden la vida. Algunas personas la conocen como montaña Godwin-Austen, Chogori o Ketu, según la región, y otras le han dado el mote de “montaña salvaje” por ser la segunda con más cantidad de muertes después del Annapurna. Dada su peligrosidad, nunca ha sido escalado en invierno.\nSu nombre fue designado, al principio provisionalmente, por el topógrafo George Montgomerie en 1852, durante la tarea del Gran Proyecto de Topografía Trigonométrica. En un principio se deseaba llamar a las montañas del Karakórum con sus nombres locales, pero a esta no se le conocía alguno. Otros nombres no parecen ser muy antiguos.\nSe localiza en el noroeste de la cordillera del Karakórum, como parte de los Grandes Himalayas, que incluye al Everest y otros picos, y en la frontera entre China y Pakistán. Es el punto más alto de la cordillera. Es una montaña muy empinada, de forma triangular, de relieve muy irregular y tiene aproximadamente 8,611 metros de altitud sobre el nivel del mar. Su lado norte es el más empinado, pero en general su geografía está salpicada de picos en todas sus caras y no es visible desde varios pueblos.',
        colors: [Color(0xfff49f3c), Color(0xff9b532d)],
        images: ['assets/mountain/k2.png']);

    Mountain fuji = Mountain(
        name: 'Mt Fuji',
        ranked: '35th',
        elevation: 3776,
        coordinates: '35°21′45″N 138°43′50″E',
        country: 'Japón',
        information:
            'El monte Fuji es el símbolo de Japón y la montaña sagrada más venerada por los japoneses. Se trata de un volcán inactivo desde 1708 que se eleva a más de 2.400 metros de altura y tiene una bonita capa de nieve coronando su cima.\nLa imagen más icónica del país nipón es el monte Fuji. Junto con el monte Tate y el monte Haku, Fuji es una de las tres montañas sagradas de Japón, por lo que ha estado presente en la pintura y la literatura japonesas durante siglos.\nEl monte Fuji ha servido de fuente de inspiración constante para los artistas japoneses, que han retratado su silueta nevada en numerosas obras. Sus representaciones más famosas se encuentran en "Treinta y seis vistas del monte Fuji", una serie de impresiones de paisajes del pintor Hokusai durante el periodo Edo, una etapa que marcó la historia de Tokio.\nLa ladera del monte Fuji está llena de santuarios budistas, arcos torii y otros elementos de la cultura nipona. Antiguamente, los samuráis realizaban sus entrenamientos a los pies del monte Fuji para canalizar la fuerza que les transmitía esta montaña sagrada.\nEl volcán inactivo de Fuji está rodeado por cinco lagos. El más famoso y el preferido por los turistas es el lago Ashi, que se formó hace más de 3.000 años por una erupción del volcán. Desde el lago obtendréis las vistas más bonitas del monte Fuji. ¡No tiene desperdicio!',
        colors: [Color(0xff38B4C3), Color(0xff2F83A2)],
        images: ['assets/mountain/cesped.png']);

    list.add(fuji);
    list.add(everest);
    list.add(k2);

    return list;
  }
}
