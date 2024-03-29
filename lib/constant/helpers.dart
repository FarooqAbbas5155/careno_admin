import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';

Color primaryColor = Color(0xff4C0AE1);
var dbInstance = FirebaseFirestore.instance;
CollectionReference categoryRef = dbInstance.collection("categories");
