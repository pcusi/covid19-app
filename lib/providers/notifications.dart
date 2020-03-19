import 'dart:async';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationsProvider {
  FirebaseMessaging _fcm = FirebaseMessaging();

  final _notificationsController = StreamController<String>.broadcast();
  final Firestore _db = Firestore.instance;

  initNotifications() {
    _fcm.requestNotificationPermissions();

    _fcm.configure(
      onMessage: (info) {
        print(info);

        String title = 'wut';

        if (Platform.isAndroid) {
          title = info['data']['title'] ?? 'wut';
        }

        _notificationsController.sink.add(title);
      },
      onLaunch: (info) {
        
        String title = 'wut';

        if (Platform.isAndroid) {
          title = info['data']['title'] ?? 'wut';
        }

        _notificationsController.sink.add(title);
      },
      onResume: (info) {
        
        String title = 'wut';

        if (Platform.isAndroid) {
          title = info['data']['title'] ?? 'wut';
        }

        _notificationsController.sink.add(title);
      },
    );
  }

  saveDeviceToken() async {
    String uid = 'pcusir';

    String fcmToken = await _fcm.getToken();

    if (fcmToken != null) {
      var tokens = _db
          .collection('users')
          .document(uid)
          .collection('tokens')
          .document(fcmToken);

      final savedTokens = await tokens.setData({'token': fcmToken});

      return savedTokens;
    }
  }

  dispose() {
    _notificationsController.close();
  }
}
