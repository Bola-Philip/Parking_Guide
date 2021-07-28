import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parking_guide/Map/Json/Json.dart';
import 'package:parking_guide/Map/Models/ShowAllRequests.dart';
import 'package:parking_guide/Map/bloc/requests_info_bloc.dart';

class MyAllRequests extends StatefulWidget {
  final int? garage_id;

  const MyAllRequests({Key? key, this.garage_id}) : super(key: key);

  @override
  _MyAllRequestsState createState() => _MyAllRequestsState();
}

class _MyAllRequestsState extends State<MyAllRequests> {
  int ?garage_id;
  _MyAllRequestsState();

  List<ShowRequests>? ss;
  @override
  Widget build(BuildContext context) {
    FetchData fetchData = FetchData();
    return Scaffold(
      body: BlocProvider(
        create: (context) =>
        RequestsInfoBloc(fetchData)
          ..add(ShowRequestsEvent(widget.garage_id)),
        child: BlocBuilder<RequestsInfoBloc, RequestsInfoState>(
          builder: (context, state) {
            if (state is ShowInitial) {}
            else if (state is ShowLoading) {}
            else if (state is ShowLoaded) {
              ss = state.myRequests;
            }
            return Container(
              child: ListView.builder(
                itemCount: ss?.length,
                itemBuilder: (context, index) {
                  return Container(child: Text(ss![index].user_id??''));
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
