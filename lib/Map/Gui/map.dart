import 'dart:async';
import 'dart:ui';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:parking_guide/Map/Gui/WriteReview.dart';
import 'package:parking_guide/Map/Gui/custom_drawer.dart';
import 'package:parking_guide/Map/Json/Comment.dart';
import 'package:parking_guide/Map/Json/Json.dart';
import 'package:parking_guide/Map/Models/CommentsModel.dart';
import 'package:parking_guide/Map/Models/OrderModel.dart';
import 'package:parking_guide/Map/RelativeSizes2.dart';
import 'package:parking_guide/Map/bloc/json_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class MapData extends StatefulWidget {
  @override
  _MapDataState createState() => _MapDataState();
}

class _MapDataState extends State<MapData> {
  List<Marker> AllMarkers = [];
  double? lat = 0.0;
  double? long = 0.0;
  int? garageID;
  int? requestId;
  int bool = 0;
  String button = "Request";
  Timer? time;
  int counter = 10;
  Completer<GoogleMapController> _controller = Completer();
  PageController _pageController = PageController(viewportFraction: 0.85);

  //List<GettingData> _garages = [];
  List<OrderCards>? _garages = [];
  List<Comments>? _comments = [];
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  FetchData fetching = FetchData();
  RequestJson commentData = RequestJson();

  //*******************************************************************
  // 🚨 Json Function That Take Data And Fill up The List Of Markers 🚨
  //*******************************************************************
  Future<void> getMarkers() async {
    for (int i = 0; i < _garages!.length; i++) {
      AllMarkers.add(
        Marker(
            onTap: () {
              _pageController.animateToPage(i,
                  duration: Duration(milliseconds: 20), curve: Curves.easeIn);
            },
            icon: await BitmapDescriptor.fromAssetImage(
                ImageConfiguration(), 'lib/Map/images/garage3.png'),
            markerId: MarkerId('$i'),
            position: LatLng(_garages![i].lat!, _garages![i].long!)),
      );
      context.read<JsonBloc>().add(PutMarkersEvent(allMarkers: AllMarkers));
    }
  }

  Future<void> Request() async {
    String url = 'https://parkingprojectgp.herokuapp.com/api/request/add';
    final msg = jsonEncode({"garage_id": garageID});
    String token =
        "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC9wYXJraW5ncHJvamVjdGdwLmhlcm9rdWFwcC5jb21cL2FwaVwvYXV0aFwvbG9naW4iLCJpYXQiOjE2MTg2ODExODksImV4cCI6MTYyMDE0OTk4OSwibmJmIjoxNjE4NjgxMTg5LCJqdGkiOiJzZndGUUx0RUtFOHc4N09DIiwic3ViIjoiNDJhS1V5YVdMRFZPamZGTzh3T0dET3hBTXZiMiIsInBydiI6IjIzYmQ1Yzg5NDlmNjAwYWRiMzllNzAxYzQwMDg3MmRiN2E1OTc2ZjcifQ.XdLZmkDPOgy2RzlUVzJUcT6JoapJ4qhCsBjUh8xMr3o";
    http.Response response = await http.post(Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        encoding: Encoding.getByName("utf-8"),
        body: msg);

    print('response status: ${response.statusCode}');
    print('response body: ${response.body}');
    Map map = jsonDecode(response.body);

    print(map['Requestcar']['id']);
  }

  void editRequest() async {
    String url = 'https://parkingprojectgp.herokuapp.com/api/$requestId';
    final msg = jsonEncode({"garage_id": garageID});
    String token =
        "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC9wYXJraW5ncHJvamVjdGdwLmhlcm9rdWFwcC5jb21cL2FwaVwvYXV0aFwvbG9naW4iLCJpYXQiOjE2MTg2ODExODksImV4cCI6MTYyMDE0OTk4OSwibmJmIjoxNjE4NjgxMTg5LCJqdGkiOiJzZndGUUx0RUtFOHc4N09DIiwic3ViIjoiNDJhS1V5YVdMRFZPamZGTzh3T0dET3hBTXZiMiIsInBydiI6IjIzYmQ1Yzg5NDlmNjAwYWRiMzllNzAxYzQwMDg3MmRiN2E1OTc2ZjcifQ.XdLZmkDPOgy2RzlUVzJUcT6JoapJ4qhCsBjUh8xMr3o";
    http.Response response = await http.put(Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        encoding: Encoding.getByName("utf-8"),
        body: msg);

    print('response status: ${response.statusCode}');
    print('response body: ${response.body}');
    Map map = jsonDecode(response.body);

    requestId = map['Requestcar']['id'];
  }

