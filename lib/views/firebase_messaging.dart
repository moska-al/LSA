import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseMessagingService {
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  Future<String?> getDeviceToken() async {
    return await _firebaseMessaging.getToken();
  }

  void configureFirebaseMessaging() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Received notification while app is in the foreground: ${message.notification?.body}');
      // Handle the incoming notification message while the app is in the foreground
    });

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    print('Received notification while app is in the background or terminated: ${message.notification?.body}');
    // Handle the incoming notification message while the app is in the background or terminated
  }
}
