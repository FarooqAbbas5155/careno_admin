import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart' as auth;

import 'package:cloud_firestore/cloud_firestore.dart';
String image_url = "https://phito.be/wp-content/uploads/2020/01/placeholder.png";

Color primaryColor = Color(0xff4C0AE1);
var uid = auth.FirebaseAuth.instance.currentUser!.uid;
var dbInstance = FirebaseFirestore.instance;
CollectionReference usersRef = dbInstance.collection("users");
CollectionReference categoryRef = dbInstance.collection("categories");
CollectionReference addVehicleRef = dbInstance.collection("vehicles");
CollectionReference bookingsRef = dbInstance.collection("bookings");
CollectionReference notificationRef = dbInstance.collection("notifications");