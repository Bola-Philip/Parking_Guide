import 'dart:ui';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:parking_guide/Map/Gui/MyAllRequests.dart';
import 'package:parking_guide/Map/Json/Json.dart';
import 'package:parking_guide/Map/Models/LastRequest.dart';
import 'package:parking_guide/Map/bloc/requests_info_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyRequests extends StatefulWidget {
  const MyRequests({Key? key}) : super(key: key);

  @override
  _MyRequestsState createState() => _MyRequestsState();
}

class _MyRequestsState extends State<MyRequests> {
  FetchData fetchData = FetchData();
  Requests myRequests=Requests();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocProvider(
        create: (context) =>
            RequestsInfoBloc(fetchData)..add(ClickedRequestEvent()),
        child: BlocBuilder<RequestsInfoBloc, RequestsInfoState>(
          builder: (context, state) {
            if (state is error) {
              return Text(state.message);
            }
            if (state is RequestsInfoLoading) {
              return SpinKitSquareCircle(
                color: Colors.teal,
                size: 50,
              );
            }

            if (state is RequestsInfoLoaded) {
              myRequests = state.RequestList;
            }

            return Scaffold(
              backgroundColor: Colors.teal,
              body: Column(
                children: [
                  Expanded(
                      flex: 2,
                      child: Container(
                          alignment: Alignment.center,
                          child: Text('This is your request information',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 16)))),
                  Expanded(
                    flex: 10,
                    child: Container(
                      height: 200,
                      width: double.infinity,
                      child: Card(
                        margin: EdgeInsets.zero,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  margin: EdgeInsets.only(bottom: 10, top: 20),
                                  child: Row(children: [Text('Name:',style: TextStyle(color: Colors.teal,fontSize: 17),),SizedBox(width: 20,),Text(myRequests.name ?? '',style: TextStyle(color: Colors.grey,fontSize: 17),)],)),
                              Container(
                                  margin: EdgeInsets.only(bottom: 10),
                                  child: Row(children: [Text('Address:',style: TextStyle(color: Colors.teal,fontSize: 17)),SizedBox(width: 20,),Text('${myRequests.b_number.toString() } ${myRequests.street ?? ''}, ${myRequests.city ?? ''}',style: TextStyle(color: Colors.grey,fontSize: 17))],)),
                              Container(
                                  margin: EdgeInsets.only(bottom: 10),
                                  child: Row(children: [Text('Status',style: TextStyle(color: Colors.teal,fontSize: 17)),SizedBox(width: 20,),Text(myRequests.status.toString(),style: TextStyle(color: Colors.grey,fontSize: 17))],)),
                              Container(
                                  margin: EdgeInsets.only(bottom: 10),
                                  child: Row(children: [Text('Free spots',style: TextStyle(color: Colors.teal,fontSize: 17)),SizedBox(width: 20,)],)),
                              Container(
                                height: 300,
                                child: ListView.builder(
                                  physics: BouncingScrollPhysics(),
                                  itemCount: 3,
                                  itemBuilder: (context, floors) {
                                    floors++;
                                    return Column(
                                      children: [
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              'Floor ' + '$floors',
                                              textAlign: TextAlign.right,
                                              style: TextStyle(fontSize: 17),
                                            )),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          height: 120,
                                          child: ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            itemCount: 3,
                                            itemBuilder: (context, pics) {
                                              // return Row(
                                              //   children: [
                                              //     Image.network(
                                              //       'https://st3.depositphotos.com/1177973/13201/i/1600/depositphotos_132013332-stock-photo-underground-parking-at-shopping-mall.jpg',
                                              //       width: 204,
                                              //       fit: BoxFit
                                              //           .cover,
                                              //     ),
                                              //     SizedBox(
                                              //       width: 8,
                                              //     ),
                                              //   ],
                                              // );
                                              return Card(
                                                color: Colors.green,
                                                child: Container(
                                                  width: 150,
                                                  height: 100,
                                                  child: Text('data'),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ),
                              Container(margin: EdgeInsets.only(top: 80),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {},
                                      child: Text(
                                        'Cancel',
                                        style: TextStyle(color: Colors.teal),
                                      ),
                                      style: ElevatedButton.styleFrom(
                                          primary: Colors.white,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10))),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {},
                                      child: Text(
                                        'i\'m There',
                                        style: TextStyle(color: Colors.teal),
                                      ),
                                      style: ElevatedButton.styleFrom(
                                          primary: Colors.white,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10))),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        fetchData.showAllRequests(myRequests.garage_id);
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => MyAllRequests(garage_id: myRequests.garage_id,),));
                                      },
                                      child: Text(
                                        'Hestory',
                                        style: TextStyle(color: Colors.teal),
                                      ),
                                      style: ElevatedButton.styleFrom(
                                          primary: Colors.white,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                              BorderRadius.circular(10))),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadiusDirectional.only(
                                topStart: Radius.circular(40),
                                topEnd: Radius.circular(40))),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
