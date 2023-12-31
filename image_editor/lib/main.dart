import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
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
      body:SingleChildScrollView(child: Wrap(
        alignment: WrapAlignment.spaceBetween,
          spacing: 10,
          runSpacing: 10,
        children: List.generate(allImages.length, (index){
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
        }),
      )) ,
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

                    Text('${selectedImages.length} images selected').animate().shake(),
                    ElevatedButton(
                      onPressed: () {
                        _showBottomSheet(context);
                      },
                      child: const Text('Process Images'),
                    ),
                  ],
                ),
              ),
            ).animate().fadeIn()
          : null,
    );
  }
   
   
void _showBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return SizedBox(
        height: 200,
        child: Column(
          children: [
            Container(
              height: 50,
              color: Colors.blue,
              child: const Center(
                child: Text(
                  '上部分可见内容',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            const Expanded(
              child: Center(
                child: Text(
                  '下部分内容',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}

  
}
