/// FITXER: exceptions.dart
///
/// QUÈ ÉS:
/// Defineix classes d'excepcions personalitzades per a la nostra aplicació.
///
/// PER QUÈ EXISTEIX:
/// En lloc de capturar excepcions genèriques (com `Exception`), crear les nostres
/// pròpies ens permet ser molt més específics sobre el tipus d'error que ha ocorregut.
/// Això fa que la gestió d'errors al Repository i a la UI sigui més clara i robusta.
///
/// RELACIÓ AMB ALTRES:
/// ZipApiService llançarà aquestes excepcions quan una crida HTTP falli.
/// ZipRepository les capturarà per transformar-les en un estat d'error del nostre `Result`.
library;

class AppException implements Exception {
  final String message;
  AppException(this.message);

  @override
  String toString() => message;
}

// Una excepció específica per a errors de xarxa.
class NetworkException extends AppException {
  NetworkException(String message) : super('Error de xarxa: $message');
}
