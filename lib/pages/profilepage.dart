import 'package:flutter/material.dart';
import 'package:pingmeet/Services/auth.dart';
import 'package:pingmeet/Services/shared_pref.dart';
import 'package:pingmeet/pages/onboarding.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String? myusername, myname, myemail, mypic, chatroomid, messageid;
  getsharedpref() async {
    myusername = await Sharedpreferencestool().getuserusername();
    myname = await Sharedpreferencestool().getusername();
    myemail = await Sharedpreferencestool().getuseremail();
    mypic = await Sharedpreferencestool().getuserimage();
    setState(() {});
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
      backgroundColor: Color(0xFF703EFF),
      appBar: AppBar(
        backgroundColor: Color(0xFF703EFF),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Profile",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        ),
        child: Column(
          children: [
            SizedBox(height: 30),
            mypic == null
                ? CircularProgressIndicator()
                : ClipRRect(
                    borderRadius: BorderRadius.circular(60),
                    child: Image.network(
                      mypic!,
                      fit: BoxFit.cover,
                      width: 80,
                      height: 80,
                    ),
                  ),
            SizedBox(height: 30),

            // Name Card
            Container(
              margin: EdgeInsets.symmetric(vertical: 8),
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Color(0xFFF5F5F5),
                boxShadow: [
                  BoxShadow(color: Colors.grey.shade300, blurRadius: 4),
                ],
              ),
              child: Row(
                children: [
                  Icon(Icons.person, color: Color(0xFF703EFF)),
                  SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "User Name",
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          myusername == null ? "Loading" : myusername!,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Email Card
            Container(
              margin: EdgeInsets.symmetric(vertical: 8),
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Color(0xFFF5F5F5),
                boxShadow: [
                  BoxShadow(color: Colors.grey.shade300, blurRadius: 4),
                ],
              ),
              child: Row(
                children: [
                  Icon(Icons.email, color: Color(0xFF703EFF)),
                  SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Email",
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          myemail == null ? "Loading" : myemail!,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // LogOut
            Container(
              margin: EdgeInsets.symmetric(vertical: 8),
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Color(0xFFF5F5F5),
                boxShadow: [
                  BoxShadow(color: Colors.grey.shade300, blurRadius: 4),
                ],
              ),
              child: GestureDetector(
                onTap: () async {
                  await Authmethods().Signout().then((value) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return Onboarding();
                        },
                      ),
                    );
                  });
                },
                child: Row(
                  children: [
                    Icon(Icons.logout, color: Colors.black),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        "LogOut",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
                  ],
                ),
              ),
            ),

            // Delete Account
          ],
        ),
      ),
    );
  }
}
