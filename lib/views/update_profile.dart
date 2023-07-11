import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meeja/screens/profile/profile_provider.dart';
import 'package:provider/provider.dart';
class UpdateProfileScreen extends StatelessWidget {
  final ProfileProvider profileProvider = Get.put(ProfileProvider());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Profile'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Your form fields and widgets here
      
            ElevatedButton(
              onPressed: () {
                profileProvider.pickImageFromGallery();
              },
              child: Text('Pick Image'),
            ),
      
            ElevatedButton(
              onPressed: () {
                profileProvider.updateProfile();
              },
              child: Text('Update Profile'),
            ),
          ],
        ),
      ),
    );
  }
}
