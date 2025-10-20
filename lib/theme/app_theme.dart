/// FITXER: app_theme.dart
///
/// QUÈ ÉS:
/// Aquest fitxer centralitza la configuració del disseny visual (Theme) de l'aplicació.
///
/// PER QUÈ EXISTEIX:
/// Per evitar definir colors, fonts i estils manualment a cada widget. Creant un ThemeData
/// central, assegurem consistència visual i facilitem canvis futurs (p. ex., canviar
/// el color principal a tota l'app modificant només una línia aquí).
///
/// RELACIÓ AMB ALTRES:
/// És utilitzat per main.dart per configurar el tema global de la MaterialApp. Els widgets
/// de la UI (com zip_card.dart, home_page.dart) accedeixen a aquests estils a través de
/// Theme.of(context).
library;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Definim la teva paleta de colors com a constants privades per a un ús fàcil i llegible.
  static const Color _darkBlue = Color(
    0xFF283044,
  ); // Per a textos principals i fons destacats (AppBar)
  static const Color _midBlue = Color(
    0xFF78A1BB,
  ); // Color primari per a accions (botons)
  static const Color _offWhite = Color(
    0xFFEBF5EE,
  ); // Color de fons principal de l'app
  static const Color _lightBrown = Color(
    0xFFBFA89E,
  ); // Color per a superfícies secundàries (targetes)
  static const Color _darkBrown = Color(
    0xFF8B786D,
  ); // Color d'accent o per a detalls

  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,

    // Creem un ColorScheme personalitzat per assignar cada color de la teva paleta
    // a un rol específic dins de l'app, seguint les noves guies de Material 3.
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: _midBlue, // Color principal per a botons i elements interactius.
      onPrimary:
          Colors.white, // Text sobre el color primari (blanc per a contrast).
      secondary: _darkBrown, // Color secundari per a altres elements.
      onSecondary: Colors.white, // Text sobre el color secundari.
      error:
          _darkBrown, // CANVI: Hem substituït el vermell per defecte pel marró fosc.
      onError:
          _offWhite, // CANVI: Ajustem el text d'error per a un bon contrast.
      surface: _offWhite, // El fons/superfície principal de l'app.
      onSurface:
          _darkBlue, // El color del text principal sobre el fons/superfície.
    ),

    textTheme: GoogleFonts.interTextTheme(ThemeData.light().textTheme).apply(
      bodyColor:
          _darkBlue, // Assegurem que el text per defecte sigui el blau fosc.
      displayColor: _darkBlue,
    ),

    appBarTheme: const AppBarTheme(
      elevation: 2,
      centerTitle: true,
      backgroundColor: _darkBlue, // AppBar amb el fons blau fosc.
      foregroundColor:
          Colors.white, // Títol de l'AppBar en blanc per a màxim contrast.
    ),

    // Definim un tema per a les targetes, assignant el color marró clar.
    // Això ens permet tenir un color de fons per a les targetes diferent del fons principal de l'app.
    cardTheme: const CardThemeData(
      elevation: 1,
      color: _lightBrown,
      margin: EdgeInsets.symmetric(vertical: 8.0),
    ),

    // Estil per als botons elevats.
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: _midBlue, // Botons amb el blau mitjà.
        foregroundColor: Colors.white, // Text dels botons en blanc.
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      ),
    ),

    // Estil per als camps d'entrada de text.
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor:
          Colors.white, // Un fons blanc per al camp de cerca per destacar-lo.
      hintStyle: const TextStyle(color: _darkBrown),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide.none, // Sense vores per un look més net.
      ),
    ),
  );
}
