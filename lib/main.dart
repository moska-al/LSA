import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:meeja/core/constants/colors.dart';
import 'package:meeja/core/extensions/color.dart';
import 'package:meeja/screens/connection/connection_provider.dart';
import 'package:meeja/screens/groups/new_group_screen.dart';
import 'package:meeja/screens/splash_screen.dart';
import 'package:meeja/views/calender_screen.dart';
import 'package:meeja/views/firebase_messaging.dart';
import 'package:provider/provider.dart';
import 'core/locator.dart';
import 'firebase_options.dart';
import 'screens/groups/group_provider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
//Replaced with script based initialization using firebase_client
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseMessagingService firebaseMessagingService =
      FirebaseMessagingService();
  firebaseMessagingService.configureFirebaseMessaging();

  await setupLocator();

  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of app.
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<GroupProvider>(
          create: (context) => GroupProvider(),
        ),
        ChangeNotifierProvider<ConnectionProvider>(
          create: (context) => ConnectionProvider(),
        )
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'LSA',
        theme: ThemeData(
          primaryColor: orangeColor,
          primarySwatch: orangeColor.toMaterialColor(),
          textTheme: TextTheme(
            button: TextStyle(
              color: orangeColor,
            ),
          ),
          // But
        ),
        home: ScreenUtilInit(
          designSize: Size(width, height),
          builder: (_, child) => SplashScreen(),
        ),
      ),
    );
  }
}
