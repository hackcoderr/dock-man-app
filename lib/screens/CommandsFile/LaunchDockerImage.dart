import 'package:custom_switch/custom_switch.dart';
import 'package:dock_man/screens/Auth/get_ip.dart';
import 'package:dock_man/screens/Settings/settings.dart';
import 'package:dock_man/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

String osname, nickname, cmd;
String IP_Value;

class LaunchDockerImage extends StatefulWidget {
  @override
  _LaunchDockerImageState createState() => _LaunchDockerImageState();
}

class _LaunchDockerImageState extends State<LaunchDockerImage> {
  AppBar appBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.red[200],
      title: Text(
        "Launch Docker Image",
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
  int _value = 0;
  bool status_i = false, status_t = false, status_d = false;
  String data = "Output", version;

  myweb(cmd) async {
    IP_Value = readIPUser();
    var url = "http://$IP_Value/cgi-bin/web.py?x=${cmd}";
    var r = await http.get(url);
    print(r.body);
    setState(() {
      data = "Container Launched";
    });
  }

  os() {
    if (_value == 1) {
      version = "ubuntu:latest";
    } else if (_value == 2) {
      version = "centos:7";
    } else if (_value == 3) {
      version = "httpd:latest";
    } else if (_value == 4) {
      version = "wordpress:5.1.1-php7.3-apache";
    }
  }

  process() {
    os();
    if (status_i == true && status_t == true && status_d == true) {
      cmd = "docker run -dit --name $nickname $version";
    } else if (status_i == true && status_t == true && status_d == false) {
      cmd = "docker run -it --name $nickname $version";
    } else if (status_i == true && status_t == false && status_d == true) {
      cmd = "docker run -di --name $nickname $version";
    } else {
      cmd = "docker run -dit --name $nickname $version";
    }
    print("nickname: $nickname , version: $version");
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
                margin: EdgeInsets.only(top: 20),
                padding: EdgeInsets.all(10.0),
                width: double.infinity,
                height: 60,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all()),
                child: DropdownButton(
                  value: _value,
                  isExpanded: true,
                  items: [
                    DropdownMenuItem(
                      child: Text("Os Name and Version"),
                      value: 0,
                    ),
                    DropdownMenuItem(
                      child: Text("Ubuntu 18.04"),
                      value: 1,
                    ),
                    DropdownMenuItem(
                      child: Text("Centos 7"),
                      value: 2,
                    ),
                    DropdownMenuItem(
                      child: Text("httpd"),
                      value: 3,
                    ),
                    DropdownMenuItem(
                      child: Text("wordpress"),
                      value: 4,
                    )
                  ],
                  onChanged: (value) {
                    setState(() {
                      _value = value;
                      os();
                    });
                  },
                ),
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
                    "Interactive: ",
                    style: TextStyle(
                      fontSize: 25,
                    ),
                  ),
                  const SizedBox(width: 170),
                  CustomSwitch(
                    activeColor: Colors.pinkAccent,
                    value: status_i,
                    onChanged: (value) {
                      print("VALUE : $value");
                      setState(() {
                        status_i = value;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: <Widget>[
                  const SizedBox(width: 10),
                  Text(
                    "Terminal: ",
                    style: TextStyle(
                      fontSize: 25,
                    ),
                  ),
                  const SizedBox(width: 190),
                  CustomSwitch(
                    activeColor: Colors.pinkAccent,
                    value: status_t,
                    onChanged: (value) {
                      print("VALUE : $value");
                      setState(() {
                        status_t = value;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: <Widget>[
                  const SizedBox(width: 10),
                  Text(
                    "Move to Backgroud: ",
                    style: TextStyle(
                      fontSize: 25,
                    ),
                  ),
                  const SizedBox(width: 70),
                  CustomSwitch(
                    activeColor: Colors.pinkAccent,
                    value: status_d,
                    onChanged: (value) {
                      print("VALUE : $value");
                      setState(() {
                        status_d = value;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 10),
              RaisedButton(
                onPressed: () {
                  process();
                  myweb(cmd);
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
