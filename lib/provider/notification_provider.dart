import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationProvider {
  final FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initNotification() async {
    AndroidInitializationSettings initializationSettingsAndroid =
        new AndroidInitializationSettings('@mipmap/ic_launcher');

    var initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    await notificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse:
          (NotificationResponse notificationResponse) async {},
    );
  }

  Future showNitification(
      {int id = 0, String? title, String? body, String? payload}) async {
    return notificationsPlugin.show(
        id,
        title,
        body,
        NotificationDetails(
            android: AndroidNotificationDetails(
          id.toString(),
          title!,
          icon: "appIcon", //add app icon here
          importance: Importance.max,
        )));
  }
}
