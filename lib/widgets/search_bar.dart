/// FITXER: search_bar.dart
///
/// QUÈ ÉS:
/// Un widget reutilitzable que encapsula el camp de text (TextField) i el botó de cerca.
///
/// PER QUÈ EXISTEIX:
/// Per modularitzar la UI. En lloc de tenir un gran arbre de widgets a home_page.dart,
/// extraiem peces lògiques en els seus propis fitxers. Això fa el codi més llegible,
/// mantenible i reutilitzable en altres pantalles si fos necessari.
///
/// RELACIÓ AMB ALTRES:
/// És utilitzat per HomePage. No té lògica pròpia; comunica les accions de l'usuari
/// (pressionar el botó) a la pàgina pare a través de la funció de callback `onSearch`.
library;

import 'package:flutter/material.dart';

class CustomSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback
  onSearch; // Un callback per notificar quan es prem el botó.

  const CustomSearchBar({
    super.key,
    required this.controller,
    required this.onSearch,
  });

  @override
  Widget build(BuildContext context) {
    // Obtenim el tema del context. Això ens permet utilitzar els colors i estils
    // definits globalment a app_theme.dart.
    final theme = Theme.of(context);

    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: 'Codi postal o localitat...',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            // Permet llançar la cerca prement 'enter' al teclat.
            onSubmitted: (_) => onSearch(),
          ),
        ),
        const SizedBox(width: 8),
        ElevatedButton.icon(
          onPressed: onSearch,
          icon: const Icon(Icons.search),
          label: const Text('Cercar'),
          style: ElevatedButton.styleFrom(
            // Usem els colors del nostre tema per als botons.
            backgroundColor: theme.colorScheme.primary,
            foregroundColor: theme.colorScheme.onPrimary,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
        ),
      ],
    );
  }
}
