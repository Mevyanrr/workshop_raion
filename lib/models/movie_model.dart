
class MovieModel {
  final String id;
  final String title;
  final String imageUrl;
  final double rating;
  final String genre;
  final int year;
  final String synopsis;

  const MovieModel({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.rating,
    required this.genre,
    required this.year,
    required this.synopsis,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      id: json['id'] as String,
      title: json['title'] as String,
      imageUrl: json['imageUrl'] as String,
      rating: (json['rating'] as num).toDouble(),
      genre: json['genre'] as String,
      year: json['year'] as int,
      synopsis: json['synopsis'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'imageUrl': imageUrl,
        'rating': rating,
        'genre': genre,
        'year': year,
        'synopsis': synopsis,
      };
}