import 'dart:ui';

import 'package:parking_guide/Map/Gui/MyRequests.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 30),
              // Image.asset('assets/green.jpg',height: 350.0,fit: BoxFit.none,)
              Row(
                children: [
                  Container(
                    height: 100.0,
                    width: 100.0,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.teal),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 6.0,
                              color: Colors.white,
                              offset: Offset(0, 6))
                        ]),
                    child: Icon(
                      Icons.person,
                      color: Colors.grey,
                      size: 50.0,
                    ),
                  ),
                  SizedBox(width: 16),
                  RichText(
                    text: TextSpan(
                      text: 'U',
                      style: TextStyle(
                          fontSize: 30.0,
                          color: Colors.teal.shade800,
                          fontWeight: FontWeight.bold),
                      children: <TextSpan>[
                        TextSpan(
                            text: 's',
                            style: TextStyle(
                                fontSize: 30.0,
                                color: Colors.teal.shade600,
                                fontWeight: FontWeight.bold)),
                        TextSpan(
                            text: 'e',
                            style: TextStyle(
                                fontSize: 30.0,
                                color: Colors.teal.shade400,
                                fontWeight: FontWeight.bold)),
                        TextSpan(
                            text: 'r',
                            style: TextStyle(
                                fontSize: 30.0,
                                color: Colors.teal.shade200,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ],
              ),

              SizedBox(
                height: 32,
              ),
              _customDividor(),
              SizedBox(
                height: 32,
              ),

              MaterialButton(
                child: Row(mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.request_quote_sharp,
                      color: Colors.teal.shade500,
                    ),SizedBox(width: 30,),
                    Text(
                      'MyRequests',
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 17.0,
                      ),
                    )
                  ],
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MyRequests(),
                      ));
                },
              ),

              ListTile(
                contentPadding:
                EdgeInsets.only(right: 10.0, left: 15.0, bottom: 5.0),
                leading: Icon(
                  Icons.settings,
                  color: Colors.teal.shade500,
                ),
                title: Text(
                  'Settings',
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 17.0,
                  ),
                ),
              ),
              ListTile(
                contentPadding:
                    EdgeInsets.only(right: 10.0, left: 15.0, bottom: 5.0),
                leading: Icon(
                  Icons.language,
                  color: Colors.teal.shade500,
                ),
                title: Text(
                  'Languages',
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 17.0,
                  ),
                ),
              ),
              ListTile(
                contentPadding:
                    EdgeInsets.only(right: 10.0, left: 15.0, bottom: 5.0),
                leading: Icon(
                  Icons.privacy_tip_outlined,
                  color: Colors.teal.shade500,
                ),
                title: Text(
                  'Privacy and policy',
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 17.0,
                  ),
                ),
              ),
              ListTile(
                contentPadding:
                    EdgeInsets.only(right: 10.0, left: 15.0, bottom: 5.0),
                leading: Icon(
                  Icons.phone_android,
                  color: Colors.teal.shade500,
                ),
                title: Text(
                  'contact us',
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 17.0,
                  ),
                ),
              ),
              SizedBox(
                height: 32,
              ),
              _customDividor(),
              Container(
                  padding: EdgeInsets.only(top: 50.0),
                  width: 200.0,
                  height: 100.0,
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    elevation: 2.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Logout',
                          style: TextStyle(
                              color: Colors.teal.shade500,
                              fontWeight: FontWeight.bold),
                        ),
                        Icon(
                          Icons.logout,
                          color: Colors.teal.shade500,
                        ),
                      ],
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  Container _customDividor() {
    return Container(
        width: 220,
        height: 1.0,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2),
            color: Colors.grey,
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 6,
                offset: Offset(0, 3),
                // spreadRadius: 50
              )
            ]));
  }
}
