// Configuration de l'application météo
class Config {
  // Clé API OpenWeather
  // Obtenez votre clé gratuite sur : https://openweathermap.org/api
  static const String openWeatherApiKey = 'e5caacd0d57c4817b331a31ebe27927b';
  
  // URL de base de l'API OpenWeather
  static const String openWeatherBaseUrl = 'https://api.openweathermap.org/data/2.5/weather';
  
  // Paramètres par défaut pour les requêtes API
  static const String units = 'metric'; // Celsius
  static const String language = 'fr'; // Français
  
  // Construction de l'URL complète pour une ville donnée
  static String buildWeatherUrl(String city) {
    return '$openWeatherBaseUrl?q=$city&appid=$openWeatherApiKey&units=$units&lang=$language';
  }
}
