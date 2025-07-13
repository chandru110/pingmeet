import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pingmeet/Services/database.dart';
import 'package:pingmeet/Services/shared_pref.dart';
import 'package:pingmeet/pages/chat_page.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _searchcontroller = TextEditingController();
  String? myusername, myname, myemail, mypic, chatroomid, messageid;
  getsharedpref() async {
    myusername = await Sharedpreferencestool().getuserusername();
    myname = await Sharedpreferencestool().getusername();
    myemail = await Sharedpreferencestool().getuseremail();
    mypic = await Sharedpreferencestool().getuserimage();
    setState(() {});
  }

  bool search = false;
  var qeueryresultset = [];
  var tempsearch = [];

  initiateSearch(String value) {
    if (value.isEmpty) {
      setState(() {
        search = false;
        qeueryresultset = [];
        tempsearch = [];
      });
      return; // 🔴 Important: Stop here if empty
    }

    setState(() {
      search = true;
    });

    var capitalizedvalue =
        value.substring(0, 1).toUpperCase() + value.substring(1);

    if (qeueryresultset.isEmpty && value.length == 1) {
      DatabaseMethods().searchuser(value).then((QuerySnapshot docs) {
        qeueryresultset = docs.docs.map((doc) => doc.data()).toList();
        setState(() {
          tempsearch = qeueryresultset
              .where(
                (element) =>
                    element['Username'].toString().startsWith(capitalizedvalue),
              )
              .toList();
        });
      });
    } else {
      tempsearch = [];
      for (var element in qeueryresultset) {
        if (element['Username'].toString().startsWith(capitalizedvalue)) {
          tempsearch.add(element);
        }
      }
      setState(() {});
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    getsharedpref();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff703eff),
      body: Container(
        margin: EdgeInsets.only(top: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Row(
                children: [
                  Image.asset("images/wave.png", height: 50, width: 50),
                  SizedBox(width: 5),
                  Text(
                    "Hello, ",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  myname == null
                      ? CircularProgressIndicator(color: Colors.white)
                      : Text(
                          myname!,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                  Spacer(),
                  Container(
                    width: 40,
                    height: 30,
                    margin: EdgeInsets.only(right: 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),

                    child: Icon(Icons.person, color: Color(0xff703eff)),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Text(
                "Welcome To",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: const Color.fromARGB(187, 255, 255, 255),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Text(
                "PingMeet",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(left: 20, right: 20),
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
                    Container(
                      decoration: BoxDecoration(
                        color: Color(0xFFececf8),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: TextField(
                        controller: _searchcontroller,
                        onChanged: (value) {
                          initiateSearch(value.toUpperCase());
                        },
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          prefixIcon: Icon(Icons.search),
                          hintText: "Search Username...",
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    search
                        ? ListView(
                            padding: EdgeInsets.only(left: 10, right: 10),
                            primary: false,
                            shrinkWrap: true,
                            children: tempsearch.map((element) {
                              return buildcardresult(element);
                            }).toList(),
                          )
                        : InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return ChatPage(
                                      name: "Selvam N",
                                      profileurl: "images/boy.jpg",
                                      username: "SELVAMSGRP",
                                    );
                                  },
                                ),
                              );
                            },
                            child: Material(
                              borderRadius: BorderRadius.circular(10),
                              elevation: 3,
                              child: Container(
                                padding: EdgeInsets.all(10),
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(60),
                                      child: Image.asset(
                                        "images/boy.jpg",
                                        fit: BoxFit.cover,
                                        width: 80,
                                        height: 80,
                                      ),
                                    ),
                                    SizedBox(width: 15),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(height: 10),
                                        Text(
                                          "SELVAM",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        Text(
                                          "Hi, How are you",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: const Color.fromARGB(
                                              255,
                                              161,
                                              157,
                                              157,
                                            ),
                                            fontSize: 18,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Spacer(),
                                    Text(
                                      "02:00 PM",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
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

  Widget buildcardresult(data) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Material(
        borderRadius: BorderRadius.circular(10),
        elevation: 3,
        child: Container(
          padding: EdgeInsets.all(10),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(60),
                child: Image.network(
                  data["Image"],
                  fit: BoxFit.cover,
                  width: 80,
                  height: 80,
                ),
              ),
              SizedBox(width: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10),
                  Text(
                    data["Name"],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    data["Username"],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: const Color.fromARGB(255, 161, 157, 157),
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
