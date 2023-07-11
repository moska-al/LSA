import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:permission_handler/permission_handler.dart';

class ContactsScreen extends StatefulWidget {
  @override
  _ContactsScreenState createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  double _sliderValue = 0;
  bool _isLoading = false;
  List<Contact> _contacts = [];
// String a='Phone number'
  @override
  void initState() {
    super.initState();
    _fetchContacts();
  }

  Future<void> _fetchContacts() async {
    setState(() {
      _isLoading = true;
    });

    // Request permission to access contacts
    PermissionStatus status = await Permission.contacts.request();

    if (status.isGranted) {
      // Fetch contacts
      Iterable<Contact> contacts = await ContactsService.getContacts();
      setState(() {
        _contacts = contacts.toList();
        _isLoading = false;
      });
    } else {
      // Permission denied
      setState(() {
        _isLoading = false;
      });
      print('Permission denied for accessing contacts.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: _isLoading,
      child: Scaffold(
        appBar: AppBar(
            title: Center(
          child: Text('Contacts'),
        )),
        body: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              SizedBox(height: 16),
              // Placeholder for displaying contacts
              Expanded(
                child: ListView.builder(
                  itemCount: _contacts.length,
                  itemBuilder: (context, index) {
                    Contact contact = _contacts[index];
                    return ListTile(
                      leading: CircleAvatar(
                        child: Text((index + 1).toString()),
                      ),
                      title: Text(contact.displayName ?? ''),
                      subtitle: Text(contact.phones!.first.value.toString()),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
