import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as img;
import 'dart:io';

void main() {
  runApp(MyApp());
}

String titleOfApp = "Image Editor";

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Image Processing App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ImageGridPage(),
    );
  }
}

class ImageGridPage extends StatefulWidget {
  @override
  _ImageGridPageState createState() => _ImageGridPageState();
}

class _ImageGridPageState extends State<ImageGridPage> {
  List<File> selectedImages = [];
  List<File> allImages = [];

    void _showImagePicker() async {
    List<XFile>? pickedFile = await ImagePicker().pickMultiImage(imageQuality: 80);
    if (pickedFile != null) {
      setState(() {
        allImages.addAll(pickedFile.map((file) => File(file.path)).toList());
      });
    }
  }

  void _clearIamges(){
    setState(() {
      allImages.clear();
      selectedImages.clear();
    });
    }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(titleOfApp),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 5,
        ),
        itemCount: allImages.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                if (selectedImages.contains(allImages[index])) {
                  selectedImages.remove(allImages[index]);
                } else {
                  selectedImages.add(allImages[index]);
                }
              });
            },
            child: Stack(
              alignment: Alignment.topRight,
              children: [
                Image.file(
                    allImages[index],
                    width: 120,
                    height: 120,
                    fit: BoxFit.contain,
                  ),

                  Checkbox(
                    value: selectedImages.contains(allImages[index]),
                    onChanged: (value) {
                      setState(() {
                        if (value!) {
                          selectedImages.add(allImages[index]);
                        } else {
                          selectedImages.remove(allImages[index]);
                        }
                      });
                    },
                  ),

              ],
            ),
          );
        },
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
        onPressed: _showImagePicker,
        child: const Icon(Icons.add),
      ),
      const SizedBox(width: 16), 
          FloatingActionButton(
            onPressed: _clearIamges,
            child: const Icon(Icons.clear),
          ),
        ],
      ),
       
      bottomNavigationBar: selectedImages.isNotEmpty
          ? BottomAppBar(
              child: Container(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('${selectedImages.length} images selected'),
                    ElevatedButton(
                      onPressed: () {
                        _showBottomSheet(context);
                      },
                      child: Text('Process Images'),
                    ),
                  ],
                ),
              ),
            )
          : null,
    );
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.rotate_left),
                title: Text('Rotate'),
                onTap: () {
                  // Rotate selected images logic here
                  for (var toProcess in selectedImages){
                    setState(() {
                      
                    });
                  }
                },
              ),
              ListTile(
                leading: Icon(Icons.crop),
                title: Text('Trim'),
                onTap: () {
                  // Rotate selected images logic here
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.brush),
                title: Text('Re-color'),
                onTap: () {
                  // Rotate selected images logic here
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.contrast),
                title: Text('Grayscale'),
                onTap: () {
                  // Rotate selected images logic here
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.filter),
                title: Text('Apply Filter'),
                onTap: () {
                  // Apply filter to selected images logic here
                  Navigator.pop(context);
                },
              ),
              // Add more processing options here
            ],
          ),
        );
      },
    );
  }
}
