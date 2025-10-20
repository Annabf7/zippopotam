/// FITXER: zip_response.dart
///
/// QUÈ ÉS:
/// Defineix el model de dades `ZipInfo`, que representa la informació que volem
/// mostrar a l'usuari (localitat, estat, codi postal).
///
/// PER QUÈ EXISTEIX:
// ignore: unintended_html_in_doc_comment
/// Per convertir la resposta JSON (que és bàsicament un Map<String, dynamic>) en un
/// objecte Dart amb tipus segurs (typed object). Això ens dóna autocompletat a l'IDE,
/// prevé errors de tipus en temps d'execució i fa el codi molt més llegible i segur.
///
/// RELACIÓ AMB ALTRES:
/// ZipRepository crea instàncies de ZipInfo a partir del JSON que rep de ZipApiService.
/// La UI (ZipCard) rep un objecte ZipInfo per mostrar les seves dades.
library;

class ZipInfo {
  final String placeName;
  final String state;
  final String postCode;

  ZipInfo({
    required this.placeName,
    required this.state,
    required this.postCode,
  });

  // Aquest és un "constructor factory". És un mètode que crea una instància de la classe.
  // El fem servir per encapsular la lògica de conversió de JSON a un objecte ZipInfo.
  // Aquesta implementació és robusta perquè gestiona camps que podrien ser nuls
  // o no existir al JSON, assignant un valor per defecte ('N/A').
  factory ZipInfo.fromJson(Map<String, dynamic> json) {
    return ZipInfo(
      // El camp 'place name' del JSON té un espai, per això accedim amb ['place name'].
      placeName: json['place name'] ?? 'N/A',
      // L'estat/província.
      state: json['state'] ?? 'N/A',
      // L'API retorna el codi postal en el camp 'post code' per a la cerca per localitat,
      // però el camp es diu 'post code' quan cerquem per codi postal.
      // Aquesta lògica es gestiona millor al repository, que unifica el model.
      // Aquí assumim que el camp ja ve normalitzat com 'postCode'.
      postCode: json['postCode'] ?? json['post code'] ?? 'N/A',
    );
  }
}
