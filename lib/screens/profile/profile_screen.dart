import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/route_manager.dart';
import 'package:meeja/core/constants/colors.dart';
import 'package:meeja/screens/splash_screen.dart';
import 'package:meeja/views/add_feed.dart';
import 'package:meeja/views/update_profile.dart';
import 'package:provider/provider.dart';

import '../widget/customExpansionTile.dart';
import '../widget/custom_button.dart';
import 'profile_provider.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => ProfileProvider(),
        child: Consumer<ProfileProvider>(builder: (context, model, child) {
          print(model.appUser.role);
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Color.fromARGB(255, 199, 31, 221),
              title: Center(
                  child: Text(
                "             Profile       ",
                style: TextStyle(fontSize: 20, color: Colors.white),
              )),
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.notifications_active_outlined,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 20, left: 20, right: 20, bottom: 10),
                    child: CircleAvatar(
                      backgroundColor: Color(0xffE7DEDC),
                      backgroundImage: model.appUser.profileImage != null
                          ? NetworkImage("${model.appUser.profileImage}")
                          : AssetImage('assets/profile_icon.png')
                              as ImageProvider,
                      radius: 50,
                    ),
                  ),
                  Text(
                    model.appUser.userName == null
                        ? 'User Name'
                        : model.appUser.userName.toString(),
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomExpansionTile(
                    margin: EdgeInsets.symmetric(horizontal: 18),
                    title: Text(
                      "Profile Settings",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    leadingSvgPath: "assets/Setting.svg",
                    children: [
                      ListTile(
                        title: Text("Update profile picture"),
                        leading: Icon(Icons.photo),
                        onTap: () {
                          Get.to(UpdateProfileScreen());
                          // Add your code to handle the "Update Friend" action here
                          // For example, you can navigate to a new screen or perform any other action
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  model.appUser.role == 'Admin'
                      ? CustomButton(
                          title: "Add Feed",
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AdFeedScreen()));
                          })
                      : SizedBox(),
                  SizedBox(height: 20),
                  CustomButton(
                      title: "Logout",
                      onTap: () async {
                        await model.locateUser.logoutUser();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SplashScreen()));
                      }),
                ],
              ),
            ),
          );
        }));
  }
}
