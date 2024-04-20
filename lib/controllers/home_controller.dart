import 'package:careno_admin/constant/helpers.dart';
import 'package:careno_admin/models/add_host_vehicle.dart';
import 'package:careno_admin/models/booking.dart';
import 'package:careno_admin/models/categories.dart';
import 'package:careno_admin/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../constant/fcm.dart';

class HomeController extends GetxController{


  // Get DashBoard data.....


RxList<User> user = RxList<User>([]);
RxList<User> message = RxList<User>([]);
RxList<User> Blockuser = RxList<User>([]);
RxList<User> host = RxList<User>([]);
RxList<User> Blockhost = RxList<User>([]);
RxList<User> hostRequest = RxList<User>([]);
RxList<Category> categories = RxList<Category>([]);
RxList<Booking> activeVehicle = RxList<Booking>([]);
RxList<AddHostVehicle> vehiclesRequest = RxList<AddHostVehicle>([]);
Stream<QuerySnapshot>? userSnapshot;
Stream<QuerySnapshot>? messageSnapshot;
Stream<QuerySnapshot>? BlockuserSnapshot;
Stream<QuerySnapshot>? hostSnapshot;
Stream<QuerySnapshot>? BlockhostSnapshot;
Stream<QuerySnapshot>? HostRequestSnapshot;
Stream<QuerySnapshot>? VehicelRequestSnapshot; // Es Ka variable modelClass maay bnana haay
Stream<QuerySnapshot>?  categorySnapshot;
Stream<QuerySnapshot>?  ActiveVehicleSnapshot;
@override
void onInit(){
  updateToken();
  userSnapshot = usersRef.where("userType", isEqualTo: "user").snapshots();
  user.bindStream(userSnapshot!.map((event) => event.docs.map((e) => User.fromMap(e.data() as Map<String,dynamic>)).toList()));
  BlockuserSnapshot = usersRef.where("userType", isEqualTo: "user").where("isBlocked",isEqualTo: true).snapshots();
  Blockuser.bindStream(BlockuserSnapshot!.map((event) => event.docs.map((e) => User.fromMap(e.data() as Map<String,dynamic>)).toList()));
  hostSnapshot = usersRef.where("userType", isEqualTo: "host").snapshots();
  host.bindStream(hostSnapshot!.map((event) => event.docs.map((e) => User.fromMap(e.data() as Map<String,dynamic>)).toList()));
  BlockhostSnapshot = usersRef.where("userType", isEqualTo: "host").where("isBlocked",isEqualTo: true).snapshots();
  Blockhost.bindStream(BlockhostSnapshot!.map((event) => event.docs.map((e) => User.fromMap(e.data() as Map<String,dynamic>)).toList()));
  HostRequestSnapshot = usersRef.where("userType", isEqualTo: "host").where("isVerified",isEqualTo: false).snapshots();
  hostRequest.bindStream(HostRequestSnapshot!.map((event) => event.docs.map((e) => User.fromMap(e.data() as Map<String,dynamic>)).toList()));
  VehicelRequestSnapshot = addVehicleRef.where("isVerified",isEqualTo: false).snapshots();
  vehiclesRequest.bindStream(VehicelRequestSnapshot!.map((event) => event.docs.map((e) => AddHostVehicle.fromMap(e.data() as Map<String,dynamic>)).toList() ));
  categorySnapshot = categoryRef.snapshots();
  categories.bindStream(categorySnapshot!.map((event) => event.docs.map((e) => Category.fromMap(e.data() as Map<String,dynamic>)).toList()));
  messageSnapshot =  usersRef.doc(uid).collection("chats").snapshots();
  message.bindStream(messageSnapshot!.map((event) => event.docs.map((e) => User.fromMap(e.data() as Map<String,dynamic>)).toList()));
  ActiveVehicleSnapshot = bookingsRef.where("bookingStatus", whereIn: ["In progress", "Pending Approval"]).snapshots();
  activeVehicle.bindStream(ActiveVehicleSnapshot!.map((event) => event.docs.map((e) => Booking.fromMap(e.data() as Map<String,dynamic>)).toList()));
  super.onInit();

}
void updateToken() async {
  var token = (await FCM.generateToken()) ?? "";
  usersRef.doc(uid).update({"notificationToken": token});
}
}