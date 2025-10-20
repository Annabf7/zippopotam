/// FITXER: zip_repository.dart
///
/// QUÈ ÉS:
/// La capa d'abstracció de dades. Actua com a intermediari entre la lògica de
/// negoci/UI i les fonts de dades (en aquest cas, el ZipApiService).
///
/// PER QUÈ EXISTEIX:
/// 1. Per desacoblar la UI de la font de dades. La UI no sap (ni li importa) si
///    les dades vénen d'una API, una base de dades local, etc.
/// 2. Per centralitzar la lògica de transformació de dades. Aquí és on convertim
///    la resposta crua de l'API en els nostres models de dades (ZipInfo).
/// 3. Per gestionar i normalitzar els errors. Captura les excepcions del servei
///    i les embolcalla en un objecte `Result` més manejable per a la UI.
///
/// RELACIÓ AMB ALTRES:
/// Utilitza ZipApiService per obtenir dades crues. És cridat per la UI (HomePage)
/// per obtenir dades ja processades i llestes per mostrar. Retorna un `Result<List<ZipInfo>>`.
library;

import 'package:zippopotam/core/exceptions.dart';
import 'package:zippopotam/core/result.dart';
import 'package:zippopotam/data/models/zip_response.dart';
import 'package:zippopotam/data/services/zip_api_service.dart';

class ZipRepository {
  final ZipApiService _apiService;

  ZipRepository({ZipApiService? apiService})
    : _apiService = apiService ?? ZipApiService();

  // Aquest és el mètode principal que la UI cridarà.
  // Rep una cadena de cerca i decideix si és un codi postal o una localitat.
  Future<Result<List<ZipInfo>>> search(String query) async {
    try {
      // Lògica simple per distingir entre CP i localitat.
      final isPostalCode = int.tryParse(query) != null && query.length == 5;

      Map<String, dynamic> jsonResponse;

      if (isPostalCode) {
        jsonResponse = await _apiService.getByPostalCode(query);
      } else {
        jsonResponse = await _apiService.searchByLocality(query);
      }

      // Després de la crida, processem la resposta.
      final zipInfos = _parseResponse(jsonResponse);

      // Si tot ha anat bé, retornem un objecte Success amb la llista de resultats.
      return Success(zipInfos);
    } on AppException catch (e) {
      // Si el servei llança una de les nostres excepcions, la capturem
      // i retornem un objecte Failure. La UI sabrà que ha d'mostrar un error.
      return Failure(e);
    }
  }

  /// Aquesta funció és CLAU. S'encarrega de normalitzar les dues respostes
  /// diferents de l'API en una única llista consistent `List<ZipInfo>`.
  List<ZipInfo> _parseResponse(Map<String, dynamic> jsonResponse) {
    // Si la resposta és buida (p. ex., un 404), retornem una llista buida.
    if (jsonResponse.isEmpty) {
      return [];
    }

    // Cas 1: Cerca per codi postal. La resposta és un objecte sol.
    // L'API retorna una llista de 'places' dins de l'objecte principal.
    // Normalment només hi ha un element, però el tractem com a llista per ser robustos.
    if (jsonResponse.containsKey('places') &&
        jsonResponse['places'] is List &&
        jsonResponse.containsKey('post code')) {
      final places = jsonResponse['places'] as List;
      return places.map((placeJson) {
        // Afegim el codi postal principal al mapa de cada 'place' per unificar el model.
        placeJson['postCode'] = jsonResponse['post code'];
        return ZipInfo.fromJson(placeJson);
      }).toList();
    }

    // Cas 2: Cerca per localitat. La resposta ja conté una llista de 'places'.
    // Aquest endpoint ja inclou el 'post code' dins de cada 'place'.
    if (jsonResponse.containsKey('places') && jsonResponse['places'] is List) {
      final places = jsonResponse['places'] as List;
      return places.map((placeJson) => ZipInfo.fromJson(placeJson)).toList();
    }

    // Si la resposta no té un format esperat, retornem una llista buida.
    return [];
  }
}
