import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import 'package:meeja/core/models/add_friend_model.dart';
import 'package:meeja/core/models/friend_message_model.dart';
import 'package:meeja/core/models/groups_model.dart';

import '../locator.dart';
import '../models/app_user.dart';
import '../models/group_conversation_model.dart';
import 'auth_services.dart';

class DatabaseServices {
  final firebaseFireStore = FirebaseFirestore.instance;
  final user = FirebaseAuth.instance.currentUser?.uid;



  registerUser(AppUser appUser) {
    try {
      firebaseFireStore
          .collection("AppUser")
          .doc(appUser.appUserId)
          .set(appUser.toJson());
    } catch (e) {
      print('Exception $e');
    }
  }

  Future<AppUser> getUser(id) async {
    print('GetUser id: $id');
    try {
      final snapshot =
          await firebaseFireStore.collection('AppUser').doc(id).get();

      return AppUser.fromJson(snapshot.data(), snapshot.id);
    } catch (e) {
      print('Exception @DatabaseService/getUser $e');
      return AppUser();
    }
  }

  Future<List<AppUser>> getAppUsers() async {
    final List<AppUser> appUserList = [];
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('AppUser')
          .where('appUserId',
              isNotEqualTo: locator<AuthServices>().appUser.appUserId)
          .get();
      if (snapshot.docs.length > 0) {
        snapshot.docs.forEach((element) {
          appUserList.add(AppUser.fromJson(element, element.id));
          print("getUser => ${element['userName']}");
        });
      } else {
        print("No data found");
      }
    } catch (e) {
      print('Exception @DatabaseService/GetAllUsers $e');
    }
    return appUserList;
  }

  Future<List<AppUser>> getTopThreeUsers() async {
    final List<AppUser> appUserList = [];
    try {
      QuerySnapshot snapshot =
          await firebaseFireStore.collection('AppUser').get();
      if (snapshot.docs.length > 0) {
        snapshot.docs.forEach((element) {
          appUserList.add(AppUser.fromJson(element, element.id));
          print("getUser => ${element['userName']}");
        });
      } else {
        print("No data found");
      }
    } catch (e) {
      print('Exception @DatabaseService/GetAllUsers $e');
    }
    return appUserList;
  }

  updateUserProfile(AppUser appUser) async {
    try {
      await firebaseFireStore
          .collection('AppUser')
          .doc(appUser.appUserId)
          .update(appUser.toJson());
    } catch (e) {
      print('Exception@UpdateUserProfile=>$e');
    }
  }

  updateotherUserProfile(double zaps, String userId) async {
    try {
      await firebaseFireStore
          .collection('AppUser')
          .doc(userId.toString())
          .update({
        'faceCardNumber': zaps,
      });
    } catch (e) {
      print('Exception@UpdateUserProfile=>$e');
    }
  }

  Future<List<AppUser>> getAllAppUser() async {
    final List<AppUser> appUserList = [];
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('AppUser')
          .where('appUserId',
              isNotEqualTo: locator<AuthServices>().appUser.appUserId)
          .get();
      if (snapshot.docs.length > 0) {
        snapshot.docs.forEach((element) {
          appUserList.add(AppUser.fromJson(element, element.id));
          print("getUser => ${element['userName']}");
        });
      } else {
        print("No data found");
      }
    } catch (e) {
      print('Exception @DatabaseService/GetAllUsers $e');
    }
    return appUserList;
  }

  createGroup(
    GroupModel groupModel,
  ) {
    try {
      firebaseFireStore.collection("Group").doc().set(groupModel.toJson());

      return true;
    } catch (e) {}
  }

  Stream<QuerySnapshot>? getCreateGroup() {
    try {
      Stream<QuerySnapshot> snapshot =
          firebaseFireStore.collectionGroup("Group").snapshots();
      print("Successfully Fetched");
      return snapshot;
    } catch (e) {}
  }

  updateGroup(GroupModel groupModel) async {
    try {
      await firebaseFireStore
          .collection("Group")
          .doc(groupModel.groupId)
          .update(groupModel.toJson());
    } catch (e) {
      print('Exception@UpdateGroups=>$e');
    }
  }

  sendGroupMessage(GroupConversationModel groupConversationModel, var groupId) {
    try {
      firebaseFireStore
          .collection("Group")
          .doc(groupId)
          .collection("GroupMessages")
          .doc()
          .set(groupConversationModel.toJson());

      return true;
    } catch (e) {}
  }

  sendMessage(FriendMessageModel friendMessageModel, var friendId) {
    try {
      firebaseFireStore
          .collection("Conversation")
          .doc(locator<AuthServices>().appUser.appUserId)
          .collection("Chats")
          .doc(friendId)
          .collection("Messages")
          .add(friendMessageModel.toJson());

      firebaseFireStore
          .collection("Conversation")
          .doc(friendId)
          .collection("Chats")
          .doc(locator<AuthServices>().appUser.appUserId)
          .collection("Messages")
          .add(friendMessageModel.toJson());
      return true;
    } catch (e) {}
  }

  addFriends(AddFriendModel addFriendModel, AddFriendModel currentUser) async {
    try {
      await firebaseFireStore
          .collection("Friends")
          .doc(addFriendModel.addById)
          .collection("friendList")
          .doc(addFriendModel.friendId)
          .set(addFriendModel.toJson());

      await firebaseFireStore
          .collection("Friends")
          .doc(currentUser.addById)
          .collection("friendList")
          .doc(currentUser.friendId)
          .set(currentUser.toJson());
    } catch (e) {}
  }

  Future<List<AddFriendModel>> getFriends() async {
    final List<AddFriendModel> addFriendList = [];
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('Friends')
          .doc(locator<AuthServices>().appUser.appUserId)
          .collection('friendList')
          .get();
      if (snapshot.docs.length > 0) {
        snapshot.docs.forEach((element) {
          addFriendList.add(AddFriendModel.fromjson(element, element.id));
          print("GetAllFriends => ${element['friendName']}");
        });
      } else {
        print("No data found");
      }
    } catch (e) {
      print('Exception @DatabaseService/GetAllFriends $e');
    }
    return addFriendList;
  }

  Stream<QuerySnapshot>? getSelectedUserr() {
    try {
      Stream<QuerySnapshot> snapshot =
          firebaseFireStore.collection('Groups').snapshots();

      print("members fetch");
      return snapshot;
    } catch (e) {
      print("Error@memberList error ===> $e");

      return null;
    }
  }

    }
