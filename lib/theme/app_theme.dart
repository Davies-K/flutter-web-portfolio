import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  static const background = Color(0xFFF9F9F9);
  static const ink = Color(0xFF1A1A1A);
  static const muted = Color(0xFF8A8A8A);
  static const border = Color(0xFFE5E6EB);
  static const cardShadow = Color(0x14000000);

  // Pastel accents used for the hand-drawn underlines.
  static const aqua = Color(0xFFBFE3E6);
  static const peach = Color(0xFFF3D2BA);
  static const lavender = Color(0xFFB5C0FD);
  static const lavenderLight = Color(0xFFD9DEFD);
  static const mint = Color(0xFFBFE0DD);
  static const blush = Color(0xFFF8D3C8);
  static const servicesBand = Color(0xFFF2F3FB);
  static const avatar = Color(0xFFE6F6F8);
}

class AppText {
  static TextStyle display(double size) => GoogleFonts.roboto(
        fontSize: size,
        fontWeight: FontWeight.w600,
        color: AppColors.ink,
        height: 1.2,
        letterSpacing: -0.5,
      );

  static TextStyle heading(double size) => GoogleFonts.lato(
        fontSize: size,
        fontWeight: FontWeight.w700,
        color: AppColors.ink,
        height: 1.2,
      );

  static TextStyle body({
    double size = 15,
    Color color = AppColors.ink,
    FontWeight weight = FontWeight.w400,
    double height = 1.6,
  }) =>
      GoogleFonts.lato(
        fontSize: size,
        color: color,
        fontWeight: weight,
        height: height,
      );

  static TextStyle nav({required bool selected}) => GoogleFonts.roboto(
        fontSize: 14,
        fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
        color: selected ? AppColors.ink : AppColors.muted,
      );
}

class AppTheme {
  static ThemeData get light => ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.background,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.ink,
          surface: AppColors.background,
        ),
        textTheme: GoogleFonts.latoTextTheme(),
        splashFactory: NoSplash.splashFactory,
        highlightColor: Colors.transparent,
      );
}
