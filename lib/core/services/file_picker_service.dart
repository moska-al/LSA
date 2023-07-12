import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:heic_to_jpg/heic_to_jpg.dart'; // iOS images are mostly in heic format
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart' as path_prvoider;
import './file_services.dart';

class FilePickerService {
  File? selectedImage;
  final _imagePicker = ImagePicker();
  final Logger logger = Logger();
  final fileServices = FileServices();

  Future<File?> pickImage() async {
    return await pickImageWithoutCompression();
  }

  Future<File?> pickImageWithCompression() async {
    File? selectedImage;
    final image50 = await _imagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 40);
    final image100 = await _imagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 100);
    if (image50 != null) selectedImage = File(image50.path);

    logger.d('Image50 Size: ${await image50?.length()}');
    logger.d('Image100 Size: ${await image100?.length()}');

    return selectedImage;
  }

  Future<File?> pickImageWithoutCompression() async {
    File? selectedImage;
    final _filePicker = FilePicker.platform;
    FilePickerResult? result = await _filePicker.pickFiles(
      type: FileType.image,
      allowMultiple: false,
    );

    if (result != null) {
      selectedImage = File(result.paths.first!);
      final extension = p.extension(selectedImage.path);
      debugPrint('@FilePcikerService.pickImage ==> Extension: $extension');
      if (extension == '.heic') {
        String? jpegPath = await HeicToJpg.convert(selectedImage.path);
        if (jpegPath != null) selectedImage = File(jpegPath);
      }
    }
    return selectedImage;
  }
}
