import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class ImageUploader {
  final String apiUrl;

  ImageUploader({required this.apiUrl});

  // Function to upload image
  Future<void> uploadImage(File imageFile) async {
    try {
      var request = http.MultipartRequest('POST', Uri.parse(apiUrl));
      request.files.add(await http.MultipartFile.fromPath('file', imageFile.path));
      var response = await request.send();

      if (response.statusCode == 200) {
        final responseData = await response.stream.bytesToString();
        final result = jsonDecode(responseData);
        print("Predicted class: ${result['class']}");
        print("Confidence: ${result['Confidence']}");
      } else {
        print("Failed to get prediction");
      }
    } catch (e) {
      print("Error uploading image: $e");
    }
  }

  // Function to pick image from gallery
  Future<void> pickAndUploadImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      await uploadImage(File(pickedFile.path));
    } else {
      print("No image selected");
    }
  }
}
