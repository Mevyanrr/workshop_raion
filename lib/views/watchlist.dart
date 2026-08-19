import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class WatchlistView extends StatelessWidget {
  const WatchlistView({super.key});

  @override
  Widget build(BuildContext context) {
    final movieVM = context.watch<MovieViewModel>();
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final watchlist = movieVM.watchlistMovies;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Watchlist',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: watchlist.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.bookmark_border_rounded,
                            size: 48,
                            color: isDark
                                ? AppColors.darkTextSecondary
                                : AppColors.lightTextSecondary,
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'Belum ada film di watchlist kamu',
                            style: TextStyle(
                              color: isDark
                                  ? AppColors.darkTextSecondary
                                  : AppColors.lightTextSecondary,
                            ),
                          ),
                        ],
                      ),
                    ).animate().fadeIn(duration: 300.ms)
                  : ListView.builder(
                      padding: const EdgeInsets.only(bottom: 100),
                      itemCount: watchlist.length,
                      itemBuilder: (context, index) {
                        final movie = watchlist[index];
                        return MovieListCard(
                          movie: movie,
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => MovieDetailView(movieId: movie.id),
                            ),
                          ),
                        ).animate().fadeIn(
                              delay: (index * 80).ms,
                              duration: 300.ms,
                            );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}