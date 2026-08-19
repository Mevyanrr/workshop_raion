import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../models/genre_model.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    final movieVM = context.watch<MovieViewModel>();
    final themeVM = context.watch<ThemeViewModel>();
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final movies = movieVM.filteredMovies;

    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'RaionMovie',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
                ),
                IconButton(
                  onPressed: themeVM.toggleTheme,
                  icon: Icon(
                    Icons.settings_rounded,
                    color: isDark ? Colors.white : AppColors.lightTextPrimary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 44,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              scrollDirection: Axis.horizontal,
              itemCount: GenreModel.all.length,
              separatorBuilder: (_, __) => const SizedBox(width: 10),
              itemBuilder: (context, index) {
                final genre = GenreModel.all[index];
                return GenreChip(
                  label: genre.label,
                  isSelected: movieVM.selectedGenre == genre.label,
                  onTap: () => movieVM.selectGenre(genre.label),
                );
              },
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Semua Film',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: isDark ? Colors.white : AppColors.lightTextPrimary,
              ),
            ),
          ),
          const SizedBox(height: 14),
          Expanded(
            child: movies.isEmpty
                ? Center(
                    child: Text(
                      'Tidak ada film untuk genre ini',
                      style: TextStyle(
                        color: isDark
                            ? AppColors.darkTextSecondary
                            : AppColors.lightTextSecondary,
                      ),
                    ),
                  )
                : GridView.builder(
                    key: ValueKey(movieVM.selectedGenre),
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 110),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                      childAspectRatio: 0.68,
                    ),
                    itemCount: movies.length,
                    itemBuilder: (context, index) {
                      final movie = movies[index];
                      return MovieGridCard(
                        movie: movie,
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => MovieDetailView(movieId: movie.id),
                          ),
                        ),
                      )
                          .animate()
                          .fadeIn(
                            delay: (index * 60).ms,
                            duration: 300.ms,
                          )
                          .scale(
                            begin: const Offset(0.9, 0.9),
                            end: const Offset(1, 1),
                            curve: Curves.easeOutBack,
                          );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}