class GenreModel {
  final String label;

  const GenreModel(this.label);
  static const List<GenreModel> all = [
    GenreModel('Semua'),
    GenreModel('Sci-Fi'),
    GenreModel('Action'),
    GenreModel('Thriller'),
    GenreModel('Drama'),
  ];
}