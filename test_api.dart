import 'package:http/http.dart' as http;
import 'dart:convert';

void main() async {
  print('=== Test de l\'API OpenWeather ===');
  
  // Configuration directe
  const apiKey = 'e5caacd0d57c4817b331a31ebe27927b';
  const baseUrl = 'https://api.openweathermap.org/data/2.5/weather';
  
  // Test avec une ville simple
  final ville = 'Paris';
  final url = '$baseUrl?q=$ville&appid=$apiKey&units=metric&lang=fr';
  
  print('URL de test: $url');
  print('Clé API: $apiKey');
  
  try {
    print('\nEnvoi de la requête...');
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ).timeout(const Duration(seconds: 10));
    
    print('Code de statut: ${response.statusCode}');
    print('Headers: ${response.headers}');
    
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print('\n✅ Succès! Données reçues:');
      print('Ville: ${data['name']}');
      print('Température: ${data['main']['temp']}°C');
      print('Description: ${data['weather'][0]['description']}');
    } else {
      print('\n❌ Erreur HTTP: ${response.statusCode}');
      print('Réponse: ${response.body}');
    }
  } catch (e) {
    print('\n❌ Erreur de connexion: $e');
  }
}
