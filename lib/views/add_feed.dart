import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class AdFeedScreen extends StatefulWidget {
  @override
  _AdFeedScreenState createState() => _AdFeedScreenState();
}

class _AdFeedScreenState extends State<AdFeedScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  File? _selectedImage;
  bool _isLoading = false;

  Future<void> _selectImage() async {
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedImage != null) {
        _selectedImage = File(pickedImage.path);
      } else {
        print('No image selected');
      }
    });
  }

  void _addAdToDatabase(String title, String description) async {
    setState(() {
      _isLoading = true;
    });

    // Upload image to Firebase Storage
    String imageUrl = '';
    if (_selectedImage != null) {
      try {
        final firebase_storage.Reference ref = firebase_storage
            .FirebaseStorage.instance
            .ref()
            .child('ad_images')
            .child(DateTime.now().toString() + '.jpg');

        await ref.putFile(_selectedImage!);

        imageUrl = await ref.getDownloadURL();
      } catch (error) {
        print(error);
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to upload image'),
          ),
        );
        return;
      }
    }

    // Add ad details to Firestore
    FirebaseFirestore.instance.collection('ads').add({
      'title': title,
      'description': description,
      'imageUrl': imageUrl, // Add the image URL to the database
    }).then((_) {
      setState(() {
        _isLoading = false;
        _titleController.clear();
        _descriptionController.clear();
        _selectedImage = null;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Ad added successfully'),
        ),
      );
    }).catchError((error) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to add ad'),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ad Feed'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'Title',
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter a title';
                }
                return null;
              },
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: _descriptionController,
              decoration: InputDecoration(
                labelText: 'Description',
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter a description';
                }
                return null;
              },
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _selectImage,
              child: Text('Select Image'),
            ),
            SizedBox(height: 16.0),
            _selectedImage != null
                ? Image.file(
                    _selectedImage!,
                    height: 100,
                  )
                : SizedBox(),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                if (_titleController.text.isNotEmpty &&
                    _descriptionController.text.isNotEmpty &&
                    _selectedImage != null) {
                  String title = _titleController.text;
                  String description = _descriptionController.text;
                  _addAdToDatabase(title, description);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Please fill in all fields'),
                    ),
                  );
                }
              },
              child: _isLoading
                  ? Center(
                      child: CircularProgressIndicator(
                      color: Colors.white,
                    ))
                  : Text('Add Ad'),
            ),
          ],
        ),
      ),
    );
  }
}
