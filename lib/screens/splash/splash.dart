import 'package:dock_man/screens/Welcome/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: size.height,
        width: size.width,
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Center(
              child: ClipRRect(
                child: Image.asset(
                  "assets/images/dockman1.png",
                  fit: BoxFit.contain,
                ),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(200),
                    bottomRight: Radius.circular(200),
                    topLeft: Radius.circular(200),
                    topRight: Radius.circular(200)),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Center(
                  child: Text(
                    "Dock Man!",
                    style: GoogleFonts.lato(
                      color: Colors.black,
                      fontSize: 48.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    "Docker Manager",
                    style: GoogleFonts.lato(
                      color: Colors.black54,
                      fontSize: 25.0,
                    ),
                  ),
                ),
              ],
            ),
            Center(
              child: GestureDetector(
                child: CircleAvatar(
                  radius: 40.0,
                  backgroundColor: Colors.black.withOpacity(0.20),
                  child: Icon(
                    Icons.dock,
                    color: Colors.black,
                    size: 45.0,
                  ),
                ),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WelcomeScreen(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
