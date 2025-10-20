/// FITXER: zip_api_service.dart
///
/// QUÈ ÉS:
/// Aquesta és la capa més baixa de la nostra jerarquia de dades. És l'únic lloc
/// de l'app que parla directament amb l'API externa (Zippopotam) via HTTP.
///
/// PER QUÈ EXISTEIX:
/// Per aïllar completament la lògica de xarxa. Si en el futur l'API canvia d'URL
/// o hem de canviar de llibreria HTTP, només haurem de modificar aquest fitxer.
/// La seva única feina és fer la petició i retornar les dades en brut (o un error).
///
/// RELACIÓ AMB ALTRES:
/// És utilitzat exclusivament pel ZipRepository. No hauria de ser mai cridat
/// directament des de la UI. Llança NetworkException si alguna cosa va malament.
library;

import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:zippopotam/core/exceptions.dart';

class ZipApiService {
  final String _baseUrl = 'https://api.zippopotam.us/es';
  final http.Client _client;

  // Usem injecció de dependències per al client HTTP. Això és útil per a tests,
  // ja que podem passar un client "mock" (fals) en lloc d'un de real.
  ZipApiService({http.Client? client}) : _client = client ?? http.Client();

  // Mètode per cercar per codi postal
  Future<Map<String, dynamic>> getByPostalCode(String code) async {
    final uri = Uri.parse('$_baseUrl/$code');
    return _performGetRequest(uri);
  }

  // Mètode per cercar per localitat
  Future<Map<String, dynamic>> searchByLocality(String query) async {
    // L'API per a Catalunya és /es/ct/{query}
    final uri = Uri.parse('$_baseUrl/ct/$query');
    return _performGetRequest(uri);
  }

  // Mètode privat genèric per executar la crida GET
  Future<Map<String, dynamic>> _performGetRequest(Uri uri) async {
    try {
      final response = await _client
          .get(uri)
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else if (response.statusCode == 404) {
        // L'API retorna 404 si no troba res, ho tractem com un cas especial.
        return {}; // Retornem un mapa buit per indicar "no trobat".
      } else {
        // Per a altres errors del servidor (500, etc.)
        throw NetworkException(
          'Error del servidor (codi ${response.statusCode})',
        );
      }
    } on TimeoutException {
      throw NetworkException(
        'La petició ha trigat massa a respondre (timeout).',
      );
    } on http.ClientException {
      throw NetworkException(
        'Error de connexió. Revisa la teva connexió a internet.',
      );
    } catch (e) {
      // Per a qualsevol altre error inesperat.
      throw NetworkException('Ha ocorregut un error inesperat: $e');
    }
  }
}
