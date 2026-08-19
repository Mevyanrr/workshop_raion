import 'package:flutter/material.dart';
import 'package:workshop_animation/models/movie_model.dart';
class MovieViewModel extends ChangeNotifier {
  final List<MovieModel> _allMovies = const [
    MovieModel(
      id: '1',
      title: 'Interstellar',
      imageUrl: 'https://images.unsplash.com/photo-1446776653964-20c1d3a81b06',
      rating: 8.7,
      genre: 'Sci-Fi',
      year: 2014,
      synopsis:
          'Seorang mantan pilot NASA memimpin misi melalui lubang cacing demi menyelamatkan umat manusia dari bumi yang sekarat.',
    ),
    MovieModel(
      id: '2',
      title: 'Inception',
      imageUrl: 'https://images.unsplash.com/photo-1478720568477-152d9b164e26',
      rating: 8.8,
      genre: 'Sci-Fi',
      year: 2010,
      synopsis:
          'Seorang pencuri yang menyusup ke dalam mimpi orang lain mendapat tugas terakhir: menanamkan sebuah ide, bukan mencurinya.',
    ),
    MovieModel(
      id: '3',
      title: 'The Dark Knight',
      imageUrl: 'https://images.unsplash.com/photo-1509347528160-9a9e33742cdb',
      rating: 9.0,
      genre: 'Action',
      year: 2008,
      synopsis:
          'Batman menghadapi ancaman terbesarnya saat Joker menebar teror dan kekacauan di Gotham City.',
    ),
    MovieModel(
      id: '4',
      title: 'Se7en',
      imageUrl: 'https://images.unsplash.com/photo-1489599849927-2ee91cede3ba',
      rating: 8.6,
      genre: 'Thriller',
      year: 1995,
      synopsis:
          'Dua detektif memburu seorang pembunuh berantai yang menjadikan tujuh dosa mematikan sebagai motifnya.',
    ),
    MovieModel(
      id: '5',
      title: 'The Shawshank Redemption',
      imageUrl: 'https://images.unsplash.com/photo-1440404653325-ab127d49abc1',
      rating: 9.3,
      genre: 'Drama',
      year: 1994,
      synopsis:
          'Seorang bankir dipenjara atas tuduhan palsu dan membangun harapan serta persahabatan di balik jeruji besi.',
    ),
  ];

  final Set<String> _watchlistIds = {};
  String _selectedGenre = 'Semua';

  List<MovieModel> get allMovies => _allMovies;
  String get selectedGenre => _selectedGenre;

  List<MovieModel> get filteredMovies {
    if (_selectedGenre == 'Semua') return _allMovies;
    return _allMovies.where((m) => m.genre == _selectedGenre).toList();
  }

  List<MovieModel> get watchlistMovies =>
      _allMovies.where((m) => _watchlistIds.contains(m.id)).toList();

  void selectGenre(String genre) {
    if (_selectedGenre == genre) return;
    _selectedGenre = genre;
    notifyListeners();
  }

  bool isInWatchlist(String movieId) => _watchlistIds.contains(movieId);

  void toggleWatchlist(String movieId) {
    if (_watchlistIds.contains(movieId)) {
      _watchlistIds.remove(movieId);
    } else {
      _watchlistIds.add(movieId);
    }
    notifyListeners();
  }

  MovieModel? findById(String id) {
    try {
      return _allMovies.firstWhere((m) => m.id == id);
    } catch (_) {
      return null;
    }
  }
}