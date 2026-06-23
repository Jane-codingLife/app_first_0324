import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(const MyApp());
}

// StatelessWidget 不會變更的 UI
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build 外框
    return MaterialApp(
      title: "Image Picker Example",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final ValueNotifier<XFile?> _imageFile = ValueNotifier(null);
  final ImagePicker _imagePicker = ImagePicker();

  @override
  void dispose() {
    _imageFile.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final btnCameraImage = ElevatedButton(
      onPressed: () => _getImage(ImageSource.camera),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 28),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: const Text(
        '相機拍照',
        style: TextStyle(fontSize: 18, color: Colors.white),
      ),
    );
    final btnGalleryImage = ElevatedButton(
      onPressed: () => _getImage(ImageSource.gallery),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.green,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 28),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: const Text(
        '從相簿挑照片',
        style: TextStyle(fontSize: 18, color: Colors.white),
      ),
    );

    return Scaffold(
      appBar: AppBar(title: const Text('挑選照片'), centerTitle: true),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 10,),
              btnCameraImage,
              const SizedBox(height: 10, width: 20,),
              btnGalleryImage,
            ],
          ),
          const SizedBox(height: 10),
          Expanded(
            child: Center(
              child: ValueListenableBuilder<XFile?>(
                valueListenable: _imageFile,
                builder: _imageBuilder,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _getImage(ImageSource source) async {
    final XFile? file = await _imagePicker.pickImage(source: source);
    if (file != null) {
      _imageFile.value = file;
    }
  }

  Widget _imageBuilder(BuildContext context, XFile? imageFile, Widget? child) {
    if (imageFile == null) {
      return const Text('沒有照片', style: TextStyle(fontSize: 20));
    }
    return Image.file(File(imageFile.path), fit: BoxFit.contain);
  }
}
