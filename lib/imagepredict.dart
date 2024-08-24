import 'dart:convert';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:plant_care/views/guaidance.dart';
import 'package:plant_care/views/login_screen.dart';

class ImagePredictionScreen extends StatefulWidget {
  const ImagePredictionScreen({super.key});

  @override
  _ImagePredictionScreenState createState() => _ImagePredictionScreenState();
}

class _ImagePredictionScreenState extends State<ImagePredictionScreen> {
  File? _image;
  final picker = ImagePicker();
  String? _prediction;
  double? _confidence;
  bool _isLoading = false;

  Future<void> _pickImageFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
      // _predictImage();
    }
  }

  Future<void> _pickImageFromCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
      //  _predictImage();
    }
  }

  Future<void> _predictImage() async {
    if (_image == null) return;

    setState(() {
      _isLoading = true;
      _prediction = null;
      _confidence = null;
    });

    try {
      final request = http.MultipartRequest(
        'POST',
        Uri.parse(
            'http://10.0.2.2:8000/predict'), // Update with your server URL
      );
      request.files
          .add(await http.MultipartFile.fromPath('file', _image!.path));

      final response = await request.send();
      if (response.statusCode == 200) {
        final responseData = await http.Response.fromStream(response);
        final Map<String, dynamic> result = json.decode(responseData.body);
        setState(() {
          _prediction = result['class'];
          _confidence = result['confidence'];
        });
      } else {
        setState(() {
          _prediction = 'Failed to predict';
        });
      }
    } catch (e) {
      setState(() {
        _prediction = 'Error: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _showImageSourceActionSheet() {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: const Text('Select Image Source'),
        actions: <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(
            child: const Text('Camera'),
            onPressed: () {
              _pickImageFromCamera();
              Navigator.pop(context);
            },
          ),
          CupertinoActionSheetAction(
            child: const Text('Gallery'),
            onPressed: () {
              _pickImageFromGallery();
              Navigator.pop(context);
            },
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          isDefaultAction: true,
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Cancel'),
        ),
      ),
    );
  }

  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(
            'Plant Disease Prediction',
            style:
                GoogleFonts.aBeeZee(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          PopupMenuButton(
              itemBuilder: (context) => [
                    PopupMenuItem(
                      child: TextButton(
                          onPressed: () => Get.to(() => const Guaidanceview()),
                          child: const Text('Guaidance')),
                    ),
                    PopupMenuItem(
                        child: Row(
                      children: [
                        IconButton(
                            onPressed: () async {
                              await _auth.signOut();
                              Get.to(() => const LoginScreen());
                            },
                            icon: const Icon(Iconsax.logout)),
                        const Text('logout')
                      ],
                    )),
                  ]),
        ]),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Every Thing that you should need to know about the pkant diseases',
                style: GoogleFonts.montaga(fontSize: 20),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Select an Image to check',
                style: GoogleFonts.aBeeZee(fontSize: 20),
              ),
              const SizedBox(
                height: 90,
              ),
              Container(
                height: 200,
                width: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(.2),
                      spreadRadius: .2,
                      blurRadius: 4,
                      offset: const Offset(2, 3),
                    ),
                  ],
                ),
                child: _image == null
                    ? Icon(
                        Iconsax.document_upload5,
                        size: 100,
                        color: Colors.grey[600],
                      )
                    : Image.file(_image!),
              ),
              const SizedBox(height: 20),
              MaterialButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                color: Colors.blue,
                textColor: Colors.white,
                onPressed: _showImageSourceActionSheet,
                child: const Text('Pick Image'),
              ),
              MaterialButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                color: Colors.blue,
                textColor: Colors.white,
                onPressed: _predictImage,
                child: const Text('Predict  Image'),
              ),
              const SizedBox(height: 20),
              _isLoading
                  ? const CircularProgressIndicator()
                  : _prediction != null
                      ? Column(
                          children: [
                            Text('Prediction: $_prediction'),
                            Text(
                              _confidence != null
                                  ? 'Confidence: ${(_confidence! * 100).toStringAsFixed(2)}%'
                                  : 'Confidence: N/A',
                            ),
                          ],
                        )
                      : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
