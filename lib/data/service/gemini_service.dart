import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:injectable/injectable.dart';
import 'package:todo_ai/model/todo.dart';

@injectable
class GeminiService {
  late final GenerativeModel _model;

  GeminiService() {
    // Note: In production, you should store the API key securely
    // For demo purposes, we'll use a placeholder
    String apiKey = dotenv.env['GEMINI_API_KEY'] ?? '';
    _model = GenerativeModel(model: 'gemini-1.5-flash', apiKey: apiKey);
  }

  Future<String> generateTodoSuggestion(Todo todo) async {
    try {
      final prompt =
          '''
      Berikan saran atau motivasi singkat (maksimal 2-3 kalimat) untuk menyelesaikan todo berikut:
      
      Judul: ${todo.title}
      Deskripsi: ${todo.description?.isNotEmpty == true ? todo.description : 'Tidak ada deskripsi'}
      
      Saran harus:
      - Motivasi dan positif
      - Praktis dan actionable
      - Dalam bahasa Indonesia
      - Maksimal 50 kata
      ''';

      final response = await _model.generateContent([Content.text(prompt)]);
      return response.text?.trim() ??
          'Mari selesaikan tugas ini dengan semangat!';
    } catch (e) {
      // Fallback jika API gagal
      return 'Waktunya untuk menyelesaikan "${todo.title}". Kamu pasti bisa!';
    }
  }

  Future<String> generateRandomMotivation() async {
    try {
      const prompt = '''
      Berikan motivasi singkat (1 kalimat) untuk menyelesaikan tugas atau todo.
      Harus positif, energik, dan dalam bahasa Indonesia.
      ''';

      final response = await _model.generateContent([Content.text(prompt)]);
      return response.text?.trim() ??
          'Setiap langkah kecil membawa kita lebih dekat ke tujuan!';
    } catch (e) {
      return 'Setiap langkah kecil membawa kita lebih dekat ke tujuan!';
    }
  }

  Future<String> generateCompletionMessage(int completed, int total) async {
    try {
      final prompt =
          '''
      Berikan ucapan selamat singkat (2-3 kalimat) karena telah menyelesaikan semua $completed dari $total todo/tugas.
      
      Ucapan harus:
      - Antusias dan merayakan pencapaian
      - Memberikan motivasi untuk istirahat sejenak
      - Dalam bahasa Indonesia
      - Maksimal 60 kata
      - Gunakan emoji jika cocok
      ''';

      final response = await _model.generateContent([Content.text(prompt)]);
      return response.text?.trim() ??
          'Luar biasa! Anda telah menyelesaikan semua tugas. Saatnya merayakan!';
    } catch (e) {
      return 'Luar biasa! Anda telah menyelesaikan semua tugas. Saatnya merayakan!';
    }
  }

  Future<String> generateCreateTodoInvitation() async {
    try {
      const prompt = '''
      Berikan ajakan singkat (2-3 kalimat) untuk membuat todo/tugas pertama kali.
      
      Ajakan harus:
      - Motivasi dan inspiratif
      - Membuat user ingin membuat todo
      - Dalam bahasa Indonesia
      - Maksimal 50 kata
      - Gunakan emoji jika cocok
      ''';

      final response = await _model.generateContent([Content.text(prompt)]);
      return response.text?.trim() ??
          'Mulai dengan todo pertama Anda dan raih impian! 🚀';
    } catch (e) {
      return 'Mulai dengan todo pertama Anda dan raih impian! 🚀';
    }
  }
}
