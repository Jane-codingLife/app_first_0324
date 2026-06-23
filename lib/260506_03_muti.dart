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
    return const MaterialApp(home: MyHomePage());
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final ValueNotifier<List<XFile>> _imageFiles = ValueNotifier([]);
  final ImagePicker _imagePicker = ImagePicker();

  @override
  void dispose() {
    _imageFiles.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final btnCameraImage = ElevatedButton(
      onPressed: _takePicture,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 28),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      child: const Text(
        '相機拍照',
        style: TextStyle(fontSize: 18, color: Colors.white),
      ),
    );
    final btnGalleryImage = ElevatedButton(
      onPressed: _selectImages,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.green,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 28),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      child: const Text(
        '從相簿挑照片',
        style: TextStyle(fontSize: 18, color: Colors.white),
      ),
    );

    return Scaffold(
      appBar: AppBar(title: Text("挑選照片")),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 10),
              btnCameraImage,
              SizedBox(height: 10, width: 20),
              btnGalleryImage,
            ],
          ),
          SizedBox(height: 10),
          Expanded(
            child: Center(
              child: ValueListenableBuilder<List<XFile>>(
                valueListenable: _imageFiles,
                builder: _imageBuilder,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _takePicture() async {
    final XFile? photo = await _imagePicker.pickImage(
      source: ImageSource.camera,
    );
    if (photo != null) {
      _imageFiles.value = [photo];
    }
  }

  Future<void> _selectImages() async {
    final List<XFile>? files = await _imagePicker.pickMultiImage();
    if (files != null && files.isNotEmpty) {
      _imageFiles.value = files;
    }
  }

  Widget _imageBuilder(
    BuildContext context,
    List<XFile> imageFiles,
    Widget? child,
  ) {
    if (imageFiles.isEmpty) {
      return const Text('沒有照片', style: TextStyle(fontSize: 20));
    }
    return GridView.builder(
      padding: const EdgeInsets.all(20),
      physics: const BouncingScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
      itemCount: imageFiles.length,
      itemBuilder: (context, index) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.file(File(imageFiles[index].path), fit: BoxFit.cover),
        );
      },
    );
  }
}
