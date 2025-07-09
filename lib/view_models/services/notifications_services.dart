// import 'dart:io';
// import 'dart:math';
//
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:app_settings/app_settings.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
//
// class NotificationServices {
//   FirebaseMessaging messaging = FirebaseMessaging.instance;
//   final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();
//
//   void requestNotificationPermission() async {
//     NotificationSettings settings = await messaging.requestPermission(
//       alert: true,
//       announcement: true,
//       badge: true,
//       carPlay: true,
//       criticalAlert: true,
//       provisional: true,
//       sound: true,
//     );
//
//     if (settings.authorizationStatus == AuthorizationStatus.authorized) {
//       debugPrint("user granted permission");
//     } else if (settings.authorizationStatus ==
//         AuthorizationStatus.provisional) {
//       debugPrint("user granted provisional permission");
//     } else {
//       AppSettings.openAppSettings(type: AppSettingsType.notification);
//       debugPrint("user denied permission");
//     }
//   }
//
//   void initLocalNotifications(RemoteMessage message) async {
//     const androidInitializationSettings =
//         AndroidInitializationSettings('@mipmap/launcher_icon');
//
//     const iosInitializationSettings = DarwinInitializationSettings();
//
//     const InitializationSettings initializationSettings =
//         InitializationSettings(
//             android: androidInitializationSettings,
//             iOS: iosInitializationSettings);
//
//     await _flutterLocalNotificationsPlugin.initialize(initializationSettings,
//         onDidReceiveNotificationResponse: (payload) {
//       redirectMessage(message);
//     });
//   }
//
//   void firebaseInit() {
//     FirebaseMessaging.onMessage.listen((message) {
//
//       if(Platform.isIOS){
//         foregroundMsg();
//       }
//       if (Platform.isAndroid) {
//         initLocalNotifications(message);
//         showNotification(message);
//       }else{
//         showNotification(message);
//       }
//     });
//   }
//
//   Future<void> showNotification(RemoteMessage message) async {
//     AndroidNotificationChannel channel = AndroidNotificationChannel(
//       Random.secure().nextInt(100000).toString(),
//       'High importance Notification',
//       // 'channel name',
//       importance: Importance.max,
//     );
//
//     AndroidNotificationDetails androidNotificationDetails =
//         AndroidNotificationDetails(
//       channel.id.toString(),
//       channel.name.toString(),
//       importance: Importance.high,
//       priority: Priority.high,
//       playSound: true,
//       ticker: 'ticker',
//     );
//
//     const DarwinNotificationDetails darwinNotificationDetails =
//         DarwinNotificationDetails(
//       presentAlert: true,
//       presentBadge: true,
//       presentSound: true,
//     );
//
//     var notificationDetails = NotificationDetails(
//       android: androidNotificationDetails,
//       iOS: darwinNotificationDetails,
//     );
//
//     Future.delayed(Duration.zero, () {
//       _flutterLocalNotificationsPlugin.show(
//         0,
//         message.notification!.title.toString(),
//         message.notification!.body.toString(),
//         notificationDetails,
//         payload: 'custom notification payload',
//       );
//     });
//   }
//
//   Future<String> getDeviceToken() async {
//     String? token = await messaging.getToken();
//     return token!;
//   }
//
//   void isTokenRefresh() {
//     messaging.onTokenRefresh.listen((event) {
//       event.toString();
//       debugPrint('refresh');
//     });
//   }
//
//   Future<void> setupInteractMessage()async{
//     // when app is terminated/kill
//     RemoteMessage? initialMsg = await FirebaseMessaging.instance.getInitialMessage();
//
//     if(initialMsg != null){
//       redirectMessage(initialMsg);
//     }
//     // when app is in background
//     FirebaseMessaging.onMessageOpenedApp.listen((message) {
//       redirectMessage(message);
//     });
//   }
//
//   void redirectMessage(RemoteMessage message) {
//     if(message.data['type'] == 'check-in'){
//       // Get.to(()=> const GetCoinsPage());
//     }
//   }
//
//   Future foregroundMsg() async{
//     await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
//       alert: true,
//       badge: true,
//       sound: true,
//     );
//   }
//
// }
