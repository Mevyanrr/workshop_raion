import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workshop_animation/viewmodels/movie_vm.dart';
import 'package:workshop_animation/viewmodels/navigation_vm.dart';
import 'package:workshop_animation/viewmodels/theme_vm.dart';
import 'package:workshop_animation/views/navmain.dart';
import 'core/theme/app_theme.dart';

void main() {
  runApp(const RaionMovieApp());
}

class RaionMovieApp extends StatelessWidget {
  const RaionMovieApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeViewModel()),
        ChangeNotifierProvider(create: (_) => MovieViewModel()),
        ChangeNotifierProvider(create: (_) => NavigationViewModel()),
      ],
      child: Consumer<ThemeViewModel>(
        builder: (context, themeVM, _) {
          return MaterialApp(
            title: 'RaionMovie',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeVM.themeMode,
            home: const MainNavigationView(),
          );
        },
      ),
    );
  }
}