/// FITXER: result.dart
///
/// QUÈ ÉS:
/// Una classe segellada (sealed class) que representa el resultat d'una operació
/// que pot tenir èxit (Success) o fallar (Failure).
///
/// PER QUÈ EXISTEIX:
/// Per gestionar èxits i errors de forma explícita i segura, sense haver de recórrer
/// a `try-catch` a la capa de la UI. El Repository retornarà un `Result`, i la UI
/// només haurà de comprovar si és `Success` o `Failure` per saber què mostrar,
/// fent el codi més previsible i evitant que una excepció no controlada "trenqui" l'app.
///
/// RELACIÓ AMB ALTRES:
/// És el tipus de retorn del mètode principal del ZipRepository. HomePage utilitza
/// aquest objecte per decidir quin widget mostrar (llista de resultats, missatge d'error, etc.).
library;

import 'package:zippopotam/core/exceptions.dart';

// Definim una classe base abstracta. No es pot instanciar directament.
abstract class Result<T> {}

// Aquesta classe representa un resultat exitós i conté les dades <T>.
class Success<T> extends Result<T> {
  final T data;
  Success(this.data);
}

// Aquesta classe representa un error i conté l'excepció que el va causar.
class Failure<T> extends Result<T> {
  final AppException exception;
  Failure(this.exception);
}
