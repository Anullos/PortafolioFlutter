class MusicModel {
  String image;
  String title;
  String color;

  MusicModel({this.image, this.title, this.color});
}

final List<MusicModel> musics = [
  MusicModel(
    image: 'assets/futbol/balon1.png',
    title: 'Bloody Teor',
    color: '0xFF443268',
  ),
  MusicModel(
    image: 'assets/futbol/balon2.png',
    title: 'Santi Flor',
    color: '0xFF243568',
  ),
  MusicModel(
    image: 'assets/futbol/balon2.png',
    title: 'Shakira',
    color: '0xFF413212',
  ),
  MusicModel(
    image: 'assets/futbol/balon1.png',
    title: 'David Guetta',
    color: '0xFF847768',
  ),
  MusicModel(
    image: 'assets/futbol/balon2.png',
    title: 'Melendi',
    color: '0xFF923228',
  ),
  MusicModel(
    image: 'assets/futbol/balon1.png',
    title: 'Bruno Mars',
    color: '0xFF526768',
  ),
  MusicModel(
    image: 'assets/futbol/balon2.png',
    title: 'Combat Flow',
    color: '0xFF487038',
  ),
];
