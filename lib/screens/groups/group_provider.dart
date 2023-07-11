import 'dart:io';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meeja/core/models/group_conversation_model.dart';
import 'package:meeja/core/models/groups_model.dart';
import 'package:meeja/core/services/database_storage_services.dart';
import 'package:meeja/screens/widget/bottom_navigation.dart';
import '../../core/enums/view_state.dart';
import '../../core/locator.dart';
import '../../core/models/app_user.dart';
import '../../core/models/base_view_model.dart';
import '../../core/services/auth_services.dart';
import '../../core/services/database_services.dart';

class GroupProvider extends BaseViewModal {
  DatabaseServices _databaseServices = DatabaseServices();
  DatabaseStorageServices _databaseStorageServices = DatabaseStorageServices();
  List<AppUser> allAppUsers = [];
  List<AppUser> selectedUsers = [];
  List<AppUser> addMembers = [];
  List getGroupMemberList = [];
  List<AppUser> newSelectedUsers = [];

  final formKey = GlobalKey<FormState>();
  List<GroupModel> getGroupList = [];
  List<GroupModel> getSelectedList = [];

  XFile? image;
  File? userImage;
  List<bool> checkBoxes = [];
  List<AppUser> searchedUsers = [];

  List<GroupModel> searchedgroup = [];
  final ImagePicker imagePicker = ImagePicker();
  final messageController = TextEditingController();
  GroupModel groupModel = GroupModel();
  GroupConversationModel groupConversationModel = GroupConversationModel();

  bool isSearching = false;
  bool searching = false;
  bool isValue = false;

  Stream<QuerySnapshot>? stream;

  int selectedGroup = 0;

  final locateUser = locator<AuthServices>();

  GroupProvider() {
    getAppUsers();
    getGroups();
  }

  createGroup(
    BuildContext context,
  ) async {
    setState(ViewState.busy);

    List<String?> membersListUserIds = selectedUsers.map(
      (
        AppUser user,
      ) {
        return user.appUserId;
      },
    ).toList();

    membersListUserIds.add(locateUser.appUser.appUserId);

    print(membersListUserIds);

    List<String> memberListNames = selectedUsers.map((AppUser user) {
      return user.userName!;
    }).toList();
    memberListNames.add(locateUser.appUser.userName!);
    print(memberListNames);

    GroupModel x = GroupModel(
      groupAdmin: locateUser.appUser.appUserId,
      members: membersListUserIds,
      groupName: groupModel.groupName,
      memberName: memberListNames,
    );

    final result = await _databaseServices.createGroup(x);

    if (result != true) {
      print("enter group name");
    } else {
      print('INSIDE ELSE BLOCK');

      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => BottomNavigation(
            indexValue: 2,
          ),
        ),
        (Route<dynamic> route) => false,
      );

      clearResources();
      intializingCheckBoxes();
    }

    setState(ViewState.idle);
  }

  intializingCheckBoxes() {
    checkBoxes = [];
    for (int i = 0; i < allAppUsers.length; i++) {
      checkBoxes.add(false);
    }
    notifyListeners();
  }

  getGroups() async {
    setState(ViewState.busy);
    stream = await _databaseServices.getCreateGroup();

    await stream!.listen((event) {
      if (event.docs.length > 0) {
        getGroupList = [];
        event.docs.forEach((element) {
          getGroupMemberList = element['members'];

          print(getGroupMemberList.toString() + "================>");

          if (getGroupMemberList.contains(locateUser.appUser.appUserId)) {
            getGroupList.add(GroupModel.formJson(element, element.id));

            for (int i = 0; i < getGroupList.length; i++) {
              print('element[i]:\n${getGroupList[i].members}');
            }
          } else {
            print("this is is not added to any group");
          }

          notifyListeners();
        });
      }
    });
    setState(ViewState.idle);
  }

  updateGroups() async {
    setState(ViewState.busy);

    print("${getGroupList[selectedGroup].groupId}");
    print("${getGroupList[selectedGroup].groupName}");

    await _databaseServices.updateGroup(getGroupList[selectedGroup]);
    clearResources();
    intializingCheckBoxes();

    setState(ViewState.idle);
  }

  getAppUsers() async {
    setState(ViewState.busy);
    allAppUsers = await _databaseServices.getAllAppUser();
    intializingCheckBoxes();

    print("$allAppUsers");
    setState(ViewState.idle);
  }

  sendMessages(
    var groupId,
  ) async {
    if (formKey.currentState!.validate()) {
      var now = new DateTime.now();
      String formattedTime = DateFormat('h:mm a').format(now);
      setState(ViewState.busy);

      groupConversationModel.sender = locateUser.appUser.appUserId.toString();
      groupConversationModel.senderName =
          locateUser.appUser.userName.toString();
      groupConversationModel.sentAt = formattedTime;

      await _databaseServices.sendGroupMessage(groupConversationModel, groupId);
      messageController.clear();

      notifyListeners();

      print("Send messages");
      setState(ViewState.idle);
    } else {
      print("Send cannot be messages");
    }
  }

  changingCheckBox(int index, var getValue) {
    if (getValue == true) {
      checkBoxes[index] = getValue;
      selectedUsers.add(allAppUsers[index]);
    } else {
      checkBoxes[index] = getValue;
      selectedUsers.remove(allAppUsers[index]);
    }

    notifyListeners();
  }

  addingMember(int index, getValue) {
    if (getValue == true) {
      checkBoxes[index] = getValue;
      addMembers.add(allAppUsers[index]);
    } else {
      checkBoxes[index] = getValue;
      addMembers.remove(allAppUsers[index]);
    }

    notifyListeners();
  }

  pickImageFromGallery(groupId) async {
    image = await imagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      userImage = File(image!.path);

      groupConversationModel.imageUrl = await _databaseStorageServices
          .uploadMessagesImg(userImage!, locateUser.appUser.appUserId!);
      sendMessages(groupId);
      notifyListeners();
    }
  }

  searchUserByName(String keyword) {
    print("Searched keyword : $keyword");
    keyword.isEmpty ? isSearching = false : isSearching = true;
    searchedUsers = allAppUsers
        .where(
            (e) => (e.fullName!.toLowerCase().contains(keyword.toLowerCase())))
        .toList();

    searchedUsers = allAppUsers
        .where(
            (e) => (e.fullName!.toLowerCase().contains(keyword.toLowerCase())))
        .toList();

    notifyListeners();
  }

  searchGroypByName(String keyword) {
    print("Searched keyword : $keyword");
    keyword.isEmpty ? searching = false : searching = true;
    searchedgroup = getGroupList
        .where(
            (e) => (e.groupName!.toLowerCase().contains(keyword.toLowerCase())))
        .toList();

    searchedgroup = getGroupList
        .where(
            (e) => (e.groupName!.toLowerCase().contains(keyword.toLowerCase())))
        .toList();

    notifyListeners();
  }

  bool get isChecked => isValue;
  set isChecked(bool Value) {
    isValue = Value;
    notifyListeners();
  }

  clearResources() {
    selectedUsers.clear();
    messageController.clear;
    notifyListeners();
  }
}
