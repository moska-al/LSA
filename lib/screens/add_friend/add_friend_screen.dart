import 'package:flutter/material.dart';
import 'package:meeja/core/constants/colors.dart';
import 'package:meeja/core/enums/view_state.dart';

import 'package:meeja/screens/add_friend/add_friend_provider.dart';
import 'package:meeja/screens/connection/connection_provider.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import 'package:provider/provider.dart';

import '../widget/customFriends.dart';

class AddFriendScreen extends StatefulWidget {
  @override
  State<AddFriendScreen> createState() => _AddFriendScreenState();
}

class _AddFriendScreenState extends State<AddFriendScreen> {
  String searchQuery = '';
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AddFriend(),
      child: Consumer<AddFriend>(
        builder: (context, model, child) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              title: Text(
                "Add Friend",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              centerTitle: true,
            ),
            body: ModalProgressHUD(
              progressIndicator: CircularProgressIndicator(color: orangeColor),
              inAsyncCall: model.state == ViewState.busy,
              child: SingleChildScrollView(
                child: Column(
                  // mainAxisSize: MainAxisSize.max,
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  children: [
              
    SizedBox(height: 8),
    TextField(
  style: TextStyle(color: Colors.black, fontSize: 18),
  decoration: InputDecoration(
    filled: true,
    fillColor: Colors.white,
    hintText: 'Search',
    hintStyle: TextStyle(color: Colors.grey[400], fontSize: 18),
    prefixIcon: Icon(Icons.search, color: Colors.grey[400]),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
      borderSide: BorderSide.none,
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
      borderSide: BorderSide(color: Colors.blue),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
      borderSide: BorderSide(color: Colors.red),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
      borderSide: BorderSide(color: Colors.red),
    ),
  ),
  onChanged: (value) {
    setState(() {
      searchQuery = value;
    });
  },
),

    

                    SizedBox(
                      height: 8,
                    ),

                    ListView.builder(
  itemCount: model.appusers.where((appuser) =>
      appuser.fullName!.toLowerCase().contains(searchQuery.toLowerCase())
  ).length,
  shrinkWrap: true,
  padding: EdgeInsets.only(top: 16),
  physics: NeverScrollableScrollPhysics(),
  itemBuilder: (context, index) {
    final appuser = model.appusers.where((appuser) =>
      appuser.fullName!.toLowerCase().contains(searchQuery.toLowerCase())
    ).toList()[index];
    return CustomFriend(
      title: appuser.fullName,
      image1: appuser.profileImage == null ? 'assets/profile_icon.png' : appuser.profileImage,
      onpress: () async {
        model.addFriendModel.friendName = appuser.fullName;
        model.addFriendModel.friendId = appuser.appUserId;
        model.addFriendModel.friendImage = appuser.profileImage;

        await model.addfriend();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: Duration(seconds: 3),
            content: Text('${model.addFriendModel.friendName}   added as friend'),
          ),
        );
        Provider.of<ConnectionProvider>(context, listen: false).getFriends();
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => AddFriendScreen()));
      },
      isAdded: appuser.appUserId,
      model: model,
    );
  },
),
// SizedBox(height: 20),
                  ],
                ),
              ),
            ),

            // floatingActionButtonLocation:
            //     FloatingActionButtonLocation.miniCenterDocked,
          );
        },
      ),
    );
  }
}
