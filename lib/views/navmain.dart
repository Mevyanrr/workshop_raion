import 'package:flutter/material.dart';
import 'package:workshop_animation/core/widgets/navbar.dart';
import 'package:workshop_animation/viewmodels/navigation_vm.dart';
import 'package:workshop_animation/views/home.dart';
import 'package:workshop_animation/views/search.dart';
import 'package:workshop_animation/views/watchlist.dart';

class MainNavigationView extends StatelessWidget {
  const MainNavigationView({super.key});

  static const _pages = [
    HomeView(),
    SearchView(),
    WatchlistView(),
  ];

  @override
  Widget build(BuildContext context) {
    final navVM = context.watch<NavigationViewModel>();

    return Scaffold(
      extendBody: true,
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 250),
        transitionBuilder: (child, animation) => FadeTransition(
          opacity: animation,
          child: child,
        ),
        child: KeyedSubtree(
          key: ValueKey(navVM.currentIndex),
          child: _pages[navVM.currentIndex],
        ),
      ),
      bottomNavigationBar: CustomBottomNav(
        currentIndex: navVM.currentIndex,
        onTap: navVM.setIndex,
      ),
    );
  }
}