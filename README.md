<div align="center"> <h1>📮 Cercador de Codis Postals — Zippopotam API</h1> <p><b>Flutter app</b> per cercar <b>codis postals d’Espanya</b> amb la <b>API pública de Zippopotam</b>.</p> <p><i>Activitat d’Avaluació 1.4 — Curs “Desenvolupament d’Aplicacions Mòbils per a iOS i Android amb Flutter”</i></p> <br> <!-- Badges -->

<a href="https://flutter.dev/"><img alt="Flutter" src="https://img.shields.io/badge/Flutter-02569B?logo=flutter&logoColor=white&style=for-the-badge"></a>
<a href="https://dart.dev/"><img alt="Dart" src="https://img.shields.io/badge/Dart-0175C2?logo=dart&logoColor=white&style=for-the-badge"></a>
<a href="https://api.zippopotam.us/"><img alt="API" src="https://img.shields.io/badge/Zippopotam%20API-0B7285?style=for-the-badge"></a>
<a href="LICENSE"><img alt="License" src="https://img.shields.io/badge/License-MIT-43A047?style=for-the-badge"></a>

</div>
 <h2>✨Funcionalitats</h2></div>

<ul>
  <li>🔍 <b>Cerca flexible:</b> <br> Permet introduir codis postals o noms de localitat.</li><br>
  <li>⚙️ <b>Interfície reactiva:</b> <br> Gestiona càrrega, errors i resultats buits amb feedback visual.</li><br>
  <li>🗺️ <b>Google Maps integrat:</b> <br> Obre la ubicació exacta amb un sol clic.</li><br>
  <li>💾 <b>Arquitectura neta:</b> <br> Basada en UI, Repository i Models per a un codi escalable.</li>
</ul>


<h2>🛠️ Stack i Dependències</h2>
<table> <thead> <tr> <th>Paquet</th> <th>Ús</th> </tr> </thead> <tbody> <tr> <td><a href="https://pub.dev/packages/http"><code>http</code></a></td> <td>Peticions HTTP i consum de JSON</td> </tr> <tr> <td><a href="https://pub.dev/packages/url_launcher"><code>url_launcher</code></a></td> <td>Obrir Google Maps i enllaços externs</td> </tr> <tr> <td><a href="https://pub.dev/packages/google_fonts"><code>google_fonts</code></a></td> <td>Tipografia personalitzada</td> </tr> </tbody> </table>
<h2>🏗️ Arquitectura</h2>
<details> <summary><b>Visió general (capes)</b></summary> <br>

🎨 Presentació (UI): HomePage, ZipCard, etc.
Mostra estat i captura interaccions.

🧠 Dades (Repository): ZipRepository
Lògica de negoci, crides a API, transformació de respostes.

🧩 Models: ZipInfo
JSON → objectes Dart amb tipatge fort.

</details> <details> <summary><b>Punts clau</b></summary> <br>

⚡ Gestió d’estat: StatefulWidget + setState

⏳ Asíncronia: Future, async/await

🧱 Errors segurs: classe Result (Success/Failure) per tractar errors com a estat de la UI

</details>
<h2>🚀 Execució local</h2>

1️⃣ Clona el repositori
git clone https://github.com/Annabf7/zippopotam.git

2️⃣ Entra a la carpeta
cd zippopotam

3️⃣ Instal·la dependències
flutter pub get

4️⃣ Executa l'app
flutter run

<br>
<br>
<h3>👩‍💻 Autora</h3>
Anna Borràs Font — Front-End & Mobile Developer (React / Flutter) | UX/UI Designer | Motion Graphics Artist
🌐 <a href="https://www.aborrasdesign.com">aborrasdesign.com</a> </a>
