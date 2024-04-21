import 'dart:ui';
import 'package:careno_admin/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

import '../models/categories.dart';
String image_url = "https://phito.be/wp-content/uploads/2020/01/placeholder.png";

Color primaryColor = Color(0xff4C0AE1);
var uid = auth.FirebaseAuth.instance.currentUser!.uid;
var dbInstance = FirebaseFirestore.instance;
CollectionReference usersRef = dbInstance.collection("users");
CollectionReference categoryRef = dbInstance.collection("categories");
CollectionReference addVehicleRef = dbInstance.collection("vehicles");
CollectionReference bookingsRef = dbInstance.collection("bookings");
CollectionReference percentageRef = dbInstance.collection("percentage");
CollectionReference notificationRef = dbInstance.collection("notifications");

Map<String,User> _allUserMap = {};
Map<String, Category> _allCategoryMap = {};

Future<User> getUser(String id)async{
  var user = _allUserMap[id];
 if (user == null) {
   var doc = await usersRef.doc(id).get();
   user = User.fromMap(doc.data() as Map<String,dynamic>);
   _allUserMap[id] = user;

 }

  return user;
}
User defaultUser = User(
  userType: "",
  phoneNumber: "phoneNumber",
  imageUrl: "",
  name: '',
  email: '',
  profileDescription: '',
  dob: 0,
  lat: 0.0,
  lng: 0.0,
  uid: uid,
  gender: "",
  notification: false,
  notificationToken: '',
  timeStamp: DateTime.now().millisecondsSinceEpoch,
  isVerified: false,
  isBlocked: false,
  status: '', address: '', currentBalance: 0.0,
);

Future<Category> getCategory(String id) async {
  var category = _allCategoryMap[id];
  if (category == null) {
    var doc = await categoryRef.doc(id).get();
    category = Category.fromMap(doc.data() as Map<String, dynamic>);
    _allCategoryMap[id] = category;
  }
  return category;
}

String dateFormat(DateTime dateTime,) {
  // Use DateFormat class from intl package to format the date
  DateFormat dateFormat = DateFormat.yMMMMd('en_US');
  return dateFormat.format(dateTime);
}
String get2ndUserId(String chatRoomId, String myId){
  return chatRoomId.replaceAll(myId, "").replaceAll("_", "").trim();
}
String BookingDateFormate(int dateTime){
  DateTime dobDateTime = DateTime.fromMillisecondsSinceEpoch(dateTime);
  String formattedDate = DateFormat('dd/MM/yyyy ').format(dobDateTime);
  return formattedDate;
}
String formatTime(int hour24) {

  // Create a DateTime object with the given hour in 24-hour format
  DateTime dateTime = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, hour24);

  // Format the DateTime object using DateFormat to convert to 12-hour format with AM/PM
  DateFormat dateFormat = DateFormat('h:mm a'); // 'h:mm a' for 12-hour format with AM/PM
  String formattedTime = dateFormat.format(dateTime);

  return formattedTime;
}
