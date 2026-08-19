import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  AppTheme._();

  // Design Tokens - Colors
  static const Color ashokaBlue = Color(0xFF0B5FA5);
  static const Color deepSaffron = Color(0xFFF4811F);
  static const Color indiaGreen = Color(0xFF138808);
  static const Color successGreen = Color(0xFF2E7D32);
  static const Color amberWarning = Color(0xFFF9A825);
  static const Color errorRed = Color(0xFFC62828);
  static const Color neutralDark = Color(0xFF1F2933);
  static const Color neutralMid = Color(0xFF616E7C);
  static const Color neutralLight = Color(0xFFF5F7FA);
  static const Color surfaceWhite = Color(0xFFFFFFFF);

  // Light Theme Configuration
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.light(
        primary: ashokaBlue,
        secondary: deepSaffron,
        surface: surfaceWhite,
        error: errorRed,
        onPrimary: surfaceWhite,
        onSecondary: surfaceWhite,
        onSurface: neutralDark,
        onError: surfaceWhite,
      ),
      scaffoldBackgroundColor: neutralLight,
      cardTheme: CardThemeData(
        color: surfaceWhite,
        elevation: 2,
        shadowColor: neutralMid.withOpacity(0.1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: ashokaBlue,
        foregroundColor: surfaceWhite,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: GoogleFonts.poppins(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: surfaceWhite,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: ashokaBlue,
          foregroundColor: surfaceWhite,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: ashokaBlue,
          side: const BorderSide(color: ashokaBlue, width: 1.5),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      textTheme: TextTheme(
        displayLarge: GoogleFonts.poppins(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: neutralDark,
        ),
        displayMedium: GoogleFonts.poppins(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: neutralDark,
        ),
        titleLarge: GoogleFonts.poppins(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: neutralDark,
        ),
        bodyLarge: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.normal,
          color: neutralDark,
        ),
        bodyMedium: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.normal,
          color: neutralMid,
        ),
        labelSmall: GoogleFonts.inter(
          fontSize: 12,
          fontWeight: FontWeight.normal,
          color: neutralMid,
        ),
      ),
    );
  }
}
