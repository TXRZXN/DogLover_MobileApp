import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class SendNotification{
  Future<void> actionpost(usernamewho,tokenfirst,postid,time,action,tokenlast,usernamepost) async {
    String serverKey ="AAAAMMPI-U8:APA91bHro8TwRymX6FZgWMg27NHx7Ru8syTThSw-6PfFKqXjVmZHrl7687CupCdwsuaySRmWonb9sqfHQPHFOpr6sefZBJ66l5c7NMuvN_HVg5c2kgh77wjl6RVWT8AfxwrFcQ3q_Kiw";
    try {
      await http
      .post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'key=$serverKey',
        },
        body: jsonEncode(
          <String, dynamic>{
            'notification': <String, dynamic>{
              'body':  'มีการ $action บนโพสของคุณ',
              'title': "มีการแจ้งเตือนใหม่",
            },
            'priority': 'high',
            'data': <String, dynamic>{
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
              'useridwho':usernamewho,
              'tokenfirst':tokenfirst,
              'postid':postid,
              'time':time,
              'action':action,
              'tokenlast':tokenlast,
              'useridpost':usernamepost,
            },
         
            'to': '/topics/comment$usernamepost',
          },
        ),
      )
      .then(
        (value) => print("success" + tokenlast.toString()),
      );
    } catch (e) {
      print("failed");
      print(e);
    }
  }

  Future<void> likepost(usernamewho,tokenfirst,postid,time,action,tokenlast,usernamepost) async {
    String serverKey ="AAAAMMPI-U8:APA91bHro8TwRymX6FZgWMg27NHx7Ru8syTThSw-6PfFKqXjVmZHrl7687CupCdwsuaySRmWonb9sqfHQPHFOpr6sefZBJ66l5c7NMuvN_HVg5c2kgh77wjl6RVWT8AfxwrFcQ3q_Kiw";
    try {
      await http
      .post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'key=$serverKey',
        },
        body: jsonEncode(
          <String, dynamic>{
            'notification': <String, dynamic>{
              'body':  'มีการ $action บนโพสของคุณ',
              'title': "มีการแจ้งเตือนใหม่",
            },
            'priority': 'high',
            'data': <String, dynamic>{
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
              'useridwho':usernamewho,
              'tokenfirst':tokenfirst,
              'postid':postid,
              'time':time,
              'action':action,
              'tokenlast':tokenlast,
              'useridpost':usernamepost,
              
            },
            
            'to': '/topics/like$usernamepost',
          },
        ),
      )
      .then(
        (value) => print("success" + tokenlast.toString()),
      );
    } catch (e) {
      print("failed");
      print(e);
    }
  }


}