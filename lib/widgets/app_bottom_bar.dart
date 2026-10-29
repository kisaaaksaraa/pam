import 'package:flutter/material.dart';

class AppBottomBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const AppBottomBar({super.key, required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    const orange = Colors.deepOrange;
    return NavigationBar(
      selectedIndex: currentIndex,
      onDestinationSelected: onTap,
      labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
      backgroundColor: Colors.white,
      indicatorColor: Colors.transparent,
      destinations: const [
        NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home, color: orange),
            label: 'Home'),
        NavigationDestination(
            icon: Icon(Icons.search),
            selectedIcon: Icon(Icons.search, color: orange),
            label: 'Search'),
        NavigationDestination(
            icon: Icon(Icons.shopping_basket_outlined),
            selectedIcon: Icon(Icons.shopping_basket, color: orange),
            label: 'Keranjang'),
        NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person, color: orange),
            label: 'Profil'),
      ],
    );
  }
}
