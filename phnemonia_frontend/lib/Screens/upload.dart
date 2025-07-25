import 'package:flutter/material.dart';
import 'dart:async';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
//import 'package:path/path.dart';
import 'dart:io';

class UploadScreen extends StatefulWidget {
  const UploadScreen({super.key});

  @override
  State<UploadScreen> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<UploadScreen> {

  File? _image;
  String _result = '';

  Future<void> pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> uploadImage() async {
    if (_image == null) return;

    final uri = Uri.parse("http://10.0.2.2:5000/predict"); // Update with your Flask API URL
    final request = http.MultipartRequest('POST', uri);
    request.files.add(await http.MultipartFile.fromPath('image', _image!.path));

    final response = await request.send();

    if (response.statusCode == 200) {
      
      final result = await response.stream.bytesToString();
      setState(() {
        _result = result;
        final prediction = _result;

        //print('Prediction: $prediction');

    String message;
    

        if (_result.toUpperCase() == 'NORMAL') {
      message = "🎉 Happy news! Your case is NORMAL.";
      //icon = Icon(Icons.mood, color: Colors.green, size: 40);
    } else {
      message =
          "⚠️ You are likely to have affected with PNEUMONIA.\nPlease consult a doctor.";
      //icon = Icon(Icons.warning_amber_rounded, color: Colors.red, size: 40);
    }

        showResultDialog(context, message );
      });
    } else {
      setState(() {
        _result = 'Error: ${response.statusCode}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
               Text("Upload the x_ray below to get it diagnose it",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold
                  //color: Colors.brown
                ),
                ),
                SizedBox(height: 5,),
                Text("(Note* : The image format should be jpeg/jpg/png)",
                style: TextStyle(
                  color: Colors.red
                ),
                ),
                SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: pickImage,
                  icon: Icon(Icons.image),
                  label: Text('Pick X-ray Image'),
                ),
                SizedBox(height: 10),
                if (_image != null) Image.file(_image!, height: 200),
                SizedBox(height: 10),
                ElevatedButton.icon(
                  onPressed: uploadImage,
                  icon: Icon(Icons.cloud_upload),
                  label: Text('Upload & Diagnose'),
                ),
                SizedBox(height: 20),
                
            ],
          ),
          )
          ),
    );
  }
}

void showResultDialog(BuildContext context, String result,) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: Row(
        children: [
          Icon(Icons.medical_services, color: Colors.blueAccent),
          SizedBox(width: 10),
          Text('Diagnosis Result'),
        ],
      ),
      content: Text(
        result,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Row(
            children: [
              Icon(Icons.arrow_back),
              SizedBox(width: 5),
              Text('Go Back'),
            ],
          ),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context), // Replace with exit logic if needed
          child: Row(
            children: [
              Icon(Icons.close),
              SizedBox(width: 5),
              Text('Exit'),
            ],
          ),
        ),
      ],
    ),
  );
}
