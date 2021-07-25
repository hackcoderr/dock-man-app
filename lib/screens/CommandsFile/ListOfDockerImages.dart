import 'package:dock_man/screens/Auth/get_ip.dart';
import 'package:dock_man/screens/Settings/settings.dart';
import 'package:dock_man/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

String query;
String IP_Value;

class ListOfDockerImages extends StatelessWidget {
  AppBar appBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.red[200],
      title: Text(
        "List of Docker Image(s)",
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
            onPressed: () => Homebody(),
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
        Icons.refresh,
        color: Colors.white,
      ),
      backgroundColor: Colors.red[300],
      elevation: 2,
      tooltip: "Refresh",
      onPressed: () {},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar(context),
      body: ListOfDockerImagesBody(),
      floatingActionButton: floatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: bottomAppBar(context),
    );
  }
}

class ListOfDockerImagesBody extends StatefulWidget {
  @override
  _ListOfDockerImagesBodyState createState() => _ListOfDockerImagesBodyState();
}

class _ListOfDockerImagesBodyState extends State<ListOfDockerImagesBody> {
  var cmd;
  var webdata;

  myweb(cmd) async {
    IP_Value = readIPUser();
    var url = "http://$IP_Value/cgi-bin/web.py?x=${cmd}";
    var r = await http.get(url);
    setState(() {
      webdata = r.body;
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
              "Docker Images List",
              style: GoogleFonts.lato(
                  color: Colors.black,
                  fontSize: 25,
                  fontWeight: FontWeight.w400),
            ),
            const SizedBox(height: 10),
            RaisedButton(
              onPressed: () {
                print("Ip : $IP_Value");
                myweb("docker images");
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
                child: const Text('Show List', style: TextStyle(fontSize: 10)),
              ),
            ),
            const SizedBox(height: 15),
            Container(
              padding: EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                color: Colors.red[100],
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.all(Radius.circular(5)),
              ),
              child: Text(
                webdata ?? "Output",
                style: TextStyle(
                  fontSize: 11,
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
