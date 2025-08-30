# 🌤️ MeteoApp - Application Météo Flutter

[![Flutter](https://img.shields.io/badge/Flutter-3.9.0-blue.svg)](https://flutter.dev/)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)
[![OpenWeather API](https://img.shields.io/badge/API-OpenWeather-orange.svg)](https://openweathermap.org/api)

## 📱 Téléchargement

**APK prêt à installer :** [MeteoApp-v1.0.0.apk](release/MeteoApp-v1.0.0.apk)

## 📋 Description

Cette application Flutter permet aux utilisateurs d'obtenir les prévisions météorologiques actuelles en saisissant le nom d'une ville. Les données sont récupérées en temps réel à partir de l'API OpenWeather.

## ✨ Fonctionnalités

- 🔍 **Recherche par ville** : Saisissez le nom d'une ville pour obtenir la météo
- 🌡️ **Température en temps réel** : Affichage de la température en degrés Celsius
- ☁️ **Description météo** : Conditions météorologiques détaillées
- ⚡ **Interface réactive** : Indicateur de chargement et gestion des erreurs
- 🎨 **Design moderne** : Interface utilisateur intuitive et esthétique
- 🌍 **Support multilingue** : Interface en français

## 🏗️ Architecture

L'application est structurée en 3 classes principales :

### 1. `MonApplication`
- Classe principale qui définit l'application Flutter
- Configure le thème avec une couleur principale bleue
- Définit `PrevisionInterface` comme page d'accueil

### 2. `PrevisionInterface`
- `StatefulWidget` représentant l'interface utilisateur principale
- Contient un champ de texte pour saisir le nom de la ville
- Bouton "Obtenir la météo" pour déclencher la récupération
- Gère l'état de chargement avec `_isLoading`
- Méthode `_recupererDonnees()` pour appeler l'API OpenWeather
- Stocke les données dans `_donneesMeteo`

### 3. `DonneesMeteoWidget`
- `StatelessWidget` pour afficher les données météorologiques
- Reçoit les données en paramètre
- Affiche la température et la description météo
- Interface visuelle avec icônes et mise en forme

## 🚀 Installation

### Option 1 : Installation directe (Recommandée)

1. **Téléchargez l'APK** : [MeteoApp-v1.0.0.apk](release/MeteoApp-v1.0.0.apk)
2. **Activez l'installation d'applications inconnues** dans les paramètres Android
3. **Installez l'APK** en le tapant
4. **Lancez l'application** et commencez à utiliser !

### Option 2 : Compilation depuis les sources

1. **Clonez le repository** :
   ```bash
   git clone https://github.com/Patrickleondev/MeteoApp.git
   cd MeteoApp
   ```

2. **Installez les dépendances** :
   ```bash
   flutter pub get
   ```

3. **Lancez l'application** :
   ```bash
   flutter run
   ```

## 🔧 Configuration de l'API

### Utilisation avec votre propre clé API

Pour personnaliser l'application avec votre propre clé API OpenWeather :

1. **Créez un compte** sur [OpenWeather](https://openweathermap.org/)
2. **Obtenez votre clé API** gratuite
3. **Modifiez le fichier** `lib/config.dart` :
   ```dart
   static const String openWeatherApiKey = 'VOTRE_CLE_API_ICI';
   ```

### Configuration actuelle

L'application utilise actuellement une clé API configurée pour les tests. Pour un usage en production, utilisez votre propre clé.

## 📦 Dépendances

- `flutter/material.dart` : Interface utilisateur
- `http: ^0.13.3` : Requêtes HTTP vers l'API
- `dart:convert` : Conversion JSON

## 🔄 Fonctionnement technique

### Appel API

L'application utilise l'endpoint suivant de l'API OpenWeather :
```
https://api.openweathermap.org/data/2.5/weather?q={ville}&appid={apiKey}&units=metric&lang=fr
```

### Traitement des données

Les données JSON reçues sont converties en objet Dart :
```dart
_donneesMeteo = json.decode(reponse.body);
```

### Gestion des erreurs

L'application gère plusieurs types d'erreurs :
- Ville non trouvée
- Erreurs de connexion réseau
- Erreurs de l'API
- Données manquantes

## 📱 Utilisation

1. **Lancez l'application**
2. **Entrez le nom d'une ville** dans le champ de texte
3. **Appuyez sur "Obtenir la météo"** ou appuyez sur Entrée
4. **Attendez le chargement** des données
5. **Consultez les informations** météorologiques affichées

## 🛠️ Développement

### Prérequis

- Flutter SDK 3.9.0 ou supérieur
- Android Studio / VS Code
- Émulateur Android ou appareil physique

### Tests

Exécutez les tests unitaires :
```bash
flutter test
```

### Analyse du code

Vérifiez la qualité du code :
```bash
flutter analyze
```

## 📈 Améliorations possibles

- 🌡️ Ajout d'informations météorologiques supplémentaires (humidité, pression, vent)
- 📅 Prévisions sur plusieurs jours
- ⭐ Sauvegarde des villes favorites
- 📍 Géolocalisation automatique
- 🔔 Notifications météo
- 🎨 Interface utilisateur améliorée avec animations
- 🌙 Mode sombre
- 📊 Graphiques météorologiques

## 🤝 Contribution

Les contributions sont les bienvenues ! Pour contribuer :

1. Fork le projet
2. Créez une branche pour votre fonctionnalité
3. Committez vos changements
4. Poussez vers la branche
5. Ouvrez une Pull Request

## 📄 Licence

Ce projet est sous licence MIT. Voir le fichier [LICENSE](LICENSE) pour plus de détails.

## 🔗 Liens utiles

- **Repository GitHub** : [https://github.com/Patrickleondev/MeteoApp.git](https://github.com/Patrickleondev/MeteoApp.git)
- **Documentation Flutter** : [https://docs.flutter.dev/](https://docs.flutter.dev/)
- **API OpenWeather** : [https://openweathermap.org/api](https://openweathermap.org/api)

## 📞 Support

Pour toute question ou problème :
- Ouvrez une issue sur GitHub
- Consultez la documentation Flutter et OpenWeather API

---

**Développé avec ❤️ par Patrick Léon**
