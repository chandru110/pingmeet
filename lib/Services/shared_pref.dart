import 'package:shared_preferences/shared_preferences.dart';

class Sharedpreferencestool {
  // Keys
  static String useridkey = "USERID";
  static String usernamekey = "USERNAME";
  static String useremailkey = "USEREMAIL";
  static String userusernamekey = "USERUSERNAME";
  static String userimagekey = "USERIMAGE";

  // Save Methods
  Future<bool> saveuserid(String getuserid) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.setString(useridkey, getuserid);
  }

  Future<bool> saveusername(String getusername) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.setString(usernamekey, getusername);
  }

  Future<bool> saveuseremail(String getuseremail) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.setString(useremailkey, getuseremail);
  }

  Future<bool> saveuserusername(String getuserusername) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.setString(userusernamekey, getuserusername);
  }

  Future<bool> saveuserimage(String getuserimage) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.setString(userimagekey, getuserimage);
  }

  // Get Methods
  Future<String?> getuserid() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString(useridkey);
  }

  Future<String?> getusername() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString(usernamekey);
  }

  Future<String?> getuseremail() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString(useremailkey);
  }

  Future<String?> getuserusername() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString(userusernamekey);
  }

  Future<String?> getuserimage() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString(userimagekey);
  }
}
