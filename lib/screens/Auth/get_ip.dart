import 'package:dock_man/screens/Auth/auth.dart';
import 'package:firebase_database/firebase_database.dart';

// ignore: non_constant_identifier_names
final DBRef = FirebaseDatabase.instance.reference();
String u_ip;

String readIPUser() {
  DBRef.once().then((DataSnapshot dataSnapshot) {
    var data = dataSnapshot.value;
    u_ip = data[userId]['ip'].toString();
  });
  return u_ip;
}
