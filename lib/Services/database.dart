import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pingmeet/Services/shared_pref.dart';

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

  createchatroomid(String chatroomid, Map<String, dynamic> chatroominfo) async {
    final snapshot = await FirebaseFirestore.instance
        .collection("chatrooms")
        .doc(chatroomid)
        .get();
    if (snapshot.exists) {
      return true;
    } else {
      return FirebaseFirestore.instance
          .collection("chatrooms")
          .doc(chatroomid)
          .set(chatroominfo);
    }
  }

  Future<Stream<QuerySnapshot>> getchatmessage(chatroomid) async {
    return await FirebaseFirestore.instance
        .collection("chatrooms")
        .doc(chatroomid)
        .collection("chats")
        .orderBy("time", descending: true)
        .snapshots();
  }

  Future<QuerySnapshot> getuserinformation(String username) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .where("Username", isEqualTo: username)
        .get();
  }

  Future<Stream<QuerySnapshot>> getchat() async {
    String? myusername = await Sharedpreferencestool().getuserusername();
    if (myusername == null) {
      throw Exception("Username is null. Cannot fetch chatrooms.");
    }

    return FirebaseFirestore.instance
        .collection("chatrooms")
        .where("users", arrayContains: myusername)
        .orderBy("time", descending: true)
        .snapshots();
  }
}
