import 'package:flutter/material.dart';

class CreateAccount extends StatefulWidget {
  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Column(
            children: [
              ClipPath(
                clipper: MyClipper(),
                child: Container(
                  height: 280,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                    colors: [
                      Colors.green[900]!,
                      Colors.green[300]!,
                      Colors.greenAccent
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  )),
                  child: Center(
                    child: Text(
                      'Welcome',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Align(
                alignment: Alignment(-0.93, 0.0),
                child: Text(
                  'First Name',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
              TextFormField(
                decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.lightGreenAccent))),
                onChanged: (value) {},
              ),
              SizedBox(
                height: 15,
              ),
              Align(
                alignment: Alignment(-0.93, 0.0),
                child: Text(
                  'Last Name',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
              TextFormField(
                decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.lightGreenAccent))),
                onChanged: (value) {},
              ),
              SizedBox(
                height: 15,
              ),
              Align(
                alignment: Alignment(-0.9, 0.0),
                child: Text(
                  '',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
              TextFormField(
                decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.lightGreenAccent))),
                onChanged: (value) {},
              ),
              SizedBox(
                height: 15,
              ),
              Align(
                alignment: Alignment(-0.9, 0.0),
                child: Text(
                  '',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
              TextFormField(
                decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.lightGreenAccent))),
                onChanged: (value) {},
              ),
              SizedBox(
                height: 15,
              ),
              Align(
                alignment: Alignment(-0.9, 0.0),
                child: Text(
                  '',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
              TextFormField(
                decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.lightGreenAccent))),
                onChanged: (value) {},
              ),
              SizedBox(
                height: 15,
              ),
              Align(
                alignment: Alignment(-0.9, 0.0),
                child: Text(
                  '',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
              TextFormField(
                decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.lightGreenAccent))),
                onChanged: (value) {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// 🚨 Clipper Class For Curve AppBar 🚨
class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 40);
    path.quadraticBezierTo(
        size.width / 6, size.height, size.width / 3, size.height);
    path.quadraticBezierTo(size.width - (size.width / 3), size.height,
        size.width, size.height - 80);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
