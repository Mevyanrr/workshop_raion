import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:workshop_animation/core/widgets/movielist_card.dart';
import 'package:workshop_animation/viewmodels/movie_vm.dart';
import 'package:workshop_animation/views/detail.dart';
import '../../core/theme/app_colors.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final movieVM = context.watch<MovieViewModel>();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 100),
        children: [
          const Text(
            'RaionMovie',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
          ).animate().fadeIn(duration: 350.ms).slideY(begin: -0.15, end: 0),
          const SizedBox(height: 18),
          // Welcome banner
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
            decoration: BoxDecoration(
              color: AppColors.primaryYellow,
              borderRadius: BorderRadius.circular(18),
            ),
            child: const Text(
              'Selamat Datang di RaionMovie',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
          ).animate().fadeIn(delay: 100.ms, duration: 400.ms).slideY(begin: 0.1, end: 0),
          const SizedBox(height: 24),
          Text(
            'Semua Film',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: isDark ? Colors.white : AppColors.lightTextPrimary,
            ),
          ),
          const SizedBox(height: 16),
          ...List.generate(movieVM.allMovies.length, (index) {
            final movie = movieVM.allMovies[index];
            return MovieListCard(
              movie: movie,
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => MovieDetailView(movieId: movie.id),
                ),
              ),
            ).animate().fadeIn(
                  delay: (150 + index * 80).ms,
                  duration: 350.ms,
                ).slideY(begin: 0.08, end: 0);
          }),
        ],
      ),
    );
  }
}