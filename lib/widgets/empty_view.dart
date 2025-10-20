/// FITXER: empty_view.dart
///
/// QUÈ ÉS:
/// Un widget per mostrar quan una cerca no retorna cap resultat.
///
/// PER QUÈ EXISTEIX:
/// Per donar un feedback clar i amable a l'usuari. És millor mostrar un missatge
/// explícit que deixar la pantalla en blanc, la qual cosa podria ser confús.
///
/// RELACIÓ AMB ALTRES:
/// És mostrat per HomePage quan la llista de resultats de l'API és buida.
library;

import 'package:flutter/material.dart';

class EmptyView extends StatelessWidget {
  const EmptyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off,
            size: 60,
            color: Theme.of(context).colorScheme.secondary,
          ),
          const SizedBox(height: 16),
          Text(
            'No s\'han trobat resultats',
            style: Theme.of(context).textTheme.headlineSmall,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            'Prova amb un altre codi postal o localitat.',
            style: Theme.of(context).textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
