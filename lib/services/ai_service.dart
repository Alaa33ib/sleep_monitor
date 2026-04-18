import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;

class AIService {
  // Use 10.0.2.2 if using Android Emulator.
  // Use your Laptop's IP (e.g., 192.168.x.x) if using a real phone.
  static const String _baseUrl = "http://10.0.2.2:8000/api/predict";

  static Future<Map<String, dynamic>?> predictStatus(Uint8List imageBytes) async {
    try {
      // 1. Convert image to Base64 as required by her 'ImageRequest' model
      String base64Image = base64Encode(imageBytes);

      // 2. Send POST request
      final response = await http.post(
        Uri.parse(_baseUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"image": base64Image}),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        print("Server Error: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("Connection Error: $e");
      return null;
    }
  }
}