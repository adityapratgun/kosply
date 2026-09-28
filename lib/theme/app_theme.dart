import 'package:flutter/material.dart';

/// Palet warna diambil dari desain Figma "Kosply" - dominan ungu lavender
/// dengan aksen ungu tua untuk tombol & elemen interaktif.
class AppColors {
  AppColors._();

  static const Color primary = Color(0xFF6C4DDC); // ungu aksen (tombol, ikon aktif)
  static const Color surface = Color(0xFFEDE7F6); // background card / placeholder gambar
  static const Color scaffoldBackground = Color(0xFFFCF8FD); // background halaman
  static const Color textPrimary = Color(0xFF1A1A1A);
  static const Color textSecondary = Color(0xFF6F6F78);
  static const Color online = Color(0xFF2E9E5B); // indikator "Active ... menit yg lalu"
  static const Color placeholderIcon = Color(0xFFB8AEDB);
}

class AppTheme {
  AppTheme._();

  static ThemeData light() {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.scaffoldBackground,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        primary: AppColors.primary,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.scaffoldBackground,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
        centerTitle: false,
      ),
      textTheme: const TextTheme(
        titleLarge: TextStyle(fontWeight: FontWeight.bold, color: AppColors.textPrimary),
        bodyMedium: TextStyle(color: AppColors.textPrimary),
      ),
    );
  }
}
