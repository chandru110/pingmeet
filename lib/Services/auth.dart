import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pingmeet/Services/database.dart';
import 'package:pingmeet/Services/shared_pref.dart';
import 'package:pingmeet/pages/home.dart';

class Authmethods {
  getCurrentUser() async {
    FirebaseAuth.instance.currentUser;
  }

  signinWithGoogle(BuildContext context) async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    final UserCredential result = await FirebaseAuth.instance
        .signInWithCredential(credential);

    final User? userDetails = result.user;

    String username = userDetails!.email!.replaceAll("@gmail.com", "");
    String firstletter = username.substring(0, 1).toUpperCase();
    await Sharedpreferencestool().saveuserid(userDetails!.uid);
    await Sharedpreferencestool().saveuseremail(userDetails!.email!);
    await Sharedpreferencestool().saveuserimage(userDetails!.photoURL!);
    await Sharedpreferencestool().saveuserusername(username);
    await Sharedpreferencestool().saveusername(userDetails!.displayName!);
    Map<String, dynamic> userinfo = {
      "Name": userDetails!.displayName,
      "Email": userDetails!.email,
      "Image": userDetails!.photoURL,
      "Id": userDetails!.uid,
      "Username": username.toUpperCase(),
      "SearchKey": firstletter,
    };

    await DatabaseMethods().addUser(userinfo, userDetails!.uid).then((value) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          backgroundColor: Colors.green.shade600,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 10,
          duration: Duration(seconds: 3),
          content: Row(
            children: [
              Icon(Icons.check_circle, color: Colors.white, size: 26),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  "Successfully Logged In!",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) {
            return Home();
          },
        ),
      );
    });
  }

  Future Signout() async {
    await GoogleSignIn().signOut();
    await FirebaseAuth.instance.signOut();
  }
}
