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
    final btnPickImage = ElevatedButton(
      onPressed: _pickImages,
      child: const Text('選擇圖片'),
    );

    return Scaffold(
      appBar: AppBar(title: const Text('GridView圖片範例')),
      body: Column(
        children: [
          const SizedBox(height: 20),
          btnPickImage,
          const SizedBox(height: 20),
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: _imageFiles,
              builder: (context, images, _) {
                if (images.isEmpty) {
                  return const Center(child: Text('尚未選擇圖片'));
                }

                return GridView.builder(
                  padding: const EdgeInsets.all(20),
                  physics: const BouncingScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                  ),
                  itemCount: images.length,
                  itemBuilder: (context, index) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.file(
                        File(images[index].path),
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _pickImages() async {
    final List<XFile>? files = await _imagePicker.pickMultiImage();
    if (files != null && files.isNotEmpty) {
      _imageFiles.value = files;
    }
  }
}
