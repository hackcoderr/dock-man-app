import 'package:dock_man/screens/CommandsFile/LaunchDockerImage.dart';
import 'package:dock_man/screens/CommandsFile/ListOfDockerImages.dart';
import 'package:dock_man/screens/CommandsFile/RemoveContainer.dart';
import 'package:dock_man/screens/CommandsFile/RemoveImage.dart';
import 'package:dock_man/screens/CommandsFile/RunAContainer.dart';
import 'package:dock_man/screens/CommandsFile/RunningContainer.dart';
import 'package:dock_man/screens/CommandsFile/DetailsContainer.dart';
import 'package:dock_man/screens/Signup/components/background.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Homebody(),
    );
  }
}

class Homebody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            height: size.height,
            width: size.width,
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Align(
                  heightFactor: 2,
                  child: Text(
                    "Docker Manager",
                    style: GoogleFonts.lato(
                        color: Colors.black,
                        fontSize: 45,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    GestureDetector(
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        color: Colors.red[100],
                        child: InkWell(
                          splashColor: Colors.red,
                          child: Container(
                            width: 350,
                            height: 490,
                            child: Column(
                              children: <Widget>[
                                ListTile(
                                  title: Text(
                                    "List of Docker Images",
                                    style: GoogleFonts.lato(
                                      color: Colors.black,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                  trailing: Icon(
                                    Icons.arrow_forward,
                                    color: Colors.black,
                                  ),
                                  onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (contex) => ListOfDockerImages(),
                                    ),
                                  ),
                                ),
                                _divider(),
                                ListTile(
                                  title: Text(
                                    "Launch Docker Images",
                                    style: GoogleFonts.lato(
                                      color: Colors.black,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                  trailing: Icon(
                                    Icons.arrow_forward,
                                    color: Colors.black,
                                  ),
                                  onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (contex) => LaunchDockerImage(),
                                    ),
                                  ),
                                ),
                                _divider(),
                                ListTile(
                                  title: Text(
                                    "Currently Running Container(s)",
                                    style: GoogleFonts.lato(
                                      color: Colors.black,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                  trailing: Icon(
                                    Icons.arrow_forward,
                                    color: Colors.black,
                                  ),
                                  onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (contex) => RunningContainer(),
                                    ),
                                  ),
                                ),
                                _divider(),
                                ListTile(
                                  title: Text(
                                    "Run a docker container",
                                    style: GoogleFonts.lato(
                                      color: Colors.black,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                  trailing: Icon(
                                    Icons.arrow_forward,
                                    color: Colors.black,
                                  ),
                                  onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (contex) => RunAContainer(),
                                    ),
                                  ),
                                ),
                                _divider(),
                                ListTile(
                                  title: Text(
                                    "Remove a container",
                                    style: GoogleFonts.lato(
                                      color: Colors.black,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                  trailing: Icon(
                                    Icons.arrow_forward,
                                    color: Colors.black,
                                  ),
                                  onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (contex) => RemoveContainer(),
                                    ),
                                  ),
                                ),
                                _divider(),
                                ListTile(
                                  title: Text(
                                    "Details of a container",
                                    style: GoogleFonts.lato(
                                      color: Colors.black,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                  trailing: Icon(
                                    Icons.arrow_forward,
                                    color: Colors.black,
                                  ),
                                  onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (contex) => DetailsContainer(),
                                    ),
                                  ),
                                ),
                                _divider(),
                                ListTile(
                                  title: Text(
                                    "Remove a docker image",
                                    style: GoogleFonts.lato(
                                      color: Colors.black,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                  trailing: Icon(
                                    Icons.arrow_forward,
                                    color: Colors.black,
                                  ),
                                  onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (contex) => RemoveImage(),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget _divider() {
  return Container(
    child: Row(
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: Divider(
              color: Colors.black,
              thickness: 1,
            ),
          ),
        ),
      ],
    ),
  );
}
