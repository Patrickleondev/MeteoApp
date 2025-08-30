// Test de base pour l'application météo Flutter
//
// Pour effectuer une interaction avec un widget dans le test, utilisez l'utilitaire WidgetTester
// du package flutter_test. Par exemple, vous pouvez envoyer des gestes de tap et scroll.
// Vous pouvez également utiliser WidgetTester pour trouver des widgets enfants dans l'arbre
// des widgets, lire du texte et vérifier que les valeurs des propriétés des widgets sont correctes.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:activite_4/main.dart';

void main() {
  testWidgets('Test de base de l\'application météo', (WidgetTester tester) async {
    // Construire notre application et déclencher un frame.
    await tester.pumpWidget(const MonApplication());

    // Vérifier que le titre de l'application est présent.
    expect(find.text('Prévisions météo'), findsOneWidget);
    
    // Vérifier que le champ de texte pour entrer la ville est présent.
    expect(find.byType(TextField), findsOneWidget);
    
    // Vérifier que le bouton "Obtenir la météo" est présent.
    expect(find.text('Obtenir la météo'), findsOneWidget);
    
    // Vérifier que le message par défaut est affiché.
    expect(find.text('Aucune donnée météo disponible.'), findsOneWidget);
  });
}
