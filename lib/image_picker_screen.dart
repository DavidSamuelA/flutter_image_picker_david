import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerScreen extends StatefulWidget {
  const ImagePickerScreen({Key? key}) : super(key: key);

  @override
  State<ImagePickerScreen> createState() => _ImagePickerScreenState();
}

class _ImagePickerScreenState extends State<ImagePickerScreen> {
  File? image;
  late String imagePath;

  Future pickGalleryImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (image == null) return;

      final imageTemp = File(image.path);

      print('Gallery Image Path');
      print(image.path);

      imagePath = image.path;

      setState(() {
        this.image = imageTemp;
      });
    } on PlatformException catch (e) {
      print('-----> failed to pick image: $e');
    }
  }

  Future pickCameraImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);

      if (image == null) return;

      final imageTemp = File(image.path);

      print('Camera Image Path');
      print(image.path);

      imagePath = image.path;

      setState(() {
        this.image = imageTemp;
      });
    } on PlatformException catch (e) {
      print('-----> failed to pick image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Picker'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            image != null
                ? Padding(
                    padding: const EdgeInsets.only(bottom: 130.0),
                    child: ClipOval(
                      child: Image.file(image!,
                          width: 200, height: 200, fit: BoxFit.cover),
                    ),
                  )
                : FlutterLogo(
              size: 50,
            ),
            SizedBox(
              height: 30,
            ),
            ElevatedButton(
              onPressed: () {
                _uploadImageDialog(context);
              },
              child: Text('+ Add Photo',
              style: TextStyle(
                fontSize: 20.0,
              ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _uploadImageDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (param) {
          return AlertDialog(
            content: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  ElevatedButton(
                      onPressed: () {
                        print('----------> Upload Image from Gallery');
                        Navigator.pop(context);
                        pickGalleryImage();
                      },
                      child: Text('Gallery', style: TextStyle(
                        fontSize: 18,
                      ),)),
                  ElevatedButton(
                      onPressed: () {
                        print('---------> Upload Image from Camera');
                        Navigator.pop(context);
                        pickCameraImage();
                      },
                      child: Text('Camera', style: TextStyle(
                        fontSize: 18,
                      ),),
                  ),
                ],
              ),
            ),
            title: Text('Upload Image'),
          );
        });
  }
}
