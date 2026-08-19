import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:workshop_animation/viewmodels/movie_vm.dart';
import '../../core/theme/app_colors.dart';


class MovieDetailView extends StatelessWidget {
  final String movieId;

  const MovieDetailView({super.key, required this.movieId});

  @override
  Widget build(BuildContext context) {
    final movieVM = context.watch<MovieViewModel>();
    final movie = movieVM.findById(movieId);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    if (movie == null) {
      return const Scaffold(body: Center(child: Text('Film tidak ditemukan')));
    }

    final inWatchlist = movieVM.isInWatchlist(movie.id);

    return Scaffold(
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 320,
                width: double.infinity,
                child: Hero(
                  tag: 'movie-poster-${movie.id}',
                  child: Image.network(
                    movie.imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      color: AppColors.placeholderLavender,
                      child: const Center(
                        child: Icon(Icons.movie_creation_outlined, size: 56),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
                  decoration: BoxDecoration(
                    color: isDark ? AppColors.darkBackground : Colors.white,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(28),
                      topRight: Radius.circular(28),
                    ),
                  ),
                  transform: Matrix4.translationValues(0, -24, 0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.star_rounded,
                                color: AppColors.ratingStar, size: 22),
                            const SizedBox(width: 6),
                            Text(
                              movie.rating.toStringAsFixed(1),
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 4),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: isDark
                                      ? AppColors.darkBorder
                                      : AppColors.lightBorder,
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                movie.genre,
                                style: const TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.w600),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              '${movie.year}',
                              style: TextStyle(
                                color: isDark
                                    ? AppColors.darkTextSecondary
                                    : AppColors.lightTextSecondary,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Text(
                          movie.title,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Sinopsis',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: isDark ? Colors.white : AppColors.lightTextPrimary,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          movie.synopsis,
                          style: TextStyle(
                            fontSize: 14,
                            height: 1.5,
                            color: isDark
                                ? AppColors.darkTextSecondary
                                : AppColors.lightTextSecondary,
                          ),
                        ),
                        const SizedBox(height: 28),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            onPressed: () => movieVM.toggleWatchlist(movie.id),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: inWatchlist
                                  ? (isDark
                                      ? AppColors.darkSurface
                                      : AppColors.badgeLightBg)
                                  : AppColors.primaryYellow,
                              foregroundColor: Colors.black,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              elevation: 0,
                            ),
                            icon: Icon(
                              inWatchlist
                                  ? Icons.bookmark_rounded
                                  : Icons.bookmark_border_rounded,
                            ),
                            label: Text(
                              inWatchlist
                                  ? 'Sudah di Watchlist'
                                  : 'Tambah ke Watchlist',
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ).animate().fadeIn(duration: 300.ms).slideY(begin: 0.08, end: 0),
              ),
            ],
          ),
          Positioned(
            top: 12,
            left: 12,
            child: SafeArea(
              child: CircleAvatar(
                backgroundColor: Colors.black.withOpacity(0.4),
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}