import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
String image_url = "https://phito.be/wp-content/uploads/2020/01/placeholder.png";

Color primaryColor = Color(0xff4C0AE1);
var dbInstance = FirebaseFirestore.instance;
CollectionReference categoryRef = dbInstance.collection("categories");
