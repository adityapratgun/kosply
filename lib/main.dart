import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/favorite_provider.dart';
import 'screens/home_screen.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const KosplyApp());
}

class KosplyApp extends StatelessWidget {
  const KosplyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      // Dipasang di root supaya FavoriteProvider bisa diakses (context.watch/
      // context.read) dari screen mana pun: Home, Product Detail, Favorite.
      create: (_) => FavoriteProvider(),
      child: MaterialApp(
        title: 'Kosply',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light(),
        home: const HomeScreen(),
      ),
    );
  }
}
