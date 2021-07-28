import 'dart:async';
import 'package:parking_guide/Map/Json/Comment.dart';
import 'package:parking_guide/Map/Json/Json.dart';
import 'package:parking_guide/Map/Models/CommentsModel.dart';
import 'package:parking_guide/Map/Models/GetDataModel.dart';
import 'package:parking_guide/Map/Models/OrderModel.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';

part 'json_event.dart';
part 'json_state.dart';

class JsonBloc extends Bloc<JsonEvent, JsonState> {
  final FetchData data;
  final RequestJson commentData;
  JsonBloc(this.data,this.commentData) : super(JsonInitial());

  @override
  Stream<JsonState> mapEventToState(JsonEvent event,) async* {
    // TODO: implement mapEventToState
    if (event is GettingDataEvent){
      yield JsonInitial();
      yield JsonLoading();
      // try{
      final repository = await data.GetData();
        yield JsonLoaded(repository);
      // }catch(e){
      //   print(e);
      //   yield JsonError(e.toString());
      // }
    }
    if(event is PutMarkersEvent){
      yield GetMarkersState(event.allMarkers);
    }

    if (event is OrderDataEvent){
      yield OrderInitial();
      yield OrderLoading();
      final repository = await data.orderData(event.lat, event.long);
      yield OrderLoaded(repository);
    }



    if (event is BoolButtonEvent){
      yield BoolButton(event.bool,event.button);
    }
    if (event is ShowAllCommentsEvent){
      final repositoryComments = await commentData.getComments(event.garageId);
      yield GetComments(repositoryComments);
      // yield GetComments(repositoryComments);
    }
  }
}
