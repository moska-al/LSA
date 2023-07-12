import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class DatabaseStorageServices {
  FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String?> uploadUserProfileImage(File image, String uuid) async {
    // final imagePath = image.path;
    try {
      var reference = _storage.ref().child("UserProfilesImages/$uuid");
      var uploadImage = reference.putFile(image);
      TaskSnapshot snapshot =
          await uploadImage.whenComplete(() => print('Image Uploaded'));
      final imageUrl = snapshot.ref.getDownloadURL();
      return imageUrl;
    } catch (e) {
      print("Exception@uploadUserImage=> $e");
      return null;
    }
  }

  Future<String?> uploadUserImage(File image, String uuid) async {
    // final imagePath = image.path;
    try {
      var reference = _storage.ref().child("Chatimages/$uuid");
      var uploadImage = reference.putFile(image);
      TaskSnapshot snapshot =
          await uploadImage.whenComplete(() => print('Image Uploaded'));
      final imageUrl = snapshot.ref.getDownloadURL();
      return imageUrl;
    } catch (e) {
      print("Exception@uploadUserImage=> $e");
      return null;
    }
  }

  Future<String?> uploadMessagesImg(File image, String uuid) async {
    // final imagePath = image.path;
    try {
      var reference = _storage.ref().child("MessageImg/${image.path}");
      var uploadImage = reference.putFile(image);
      TaskSnapshot snapshot =
          await uploadImage.whenComplete(() => print('Image Uploaded'));
      final imageUrl = snapshot.ref.getDownloadURL();
      return imageUrl;
    } catch (e) {
      print("Exception@uploadUserImage=> $e");
      return null;
    }
  }

  Future<String?> uploadNotesImages(File image, String? xFile) async {
    // final imagePath = image.path;
    try {
      var reference = _storage.ref().child("notesImages/$xFile");
      var uploadImage = reference.putFile(image);
      TaskSnapshot snapshot =
          await uploadImage.whenComplete(() => print('Image Uploaded'));
      final imageUrl = snapshot.ref.getDownloadURL();
      return imageUrl;
    } catch (e) {
      print("Exception@uploadUserImage=> $e");
      return null;
    }
  }

  Future<String?> uploadVoiceNote({
    required File voiceNote,
    required String userId,
    required String problemId,
  }) async {
    try {
      var fileName = (voiceNote.path.split('/').last);
      print("$fileName");

      var reference = _storage
          .ref()
          .child("posts/$userId/ProblemData/$problemId/$fileName");

      var uploadVoiceNote = reference.putFile(voiceNote);
      TaskSnapshot snapshot = await uploadVoiceNote.whenComplete(
        () => print('Voice Note Uploaded'),
      );
      final voiceNoteUrl = snapshot.ref.getDownloadURL();
      return voiceNoteUrl;
    } catch (e) {
      print("Exception@uploadingVoiceNote ==> $e");
      return null;
    }
  }
}
