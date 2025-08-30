import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'config.dart';

void main() {
  runApp(const MonApplication());
}

// Classe MonApplication - Définit l'application Flutter principale
class MonApplication extends StatelessWidget {
  const MonApplication({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Application Météo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const PrevisionInterface(),
    );
  }
}

// Classe PrevisionInterface - Interface utilisateur principale
class PrevisionInterface extends StatefulWidget {
  const PrevisionInterface({super.key});

  @override
  State<PrevisionInterface> createState() => _PrevisionInterfaceState();
}

class _PrevisionInterfaceState extends State<PrevisionInterface> {
  final TextEditingController _controller = TextEditingController();
  bool _isLoading = false;
  Map<String, dynamic>? _donneesMeteo;
  String _errorMessage = '';

  // Méthode pour récupérer les données météo depuis l'API OpenWeather
  Future<void> _recupererDonnees() async {
    final ville = _controller.text.trim();
    
    if (ville.isEmpty) {
      setState(() {
        _errorMessage = 'Veuillez entrer le nom d\'une ville';
        _donneesMeteo = null;
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = '';
      _donneesMeteo = null;
    });

    try {
      final url = Config.buildWeatherUrl(ville);
      final reponse = await http.get(Uri.parse(url));
      
      if (reponse.statusCode == 200) {
        setState(() {
          _donneesMeteo = json.decode(reponse.body);
          _isLoading = false;
        });
      } else {
        setState(() {
          _errorMessage = 'Erreur: Impossible de récupérer les données pour $ville';
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Erreur de connexion: $e';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Prévisions météo'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
                         // Champ de texte pour entrer le nom de la ville
             TextField(
               controller: _controller,
               decoration: const InputDecoration(
                 labelText: 'Entrez une ville',
                 border: OutlineInputBorder(),
                 prefixIcon: Icon(Icons.location_city),
               ),
               onSubmitted: (_) => _recupererDonnees(),
             ),
            
            const SizedBox(height: 16),
            
                         // Bouton pour obtenir la météo
             ElevatedButton(
               onPressed: _isLoading ? null : _recupererDonnees,
               style: ElevatedButton.styleFrom(
                 backgroundColor: Colors.blue,
                 foregroundColor: Colors.white,
                 minimumSize: const Size(double.infinity, 50),
               ),
               child: const Text(
                 'Obtenir la météo',
                 style: TextStyle(fontSize: 16),
               ),
             ),
            
            const SizedBox(height: 24),
            
            // Affichage du chargement
            if (_isLoading)
              const Column(
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('Chargement des données météo...'),
                ],
              ),
            
            // Affichage des erreurs
            if (_errorMessage.isNotEmpty)
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.red.shade100,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  _errorMessage,
                  style: TextStyle(color: Colors.red.shade800),
                ),
              ),
            
                         // Affichage des données météo
             if (_donneesMeteo != null && !_isLoading)
               DonneesMeteoWidget(donneesMeteo: _donneesMeteo!),
             
             // Message par défaut si aucune donnée
             if (_donneesMeteo == null && !_isLoading && _errorMessage.isEmpty)
               const Text(
                 'Aucune donnée météo disponible.',
                 style: TextStyle(fontSize: 16, color: Colors.grey),
               ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

// Classe DonneesMeteoWidget - Affiche les données météorologiques
class DonneesMeteoWidget extends StatelessWidget {
  final Map<String, dynamic> donneesMeteo;

  const DonneesMeteoWidget({super.key, required this.donneesMeteo});

  @override
  Widget build(BuildContext context) {
    try {
      final main = donneesMeteo['main'] as Map<String, dynamic>;
      final weather = donneesMeteo['weather'] as List;
      final weatherData = weather.first as Map<String, dynamic>;
      
      final temperature = main['temp']?.toString() ?? 'N/A';
      final description = weatherData['description']?.toString() ?? 'N/A';
      final ville = donneesMeteo['name']?.toString() ?? 'Ville inconnue';

      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.blue.shade50,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.blue.shade200),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              ville,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Icon(Icons.thermostat, size: 30, color: Colors.orange),
                const SizedBox(width: 8),
                                 Text(
                   'Température: $temperature°C',
                   style: const TextStyle(fontSize: 18),
                 ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.cloud, size: 30, color: Colors.grey),
                const SizedBox(width: 8),
                Text(
                  'Description: $description',
                  style: const TextStyle(fontSize: 18),
                ),
              ],
            ),
          ],
        ),
      );
    } catch (e) {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.red.shade100,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          'Erreur lors de l\'affichage des données: $e',
          style: TextStyle(color: Colors.red.shade800),
        ),
      );
    }
  }
}
