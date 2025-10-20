// ignore: dangling_library_doc_comments
/// FITXER: main.dart
///
/// QUÈ ÉS:
/// Aquest és el punt d'entrada de l'aplicació Flutter.
///
/// PER QUÈ EXISTEIX:
/// La seva única responsabilitat és iniciar l'app, configurar el widget arrel (MaterialApp)
/// i aplicar el tema global que hem definit a app_theme.dart.
///
/// RELACIó AMB ALTRES:
/// Crida a AppTheme per obtenir l'estil i estableix HomePage com la pantalla inicial.

import 'package:flutter/material.dart';
import 'package:zippopotam/pages/home_page.dart';
import 'package:zippopotam/theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cercador de CP',
      // Apliquem el tema global definit a la nostra classe AppTheme.
      // Això assegura que tota l'app tingui un estil consistent (colors, fonts, etc.).
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}
