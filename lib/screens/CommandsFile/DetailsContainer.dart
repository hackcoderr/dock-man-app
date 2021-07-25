import 'package:custom_switch/custom_switch.dart';
import 'package:dock_man/screens/Auth/get_ip.dart';
import 'package:dock_man/screens/Settings/settings.dart';
import 'package:dock_man/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

String osname, nickname, cmd;
String IP_Value;

class DetailsContainer extends StatefulWidget {
  @override
  _DetailsContainerState createState() => _DetailsContainerState();
}

class _DetailsContainerState extends State<DetailsContainer> {
  AppBar appBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.red[200],
      title: Text(
        "Details of a Container",
        style: GoogleFonts.lato(
          color: Colors.black,
        ),
      ),
      centerTitle: true,
    );
  }

  BottomAppBar bottomAppBar(BuildContext context) {
    return BottomAppBar(
      color: Colors.red[200],
      shape: CircularNotchedRectangle(),
      notchMargin: 5,
      child: new Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
            icon: Icon(
              Icons.home,
              color: Colors.white,
            ),
            iconSize: 28.0,
            tooltip: "Home",
            onPressed: () => Home(),
          ),
          IconButton(
            icon: Icon(
              Icons.settings,
              color: Colors.white,
            ),
            iconSize: 28.0,
            tooltip: "Setting",
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Settings(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  FloatingActionButton floatingActionButton() {
    return FloatingActionButton(
      child: const Icon(
        Icons.feedback,
        color: Colors.white,
      ),
      backgroundColor: Colors.red[300],
      elevation: 2,
      tooltip: "Feedback",
      onPressed: () {},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar(context),
      body: LaunchDockerImageBody(),
      floatingActionButton: floatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: bottomAppBar(context),
    );
  }
}

class LaunchDockerImageBody extends StatefulWidget {
  @override
  _LaunchDockerImageBodyState createState() => _LaunchDockerImageBodyState();
}

class _LaunchDockerImageBodyState extends State<LaunchDockerImageBody> {
  bool status = false;
  String data = "Output", version;

  myweb(cmd) async {
    IP_Value = readIPUser();
    cmd = "docker inspect $cmd";
    var url = "http://$IP_Value/cgi-bin/web.py?x=${cmd}";
    var r = await http.get(url);
    print(r.body);
    setState(() {
      data = r.body;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
        minimum: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(bottom: 20),
                child: Image.asset(
                  "assets/images/dockman.png",
                  fit: BoxFit.fill,
                ),
              ),
              Text(
                "Commands",
                style: GoogleFonts.lato(
                    color: Colors.black,
                    fontSize: 25,
                    fontWeight: FontWeight.w400),
              ),
              Container(
                padding: EdgeInsets.only(top: 10),
                child: Card(
                  child: TextField(
                    onChanged: (val) {
                      nickname = val;
                    },
                    decoration: InputDecoration(
                      labelText: "Nickname for OS",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: <Widget>[
                  const SizedBox(width: 10),
                  Text(
                    "Only Ip: ",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(width: 170),
                  CustomSwitch(
                    activeColor: Colors.pinkAccent,
                    value: status,
                    onChanged: (value) {
                      print("VALUE : $value");
                      setState(() {
                        status = value;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 10),
              RaisedButton(
                onPressed: () {
                  if (status == false)
                    myweb(nickname);
                  else
                    myweb("$nickname | grep IP");
                },
                textColor: Colors.white,
                padding: const EdgeInsets.all(0.0),
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: <Color>[
                        Color(0xFF0D47A1),
                        Color(0xFF1976D2),
                        Color(0xFF42A5F5),
                      ],
                    ),
                  ),
                  padding: const EdgeInsets.all(10.0),
                  child: const Text('Submit', style: TextStyle(fontSize: 20)),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                padding: EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                  color: Colors.red[100],
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
                child: Text(
                  data ?? "Output",
                  style: TextStyle(
                    fontSize: 11,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
