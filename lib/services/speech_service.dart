import 'dart:convert';
import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class SpeechService {
  final apiKey = dotenv.env["API_KEY"].toString();
  static const String apiUrl = 'https://api.assemblyai.com/v2/';

  Future<String> uploadAudio(File audioFile) async {
    final response = await http.post(
      Uri.parse('${apiUrl}upload'),
      headers: {
        'authorization': apiKey,
      },
      body: audioFile.readAsBytesSync(),
    );

    if (response.statusCode == HttpStatus.ok) {
      final decodedResponse = jsonDecode(response.body);
      return decodedResponse['upload_url'];
    } else {
      throw Exception('Failed to upload audio');
    }
  }

  Future<String> transcribeUploadedAudio(String uploadUrl) async {
    final response = await http.post(
      Uri.parse('${apiUrl}transcript'),
      headers: {'authorization': apiKey, 'content-type': 'application/json'},
      body: jsonEncode({'audio_url': uploadUrl}),
    );

    if (response.statusCode == HttpStatus.ok) {
      final decodedResponse = jsonDecode(response.body);
      return decodedResponse['id'];
    } else {
      throw Exception('Failed to transcribe audio');
    }
  }

  Future<String> getTranscription(String id) async {
    while (true) {
      final response = await http.get(
        Uri.parse('${apiUrl}transcript/$id'),
        headers: {'authorization': apiKey},
      );

      final decodedResponse = jsonDecode(response.body);

      if (response.statusCode == HttpStatus.ok) {
        if (decodedResponse['status'] == 'completed') {
          return decodedResponse['text'];
        }
      } else {
        throw Exception('Failed to get transcription');
      }
    }
  }
}
