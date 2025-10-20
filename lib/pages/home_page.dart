/// FITXER: home_page.dart
///
/// QUÈ ÉS:
/// La pantalla principal de l'aplicació. És un StatefulWidget perquè el seu contingut
/// canvia en funció de les accions de l'usuari (escriure, cercar) i dels resultats de l'API.
///
/// PER QUÈ EXISTEIX:
/// Per orquestrar la UI. Conté l'estat actual de la pantalla (està carregant? hi ha un
/// error? quins són els resultats?) i decideix quin widget mostrar en cada moment
/// (l'indicador de càrrega, la llista de resultats, el missatge d'error, etc.).
///
/// RELACIÓ AMB ALTRES:
/// Utilitza els widgets personalitzats (SearchBar, ZipCard, etc.).
/// Té una instància de ZipRepository per demanar les dades.
/// Actualitza el seu estat amb `setState` per redibuixar la UI quan les dades canvien.
library;

import 'package:flutter/material.dart';
import 'package:zippopotam/core/result.dart';
import 'package:zippopotam/data/models/zip_response.dart';
import 'package:zippopotam/data/repositories/zip_repository.dart';
import 'package:zippopotam/widgets/empty_view.dart';
import 'package:zippopotam/widgets/error_view.dart';
import 'package:zippopotam/widgets/search_bar.dart';
import 'package:zippopotam/widgets/zip_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // L'estat de la nostra pàgina.
  bool _isLoading = false;
  String? _errorMessage;
  List<ZipInfo> _results = [];
  bool _hasSearched = false; // Per saber si ja s'ha fet una cerca.

  // Instància del repository. La UI no sap com funciona per dins, només crida el mètode 'search'.
  late final ZipRepository _repository;
  // Per controlar el text del TextField des d'aquí.
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _repository = ZipRepository();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // Aquesta és la funció principal que s'executa quan l'usuari prem "Cercar".
  Future<void> _performSearch(String query) async {
    if (query.isEmpty) return;

    // Amaguem el teclat.
    FocusScope.of(context).unfocus();

    // Actualitzem l'estat per mostrar l'indicador de càrrega.
    // setState notifica a Flutter que l'estat ha canviat i que ha de redibuixar la UI.
    setState(() {
      _isLoading = true;
      _errorMessage = null;
      _hasSearched = true;
    });

    final result = await _repository.search(query);

    // Un cop tenim el resultat, actualitzem l'estat de nou.
    setState(() {
      // El `switch` sobre el `result` ens obliga a gestionar tots els casos (Success/Failure),
      // fent el codi molt més segur.
      switch (result) {
        case Success(data: final zipInfos):
          _results = zipInfos;
          _errorMessage = null;
        case Failure(exception: final e):
          _results = [];
          _errorMessage = e.message;
      }
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cercador de Codis Postals')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // El nostre widget personalitzat per a la barra de cerca.
            // Li passem el controlador i la funció que ha d'executar quan es premi el botó.
            CustomSearchBar(
              controller: _controller,
              onSearch: () => _performSearch(_controller.text),
            ),
            const SizedBox(height: 24),
            // La part de la UI que canvia segons l'estat.
            Expanded(child: _buildResultsView()),
          ],
        ),
      ),
    );
  }

  // Aquest mètode decideix quin widget mostrar en funció de l'estat actual.
  Widget _buildResultsView() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (_errorMessage != null) {
      return ErrorView(
        message: _errorMessage!,
        onRetry: () => _performSearch(_controller.text),
      );
    }
    if (!_hasSearched) {
      // Abans de la primera cerca, no mostrem res.
      return const Center(
        child: Text('Introdueix un codi postal o localitat per començar.'),
      );
    }
    if (_results.isEmpty) {
      return const EmptyView();
    }
    // Si tenim resultats, mostrem una llista.
    return ListView.builder(
      itemCount: _results.length,
      itemBuilder: (context, index) {
        return ZipCard(info: _results[index]);
      },
    );
  }
}
/*
================================================================================
MINI README
================================================================================

Aquesta app demostra una arquitectura neta en Flutter per consumir una API REST.

---
COM EXECUTAR-LA
---
1. Assegura't de tenir les dependències al `pubspec.yaml` (http, google_fonts).
2. Obre una terminal a l'arrel del projecte i executa:
   flutter pub get
3. Després, per llançar l'app a un emulador o dispositiu:
   flutter run

---
COM PROVAR-LA
---
- Cerca per codi postal: escriu `08907` i prem "Cercar".
- Cerca per localitat: escriu `hospi` o `girona` i prem "Cercar".
- Prova un codi que no existeix (ex: `99999`) per veure l'estat "sense resultats".
- Desactiva el WiFi/dades per veure el missatge d'error de xarxa.

---
QÜESTIONS TÈCNIQUES CLAU
---
- Arquitectura per Capes:
  - UI (pages/widgets): Només mostra dades i captura input. No sap d'on vénen les dades.
  - Repository (repositories): El cervell. Orquestra les crides i transforma les dades.
  - Service (services): L'obrer. Només parla amb l'API i gestiona la comunicació HTTP.
- Gestió d'Estat: S'utilitza `StatefulWidget` amb `setState` per a la simplicitat.
- Gestió d'Errors: L'ús de la classe `Result` evita que les excepcions arribin a la UI,
  convertint-les en un estat que la UI pot gestionar de forma segura.
- Normalització de l'API: El `ZipRepository` analitza les dues respostes diferents de
  l'API (per codi postal vs. per localitat) i les converteix en una única llista
  consistent de `ZipInfo`, simplificant la feina de la UI.
*/
