/// FITXER: zip_card.dart
///
/// QUÈ ÉS:
/// Un widget que mostra la informació d'un únic resultat (un objecte ZipInfo)
/// en un format de targeta.
///
/// PER QUÈ EXISTEIX:
/// Per representar visualment un element de la llista de resultats. És un widget
/// "tonto" (stateless) que només es preocupa de com mostrar les dades que rep,
/// fent-lo altament reutilitzable i previsible.
///
/// RELACIÓ AMB ALTRES:
/// És utilitzat per la ListView a HomePage per construir cada fila de la llista
/// de resultats. Rep un objecte ZipInfo com a paràmetre.
library;

import 'package:flutter/material.dart';
import 'package:zippopotam/data/models/zip_response.dart';

class ZipCard extends StatelessWidget {
  final ZipInfo info;

  const ZipCard({super.key, required this.info});

  @override
  Widget build(BuildContext context) {
    // Accedim al tema definit globalment.
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),

      // Usem el nou color recomanat per a superfícies elevades com les targetes.
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              info.placeName,
              // Apliquem un estil de text predefinit del nostre TextTheme.
              // Això assegura consistència i facilita canvis globals de font/mida.
              style: textTheme.titleLarge?.copyWith(
                color: colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '${info.state} - CP: ${info.postCode}',
              style: textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
