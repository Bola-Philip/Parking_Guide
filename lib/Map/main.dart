import 'package:parking_guide/Map/Gui/map.dart';
import 'package:parking_guide/Map/Json/Comment.dart';
import 'package:parking_guide/Map/Json/Json.dart';
import 'package:parking_guide/Map/bloc/json_bloc.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  FetchData fetching = FetchData();
  RequestJson? commentData = RequestJson();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(BlocProvider(
    create: (context) => JsonBloc(fetching,commentData),

    child: MaterialApp(debugShowCheckedModeBanner: false,
        home: MapData()),
  )
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(children: [
        Column(
          children: [
            ClipPath(
              clipper: MyClipper(),
              child: Container(
                height: 250,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.green[900]!,
                      Colors.green[300]!,
                      Colors.greenAccent
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Center(
                  child: Text(
                    'welcome',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            )
          ],
        ),
      ]),
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
