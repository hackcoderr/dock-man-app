import 'package:dock_man/screens/home/home.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

// ignore: non_constant_identifier_names
final DBRef = FirebaseDatabase.instance.reference();

var count = 0;
var userId = 0;

int datalen() {
  var data;
  DBRef.once().then(
    (DataSnapshot dataSnapshot) {
      data = dataSnapshot.value;
    },
  );
  return (data.length);
}

void writeData(context, name, email, pass, ip) {
  count = datalen();
  count = count + 1;
  DBRef.child(count.toString()).set(
    {'name': name, 'email': email, 'password': pass, 'ip': ip},
  );
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => Home(),
    ),
  );
}

void loginCheck(email, password, context) {
  bool status = false;
  DBRef.once().then(
    (DataSnapshot dataSnapshot) {
      var data = dataSnapshot.value;
      var len = data.length;
      for (var i = 2; i < len; i++) {
        if (data[i]['email'] == email && data[i]['password'] == password) {
          status = true;
          userId = i;
        }
      }

      if (status == true) {
        Fluttertoast.showToast(
          msg: "Login Successful",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16,
        );
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Home(),
          ),
        );
      } else {
        print("Login Fail");
        Fluttertoast.showToast(
          msg: "Invalid Mail Id or Password",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16,
        );
      }
    },
  );
}
