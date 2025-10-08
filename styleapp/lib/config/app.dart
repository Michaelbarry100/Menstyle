import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConfig {
  static String apiBaseUrl = dotenv.get('API_BASE_URL');
  static String fcmKey = dotenv.get('FCM_KEY');
}