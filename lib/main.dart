import 'package:flutter/material.dart';
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