import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:pingmeet/Services/database.dart';
import 'package:pingmeet/Services/shared_pref.dart';
import 'package:random_string/random_string.dart';

class ChatPage extends StatefulWidget {
  String name, username, profileurl;
  ChatPage({
    super.key,
    required this.name,
    required this.username,
    required this.profileurl,
  });

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  TextEditingController messagecontroller = TextEditingController();
  String? myusername, myname, myemail, mypic, chatroomid, messageid;
  getsharedpref() async {
    myusername = await Sharedpreferencestool().getuserusername();
    myname = await Sharedpreferencestool().getusername();
    myemail = await Sharedpreferencestool().getuseremail();
    mypic = await Sharedpreferencestool().getuserimage();
    chatroomid = getchatroomidbyusername(widget.username, myusername!);
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    getsharedpref();
    super.initState();
  }

  getchatroomidbyusername(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "${b}_$a";
    } else {
      return "${a}_$b";
    }
  }

  Future addMessage(bool sendbuttonclicked) async {
    if (messagecontroller.text != "") {
      String mes = messagecontroller.text;
      messagecontroller.text = "";

      DateTime now = DateTime.now();
      String formatteddate = DateFormat('h.mma').format(now);

      Map<String, dynamic> messageinfo = {
        "message": mes,
        "sendby": myusername,
        "ts": formatteddate,
        "time": FieldValue.serverTimestamp(),
      };
      messageid = randomAlphaNumeric(10);
      await DatabaseMethods()
          .addmessage(messageinfo, chatroomid!, messageid!)
          .then((value) async {
            Map<String, dynamic> lastmessageinfo = {
              "lastmessage": mes,
              "lastmessageTs": formatteddate,
              "time": FieldValue.serverTimestamp(),
              "lastmeassagesendby": myusername,
            };

            await DatabaseMethods().updatelastmessagesend(
              chatroomid!,
              lastmessageinfo,
            );
            if (sendbuttonclicked) {
              mes = "";
            }
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff703eff),
      body: Container(
        margin: EdgeInsets.only(top: 40),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsetsGeometry.only(left: 20),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width / 5),
                  Text(
                    "chandru",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: const Color.fromARGB(187, 255, 255, 255),
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(left: 10, right: 10),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Column(
                  children: [
                    SizedBox(height: 30),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(7),
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(33),
                              topRight: Radius.circular(30),
                              bottomRight: Radius.circular(30),
                            ),
                          ),
                          child: Text(
                            "Hi, how are you?",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          padding: EdgeInsets.all(7),
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(33),
                              topRight: Radius.circular(30),
                              bottomLeft: Radius.circular(30),
                            ),
                          ),
                          child: Text(
                            "Hey im good wbu?",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height / 1.6),
                    Container(
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(7),
                            decoration: BoxDecoration(
                              color: Color(0xff703eff),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Icon(
                              Icons.mic,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                          SizedBox(width: 5),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.only(left: 10),

                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                color: Color(0xFFececf8),
                              ),
                              child: TextField(
                                controller: messagecontroller,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Write a message...",
                                  suffixIcon: Icon(Icons.attach_file),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 5),
                          Container(
                            padding: EdgeInsets.all(7),
                            decoration: BoxDecoration(
                              color: Color(0xff703eff),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: GestureDetector(
                              onTap: () async {
                                await addMessage(true);
                              },
                              child: Icon(
                                Icons.send,
                                color: Colors.white,
                                size: 30,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
