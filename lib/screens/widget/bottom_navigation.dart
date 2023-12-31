import 'package:flutter/material.dart';
import 'package:meeja/core/constants/colors.dart';
import 'package:meeja/views/calender_screen.dart';
import 'package:meeja/views/contact.dart';
import 'package:meeja/views/feed_screen.dart';
import 'package:meeja/views/complaints.dart';
import '../groups/allchat_screen.dart';
import '../connection/connection_screen.dart';
import '../profile/profile_screen.dart';

class BottomNavigation extends StatefulWidget {
  int? indexValue;
  BottomNavigation({required this.indexValue});
  @override
  _BottomNavigationState createState() => _BottomNavigationState(indexValue!);
}

class _BottomNavigationState extends State<BottomNavigation> {
  int indexValue;

  _BottomNavigationState(this.indexValue);
  final pages = [
    CalendarScreen(),
    AllChatScreen(),
    ConnectionScreen(),
    ComplaintsScreen(),
    ProfileScreen(),
    ContactsScreen(),
    FeedScreen()
  ];

  Future<bool> showExitPopup() async {
    return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Exit App'),
            content: Text('Do you want to exit the App?'),
            actions: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: orangeColor,
                  // Background color
                ),
                onPressed: () => Navigator.of(context).pop(false),
                child: Text('No'),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: orangeColor,
                  // Background color
                ),
                onPressed: () => Navigator.of(context).pop(true),
                child: Text('Yes'),
              ),
            ],
          ),
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: showExitPopup,
      child: Scaffold(
        body: pages[indexValue],
        bottomNavigationBar: Container(
          height: 80,
          decoration: BoxDecoration(
            color: Color(0xffFEF6F5),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              BottomNavigationItems(
                getColor: indexValue == 0
                    ? Colors.grey
                    : Color.fromARGB(255, 248, 6, 6),
                icon: Icons.home,
                onPressed: () {
                  setState(() {
                    indexValue = 0;
                  });
                },
              ),
              BottomNavigationItems(
                getColor: indexValue == 4
                    ? Colors.grey
                    : Color.fromARGB(255, 245, 120, 36),
                icon: Icons.person,
                onPressed: () {
                  setState(() {
                    indexValue = 4;
                  });
                },
              ),
              BottomNavigationItems(
                getColor: indexValue == 6
                    ? Colors.grey
                    : Color.fromARGB(255, 243, 247, 24),
                icon: Icons.feed,
                onPressed: () {
                  setState(() {
                    indexValue = 6;
                  });
                },
              ),
              BottomNavigationItems(
                getColor: indexValue == 1
                    ? Colors.grey
                    : Color.fromARGB(255, 25, 148, 14),
                icon: Icons.chat,
                onPressed: () {
                  setState(() {
                    indexValue = 1;
                  });
                },
              ),
              BottomNavigationItems(
                getColor: indexValue == 2
                    ? Colors.grey
                    : Color.fromARGB(255, 19, 233, 248),
                icon: Icons.link,
                onPressed: () {
                  setState(() {
                    indexValue = 2;
                  });
                },
              ),
              BottomNavigationItems(
                getColor: indexValue == 5
                    ? Colors.grey
                    : Color.fromARGB(255, 13, 9, 252),
                icon: Icons.contacts,
                onPressed: () {
                  setState(() {
                    indexValue = 5;
                  });
                },
              ),
              BottomNavigationItems(
                getColor: indexValue == 3
                    ? Colors.grey
                    : Color.fromARGB(255, 194, 6, 252),
                icon: Icons.help,
                onPressed: () {
                  setState(() {
                    indexValue = 3;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BottomNavigationItems extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final Color getColor;

  BottomNavigationItems({
    required this.icon,
    required this.onPressed,
    required this.getColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: getColor,
            size: 24,
          ),
        ],
      ),
    );
  }
}
