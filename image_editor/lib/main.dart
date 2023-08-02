import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Image Editor'),
        ),
        body: SplitView(),
      ),
    );
  }
}

class SplitView extends StatefulWidget {
  @override
  _SplitViewState createState() => _SplitViewState();
}

class _SplitViewState extends State<SplitView> {
  List<File> images = []; // List to store selected images

  Future<void> _addImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        images.add(File(pickedImage.path));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: images.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: Container(
                  width: 100,
                  child: Image.file(images[index], fit: BoxFit.contain),
                  ),
                title: Text(images[index].path),
                trailing: IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {
                    setState(() {
                      images.removeAt(index);
                    });
                  },
                ),
              );
            },
          ),
        ),
        ElevatedButton(
          onPressed: _addImage,
          child: Text('Add Image'),
        ),
      ],
    );
  }
}
