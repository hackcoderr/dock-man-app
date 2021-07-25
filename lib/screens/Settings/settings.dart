import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dock_man/screens/Auth/auth.dart';

import 'package:firebase_database/firebase_database.dart';

// ignore: non_constant_identifier_names
final DBRef = FirebaseDatabase.instance.reference();

String u_name, u_mail, u_ip, value;

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  myFunMail(cmd) {
    setState(() {
      u_mail = cmd;
    });
    print(cmd);
  }

  AppBar appBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.black,
      title: Text(
        "User Settings",
        style: GoogleFonts.lato(
          color: Colors.white,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar(context),
      body: SettingsBody(),
    );
  }

  readName() {
    DBRef.once().then((DataSnapshot dataSnapshot) {
      var data = dataSnapshot.value;
      u_name = data[userId]['name'].toString();
    });
  }

  readMail() {
    DBRef.once().then((DataSnapshot dataSnapshot) {
      var data = dataSnapshot.value;
      u_mail = data[userId]['email'].toString();
    });
  }

  readIP() {
    DBRef.once().then((DataSnapshot dataSnapshot) {
      var data = dataSnapshot.value;
      u_ip = data[userId]['ip'].toString();
    });
  }

  updateData(status, newData) {
    if (status == "MailId") {
      DBRef.child(userId.toString()).update(
        {
          'email': newData,
        },
      );
    } else {
      DBRef.child(userId.toString()).update(
        {
          'Ip': newData,
        },
      );
    }
  }

  edit(context, status) {
    Size size = MediaQuery.of(context).size;
    return showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
          elevation: 16,
          child: Container(
            height: 200.0,
            width: 380.0,
            padding: EdgeInsets.only(left: 10, right: 10),
            child: ListView(
              children: <Widget>[
                SizedBox(height: 20),
                Center(
                  child: Text(
                    status,
                    style: TextStyle(
                        fontSize: 24,
                        color: Colors.blue,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Text(
                  "Update:",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                SizedBox(height: size.height * 0.02),
                TextField(
                  onChanged: (value) {},
                  decoration: InputDecoration(
                    labelText: status,
                    border: OutlineInputBorder(),
                  ),
                ),
                FlatButton(
                  onPressed: () {
                    if (status == "MailId") {
                      myFunMail(value);
                    } else {
                      u_ip = value;
                    }
                  },
                  child: Text("Save"),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

class SettingsBody extends StatefulWidget {
  @override
  _SettingsBodyState createState() => _SettingsBodyState();
}

class _SettingsBodyState extends State<SettingsBody> {
  _SettingsState obj = new _SettingsState();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    obj.readName();
    obj.readMail();
    obj.readIP();

    return SafeArea(
      minimum: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
      child: Container(
        alignment: Alignment.topLeft,
        child: Column(
          children: <Widget>[
            CircleAvatar(
              backgroundImage: AssetImage('assets/icons/avtar.webp'),
              radius: 80,
            ),
            SizedBox(height: size.height * 0.02),
            Text(
              u_name ?? "User-name",
              style: GoogleFonts.lato(
                  color: Colors.black,
                  fontSize: 25,
                  fontWeight: FontWeight.w400),
            ),
            SizedBox(height: size.height * 0.02),
            Align(
              alignment: Alignment.topLeft,
              child: Column(
                children: <Widget>[
                  Text(
                    "User Settings",
                    textAlign: TextAlign.left,
                    style: GoogleFonts.lato(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w400),
                  ),
                  SizedBox(height: size.height * 0.02),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                        width: 3,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      title: Text("Mail Id:"),
                      subtitle: Text(u_mail ?? "Mail"),
                      leading: Icon(Icons.mail),
                      trailing: Icon(Icons.edit),
                      onTap: () {
                        obj.edit(context, "MailId");
                      },
                    ),
                  ),
                  SizedBox(height: size.height * 0.02),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                        width: 3,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      title: Text("Docker Server IP:"),
                      subtitle: Text(u_ip ?? "IP"),
                      leading: Icon(Icons.network_check),
                      trailing: Icon(Icons.edit),
                      onTap: () {
                        obj.edit(context, "Docker Server IP");
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
