import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  Future addUser(Map<String, dynamic> userInfo, String id) async {
    await FirebaseFirestore.instance.collection("users").doc(id).set(userInfo);
  }

  Future addmessage(
    Map<String, dynamic> messageinfo,
    String? chatroomid,
    String? messageid,
  ) async {
    await FirebaseFirestore.instance
        .collection("chatrooms")
        .doc(chatroomid)
        .collection("chats")
        .doc(messageid)
        .set(messageinfo);
  }

  Future updatelastmessagesend(
    String chatroomid,
    Map<String, dynamic> lastmessageinfo,
  ) async {
    return FirebaseFirestore.instance
        .collection("chatrooms")
        .doc(chatroomid)
        .set(lastmessageinfo, SetOptions(merge: true));
  }

  Future<QuerySnapshot> searchuser(String username) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .where("SearchKey", isEqualTo: username.substring(0, 1).toUpperCase())
        .get();
  }
}