  Future getLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    lat = position.latitude;
    long = position.longitude;
    //setState(() {});
    //context.read<JsonBloc>().add(LatLongEvent(lat, long));
  }

  @override
  void initState() {
    super.initState();
    //context.read<JsonBloc>().add(GettingDataEvent());
    getLocation();
    context.read<JsonBloc>().add(OrderDataEvent(lat, long));
    //orderData();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      key: _scaffoldKey,
      drawer: CustomDrawer(),
      //*********************************
      // 🚨 Body Of Google Maps Design 🚨
      //*********************************
      body: SafeArea(
        child: Stack(fit: StackFit.expand, children: [
          BlocConsumer<JsonBloc, JsonState>(
            listener: (context, state) {
              // TODO: implement listener
              if (state is GetComments) {
                _comments = state.allComments;
              }
            },
            buildWhen: (previous, current) {
              if (current is GetMarkersState) {
                return true;
              }
              return false;
            },
            builder: (context, state) {
              return Container(
                child: GoogleMap(
                  zoomControlsEnabled: false,
                  initialCameraPosition: CameraPosition(
                      target: LatLng(30.14254528772857, 31.324295242328564),
                      zoom: 11),
                  markers: Set.from(AllMarkers),
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
                ),
              );
            },
          ),
          Positioned(
            top: 0,
            right: 0,
            left: 0,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              width: double.infinity,
              height: getProportionateScreenHeight(244.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment(-0.02, 0.16),
                  end: Alignment(0.0, 1.0),
                  colors: [const Color(0xffffffff), const Color(0x00ffffff)],
                  stops: [0.0, 1.0],
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0x1fffffff),
                    offset: Offset(0, 2),
                    blurRadius: 34,
                  ),
                ],
              ),
              child: Column(
                children: [
                  VerticalSpacing(of: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 6),
                          alignment: Alignment.center,
                          width: getProportionateScreenWidth(233),
                          height: getProportionateScreenWidth(45),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6.0),
                            color: const Color(0xffffffff),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0x1a303030),
                                offset: Offset(3, 6),
                                blurRadius: 15,
                              ),
                            ],
                          ),
                          child: SizedBox(
                            width: double.infinity,
                            child: Text(
                              'Parking In....',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 14,
                                color: const Color(0xffbdbdbd),
                                fontWeight: FontWeight.w500,
                                height: 1.7,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ),
                        onTap: () {
                          showSearch(context: context, delegate: Search());
                        },
                      ),
                      FlatButton(
                        onPressed: () {
                          _scaffoldKey.currentState!.openDrawer();
                        },
                        child: Text(''),
                        shape: CircleBorder(
                          side: BorderSide(color: Colors.teal),
                        ),
                        minWidth: 70,
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          //***********************************************
          // 🚨 Button For Getting Your Current Location 🚨
          //***********************************************
          Positioned(
            right: 0,
            bottom: MediaQuery.of(context).size.height * 0.2 + 10,
            child: Container(
              child: FloatingActionButton(
                backgroundColor: Colors.teal,
                child: Icon(Icons.my_location),
                onPressed: () async {
                  Position position = await Geolocator.getCurrentPosition(
                      desiredAccuracy: LocationAccuracy.high);
                  AllMarkers.add(Marker(
                      markerId: MarkerId('first'),
                      position: LatLng(position.latitude, position.longitude)));
                  lat = position.latitude;
                  long = position.longitude;
                  // setState(() {});
                  // context.read<JsonBloc>().add(LatLongEvent(lat, long));
                  context
                      .read<JsonBloc>()
                      .add(PutMarkersEvent(allMarkers: AllMarkers));
                  GoToYourLocation();
                },
              ),
            ),
          ),
          //**************************************************
          // 🚨 Scrolling ListView Of Parking Places On Map 🚨
          //**************************************************
          Positioned(
            bottom: 10,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.2,
            child: Container(
              //**********************************
              // 🚨 Getting Data From Date Base 🚨
              //**********************************
              child: BlocBuilder<JsonBloc, JsonState>(
                builder: (context, state) {
                  if (state is OrderLoading) {
                    return SpinKitPumpingHeart(
                      color: Colors.teal,
                      size: 75.0,
                    );
                  }
                  if (state is OrderLoaded) {
                    _garages = state.orderData;
                    getMarkers();
                  }
                  if (state is GetComments) {
                    _comments = state.allComments;
                  }
                  return PageView.builder(
                    controller: _pageController,
                    scrollDirection: Axis.horizontal,
                    onPageChanged: (pageIndex) async {
                      lat = _garages![pageIndex].lat;
                      long = _garages![pageIndex].long;
                      AllMarkers.add(Marker(
                          rotation: 300,
                          icon: await BitmapDescriptor.fromAssetImage(
                              ImageConfiguration.empty,
                              "lib/Map/images/marker1.png"),
                          markerId: MarkerId('A'),
                          position: LatLng(lat!, long!)));

                      context
                          .read<JsonBloc>()
                          .add(PutMarkersEvent(allMarkers: AllMarkers));
                      GoToYourLocation();
                    },
                    itemCount: _garages!.length,
                    itemBuilder: (context, i) {
                      return FittedBox(
                        fit: BoxFit.fitWidth,
                        child: InkWell(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 1.0),
                            child: Container(
                              width: SizeConfig.width * 0.85,
                              child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0)),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 15.0,
                                              top: 15.0,
                                              bottom: 8.0),
                                          child: Container(
                                            width: SizeConfig.width * 0.50,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  _garages![i].name!,
                                                  style: TextStyle(
                                                    fontFamily: 'Poppins',
                                                    fontSize: 16,
                                                    color:
                                                        const Color(0xff303030),
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                ),
                                                SizedBox(height: 6),
                                                Text(
                                                  _garages![i]
                                                          .b_number
                                                          .toString() +
                                                      ' ' +
                                                      _garages![i].street! +
                                                      ', ' +
                                                      _garages![i].city!,
                                                  style: TextStyle(
                                                    fontFamily: 'Poppins',
                                                    fontSize: 14,
                                                    color:
                                                        const Color(0xff3e3e3e),
                                                    fontWeight: FontWeight.w300,
                                                  ),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        //*******************
                                        // 🚨 Share Button 🚨
                                        //*******************
                                        FlatButton(
                                          onPressed: null,
                                          child: Icon(
                                            Icons.share_outlined,
                                            color: Colors.teal,
                                          ),
                                          shape: CircleBorder(
                                              side: BorderSide(
                                                  color: Colors.grey)),
                                          color: Colors.white,
                                        )
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20.0, bottom: 10),
                                      child: Row(
                                        children: [
                                          //************************
                                          // 🚨 Directions Button 🚨
                                          //************************
                                          FlatButton.icon(
                                            onPressed: () {},
                                            icon: Icon(
                                              Icons.directions,
                                              color: Colors.white,
                                            ),
                                            label: Text('Directions'),
                                            textColor: Colors.white,
                                            color: Colors.teal,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        18.0)),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          //******************
                                          // 🚨 Call Button 🚨
                                          //******************
                                          FlatButton.icon(
                                            onPressed: () {},
                                            icon: Icon(
                                              Icons.call,
                                              color: Colors.teal,
                                            ),
                                            label: Text('call'),
                                            textColor: Colors.black,
                                            color: Colors.white,
                                            shape: RoundedRectangleBorder(
                                                side: BorderSide(
                                                    color: Colors.grey),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        18.0)),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          //******************************
                          // 🚨 When User Click On Card 🚨
                          //******************************
                          onTap: () {
                            garageID = _garages![i].id;
                            print(garageID);
                            context
                                .read<JsonBloc>()
                                .add(ShowAllCommentsEvent(_garages?[i].id));
                            showModalBottomSheet(
                              isScrollControlled: true,
                              context: context,
                              builder: (context) {
                                return BlocConsumer<JsonBloc, JsonState>(
                                  listener: (context, state) {
                                    // TODO: implement listener
                                  },
                                  builder: (context, state) {
                                    return Container(
                                      height: 500,
                                      child: DefaultTabController(
                                          length: 2,
                                          child: Scaffold(
                                            appBar: PreferredSize(
                                              preferredSize:
                                                  Size.fromHeight(35),
                                              child: AppBar(
                                                backgroundColor: Colors.white,
                                                bottom: TabBar(
                                                    //indicatorSize: TabBarIndicatorSize.label,
                                                    indicatorColor: Colors.teal,
                                                    tabs: [
                                                      Text(
                                                        'Overview',
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 15),
                                                      ),
                                                      Text('Reviews',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 15))
                                                    ]),
                                              ),
                                            ),
                                            body: TabBarView(children: [
                                              Container(
                                                height:
                                                    SizeConfig.height * 0.65,
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 10),
                                                  child: ListView(
                                                    children: [
                                                      Container(
                                                        color:
                                                            Color(0xFFAEAEAE),
                                                        height: 5,
                                                        margin: EdgeInsets.only(
                                                            left: 100,
                                                            right: 100,
                                                            top: 20,
                                                            bottom: 10),
                                                      ),
                                                      // Text(
                                                      //   _garages[i].b_number.toString() +
                                                      //       ' ' +
                                                      //       _garages[i].street +
                                                      //       ', ' +
                                                      //       _garages[i].city,
                                                      //   textAlign: TextAlign.center,
                                                      //   style: TextStyle(
                                                      //     fontFamily: 'Poppins',
                                                      //     fontSize: 14,
                                                      //     color: const Color(0xff7B7B7B),
                                                      //     fontWeight: FontWeight.w300,
                                                      //   ),
                                                      // ),
                                                      // SlideCountdownClock(
                                                      //   duration: Duration(minutes: 5),
                                                      //   slideDirection: SlideDirection.Down,
                                                      //   separator: ":",
                                                      //   textStyle: TextStyle(
                                                      //       fontSize: 20, color: Colors.red),
                                                      // ),
                                                      SizedBox(height: 10),
                                                      Container(
                                                        margin: EdgeInsets.only(
                                                            left: 100,
                                                            right: 100,
                                                            top: 5),
                                                        padding:
                                                            EdgeInsets.all(5),
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      22.0),
                                                          color: const Color(
                                                              0xffffffff),
                                                          boxShadow: [
                                                            BoxShadow(
                                                              color: const Color(
                                                                  0x29000000),
                                                              offset:
                                                                  Offset(0, 3),
                                                              blurRadius: 6,
                                                            ),
                                                          ],
                                                        ),
                                                        child: RichText(
                                                          textAlign:
                                                              TextAlign.center,
                                                          text: TextSpan(
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .grey,
                                                                  fontSize: 15),
                                                              text:
                                                                  'Free spots: ',
                                                              children: [
                                                                TextSpan(
                                                                    text: '50',
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .teal,
                                                                        fontSize:
                                                                            15)),
                                                                TextSpan(
                                                                    text:
                                                                        ' / 100',
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .grey,
                                                                        fontSize:
                                                                            15))
                                                              ]),
                                                        ),
                                                      ),
                                                      SizedBox(height: 10),
                                                      Container(
                                                        height: 300,
                                                        child: ListView.builder(
                                                          physics:
                                                              BouncingScrollPhysics(),
                                                          itemCount: 3,
                                                          itemBuilder: (context,
                                                              floors) {
                                                            floors++;
                                                            return Column(
                                                              children: [
                                                                SizedBox(
                                                                  height: 10,
                                                                ),
                                                                Container(
                                                                    alignment:
                                                                        Alignment
                                                                            .centerLeft,
                                                                    child: Text(
                                                                      'Floor ' +
                                                                          '$floors',
                                                                      textAlign:
                                                                          TextAlign
                                                                              .right,
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              17),
                                                                    )),
                                                                SizedBox(
                                                                  height: 10,
                                                                ),
                                                                Container(
                                                                  height: 120,
                                                                  child: ListView
                                                                      .builder(
                                                                    scrollDirection:
                                                                        Axis.horizontal,
                                                                    itemCount:
                                                                        3,
                                                                    itemBuilder:
                                                                        (context,
                                                                            pics) {
                                                                      return Row(
                                                                        children: [
                                                                          Image
                                                                              .network(
                                                                            'https://st3.depositphotos.com/1177973/13201/i/1600/depositphotos_132013332-stock-photo-underground-parking-at-shopping-mall.jpg',
                                                                            width:
                                                                                204,
                                                                            fit:
                                                                                BoxFit.cover,
                                                                          ),
                                                                          SizedBox(
                                                                            width:
                                                                                8,
                                                                          ),
                                                                        ],
                                                                      );
                                                                      //return Card(color: Colors.green,child: Container(width: 150,height: 100,child: Text('data'),),);
                                                                    },
                                                                  ),
                                                                ),
                                                              ],
                                                            );
                                                          },
                                                        ),
                                                      ),
                                                      Container(
                                                        margin: EdgeInsets.only(
                                                            top: 6, bottom: 6),
                                                        child: RichText(
                                                          textAlign:
                                                              TextAlign.center,
                                                          text: TextSpan(
                                                              children: [
                                                                TextSpan(
                                                                    text:
                                                                        'Price ',
                                                                    style:
                                                                        TextStyle(
                                                                      fontFamily:
                                                                          'Poppins',
                                                                      fontSize:
                                                                          16,
                                                                      color: const Color(
                                                                          0xff828181),
                                                                      letterSpacing:
                                                                          0.24,
                                                                      height:
                                                                          1.3333333333333333,
                                                                    )),
                                                                TextSpan(
                                                                    children: [
                                                                      TextSpan(
                                                                          text:
                                                                              '/ hour: ',
                                                                          style:
                                                                              TextStyle(
                                                                            fontFamily:
                                                                                'Poppins',
                                                                            fontSize:
                                                                                12,
                                                                            color:
                                                                                const Color(0xff828181),
                                                                            letterSpacing:
                                                                                0.24,
                                                                            height:
                                                                                1.3333333333333333,
                                                                          ))
                                                                    ]),
                                                                TextSpan(
                                                                    text: _garages![i]
                                                                            .price
                                                                            .toString() +
                                                                        'EG',
                                                                    style:
                                                                        TextStyle(
                                                                      fontFamily:
                                                                          'Poppins',
                                                                      fontSize:
                                                                          12,
                                                                      color: Colors
                                                                          .teal,
                                                                      letterSpacing:
                                                                          0.24,
                                                                      height:
                                                                          1.3333333333333333,
                                                                    ))
                                                              ]),
                                                        ),
                                                      ),
                                                      //******************
                                                      //🚨Request Button🚨
                                                      //******************
                                                      Container(
                                                        margin: EdgeInsets.only(
                                                            right: 80,
                                                            left: 80),
                                                        child: MaterialButton(
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context);
                                                            if (bool == 0) {
                                                              bool = 1;
                                                              button =
                                                                  "Request";
                                                              context
                                                                  .read<
                                                                      JsonBloc>()
                                                                  .add(BoolButtonEvent(
                                                                      bool,
                                                                      button));
                                                              Request();
                                                              // setState(() {});
                                                            } //else if (bool == 1) {
                                                            //   bool = 0;
                                                            //   button = "Cancel Request";
                                                            //   context.read<JsonBloc>().add(BoolButtonEvent(bool, button));
                                                            //   editRequest();
                                                            //   // setState(() {});
                                                            // }
                                                            //Timer.periodic(Duration(seconds: 1), (time) {setState(() {if (counter > 0) {counter--;print(counter);}});});
                                                          },
                                                          color: Colors.teal,
                                                          minWidth: 12,
                                                          child: Text(
                                                            '$button',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          18)),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Column(
                                                children: [
                                                  Container(
                                                    alignment:
                                                        Alignment.centerRight,
                                                    child: TextButton(
                                                        onPressed: () {
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        Review(
                                                                  garageId:
                                                                      garageID,
                                                                ),
                                                              ));
                                                        },
                                                        child: Text(
                                                            'Write a review',
                                                            style: TextStyle(
                                                                fontSize: 17))),
                                                  ),
                                                  Container(
                                                    height:
                                                        SizeConfig.height * 0.5,
                                                    child: ListView.builder(
                                                      itemCount:
                                                          _comments?.length ??
                                                              0,
                                                      itemBuilder:
                                                          (context, index) {
                                                        return Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  left: 20),
                                                          child: Column(
                                                            children: [
                                                              Row(
                                                                children: [
                                                                  CircleAvatar(
                                                                    backgroundColor:
                                                                        Colors
                                                                            .teal,
                                                                    child: Text(_comments![index].first_name![0]+_comments![index].last_name![0]),
                                                                  ),
                                                                  //${_comments[0]}
                                                                  SizedBox(
                                                                    width: 20,
                                                                  ),
                                                                  RichText(
                                                                      text: TextSpan(
                                                                          children: [
                                                                        TextSpan(
                                                                            text:
                                                                                _comments?[index].first_name,
                                                                            style: TextStyle(color: Colors.black, fontSize: 17,
                                                                            fontWeight: FontWeight.bold)),
                                                                        TextSpan(
                                                                            text:
                                                                                ' '),
                                                                        TextSpan(
                                                                            text:
                                                                                _comments?[index].last_name,
                                                                            style:
                                                                                TextStyle(color: Colors.black, fontSize: 17,
                                                                                fontWeight: FontWeight.bold))
                                                                      ]))
                                                                ],
                                                              ),
                                                              Container(
                                                                margin: EdgeInsets
                                                                    .only(
                                                                        left: 5,
                                                                        bottom:
                                                                            10,
                                                                        top:
                                                                            20),
                                                                alignment: Alignment
                                                                    .centerLeft,
                                                                child: RatingBar
                                                                    .builder(
                                                                  updateOnDrag:
                                                                      false,
                                                                  initialRating:
                                                                      3,
                                                                  itemSize:
                                                                      20.0,
                                                                  minRating: 1,
                                                                  tapOnlyMode:
                                                                      false,
                                                                  ignoreGestures:
                                                                      true,
                                                                  unratedColor:
                                                                      Colors
                                                                          .grey
                                                                          .shade400,
                                                                  direction: Axis
                                                                      .horizontal,
                                                                  allowHalfRating:
                                                                      true,
                                                                  itemCount: 5,
                                                                  itemPadding: EdgeInsets
                                                                      .symmetric(
                                                                          horizontal:
                                                                              0),
                                                                  itemBuilder:
                                                                      (context,
                                                                              _) =>
                                                                          Icon(
                                                                    Icons.star,
                                                                    color: Colors
                                                                        .orange,
                                                                  ),
                                                                  onRatingUpdate:
                                                                      (rating) {
                                                                    print(
                                                                        rating);
                                                                  },
                                                                ),
                                                              ),
                                                              Container(alignment: Alignment.centerLeft,
                                                                margin: EdgeInsets
                                                                    .only(
                                                                        left:
                                                                            5),
                                                                child: Text(
                                                                  _comments![index].comment!,
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          17),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 40,
                                                              )
                                                            ],
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  )
                                                ],
                                              )
                                            ]),
                                          )),
                                    );
                                  },
                                );
                              },
                            );
                          },
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ]),
      ),
    );
  }

  //********************************************************
  // 🚨 Function That Update New Camera Position For Maps 🚨
  //********************************************************
  Future<void> GoToYourLocation() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(lat!, long!), zoom: 11)));
  }
}

//******************************
// 🚨 Class for Search Method 🚨
//******************************
class Search extends SearchDelegate {
  String? searchValue;

  Search({this.searchValue});

  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
        icon: Icon(Icons.close),
        onPressed: () {
          searchValue = query;
          print(searchValue);
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return InkWell(onTap: () => print('my names ahmed'), child: Text(''));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Text('');
  }
}
