class City {
  String name;
  String image;
  List<CityReview> reviews;

  City({required this.name, required this.image, required this.reviews});
}

final List<City> ciudades = [
  City(name: 'malaga', image: 'assets/ciudades/uno.jpg', reviews: reviews2),
  City(name: 'sevilla', image: 'assets/ciudades/dos.jpg', reviews: reviews3),
  City(name: 'valencia', image: 'assets/ciudades/tres.jpg', reviews: reviews4),
];

class CityReview {
  String name;
  String image;

  CityReview({required this.name, required this.image});
}

final List<CityReview> reviews2 = [
  CityReview(name: 'uno', image: 'assets/ciudades/uno.jpg'),
  CityReview(name: 'dos', image: 'assets/ciudades/dos.jpg'),
  CityReview(name: 'tres', image: 'assets/ciudades/tres.jpg'),
  CityReview(name: 'cuatro', image: 'assets/ciudades/uno.jpg'),
  CityReview(name: 'cinco', image: 'assets/ciudades/dos.jpg'),
  CityReview(name: 'seis', image: 'assets/ciudades/tres.jpg'),
];

final List<CityReview> reviews3 = [
  CityReview(name: 'uno1', image: 'assets/ciudades/uno.jpg'),
  CityReview(name: 'dos1', image: 'assets/ciudades/dos.jpg'),
  CityReview(name: 'tres1', image: 'assets/ciudades/tres.jpg'),
  CityReview(name: 'cuatro1', image: 'assets/ciudades/uno.jpg'),
  CityReview(name: 'cinco1', image: 'assets/ciudades/dos.jpg'),
  CityReview(name: 'seis1', image: 'assets/ciudades/tres.jpg'),
];

final List<CityReview> reviews4 = [
  CityReview(name: '2uno', image: 'assets/ciudades/uno.jpg'),
  CityReview(name: '2dos', image: 'assets/ciudades/dos.jpg'),
  CityReview(name: '2tres', image: 'assets/ciudades/tres.jpg'),
  CityReview(name: '2cuatro', image: 'assets/ciudades/uno.jpg'),
  CityReview(name: '2cinco', image: 'assets/ciudades/dos.jpg'),
  CityReview(name: '2seis', image: 'assets/ciudades/tres.jpg'),
];
