/// FITXER: error_view.dart
///
/// QUÈ ÉS:
/// Un widget per mostrar quan ha ocorregut un error durant la crida a l'API.
///
/// PER QUÈ EXISTEIX:
/// Per informar a l'usuari que alguna cosa ha anat malament i, molt important,
/// donar-li una acció per recuperar-se de l'error (el botó de reintentar).
///
/// RELACIÓ AMB ALTRES:
/// És mostrat per HomePage quan la variable d'estat `_errorMessage` no és nul·la.
library;

import 'package:flutter/material.dart';

class ErrorView extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const ErrorView({super.key, required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 60, color: theme.colorScheme.error),
            const SizedBox(height: 16),
            Text(
              'Ha ocorregut un error',
              style: theme.textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              message, // Mostrem el missatge d'error específic que ve del repository.
              style: theme.textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh),
              label: const Text('Torna-ho a provar'),
            ),
          ],
        ),
      ),
    );
  }
}
