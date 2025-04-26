import 'package:google_generative_ai/google_generative_ai.dart';

class GeminiService {
  final String apiKey = "AIzaSyAPVL4SGqUWA4QSb-Sfr6AfonSfjc_uP7U";  // Replace with your key
  late GenerativeModel _model;

  GeminiService() {
    _model = GenerativeModel(model: 'gemini-2.0-flash', apiKey: apiKey);
  }

  Future<String> getResponse(String prompt) async {
    try {
      final response = await _model.generateContent([Content.text(prompt)]);
      return response.text ?? "No response generated.";
    } catch (e) {
      return "Error: ${e.toString()}";
    }
  }
}
