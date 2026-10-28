import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static const String temasKey = 'temas_usuario';

  static Future<void> salvarJson(
    String json,
  ) async {
    final prefs =
        await SharedPreferences.getInstance();

    await prefs.setString(
      temasKey,
      json,
    );
  }

  static Future<String?> carregarJson() async {
    final prefs =
        await SharedPreferences.getInstance();

    return prefs.getString(
      temasKey,
    );
  }
}