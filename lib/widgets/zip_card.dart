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
import 'package:url_launcher/url_launcher.dart';
import 'package:zippopotam/data/models/zip_response.dart';

class ZipCard extends StatelessWidget {
  final ZipInfo info;

  const ZipCard({super.key, required this.info});

  Future<void> _launchMaps(BuildContext context) async {
    if (info.latitude == null ||
        info.longitude == null ||
        info.latitude!.isEmpty ||
        info.longitude!.isEmpty) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Coordenades no disponibles')),
      );
      return;
    }

    final uri = Uri.parse(
      'https://www.google.com/maps/search/?api=1&query=${info.latitude},${info.longitude}',
    );

    if (!await launchUrl(uri)) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No s\'ha pogut obrir Google Maps')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16.0),
        title: Text(
          info.placeName,
          style: textTheme.titleLarge?.copyWith(
            color: colorScheme.onSurface,
          ),
        ),
        subtitle: Text(
          '${info.state} - CP: ${info.postCode}',
          style: textTheme.bodyMedium?.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.location_on_outlined),
          onPressed: () => _launchMaps(context),
        ),
      ),
    );
  }
}
