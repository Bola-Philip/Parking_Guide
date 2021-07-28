part of 'json_bloc.dart';

@immutable
abstract class JsonEvent {}

class GettingDataEvent extends JsonEvent{}
class OrderDataEvent extends JsonEvent{
    final double? lat;
    final double? long;
  OrderDataEvent(this.lat, this.long);
}

class PutMarkersEvent extends JsonEvent{
  final List<Marker>? allMarkers;

  PutMarkersEvent({this.allMarkers});
}

class BoolButtonEvent extends JsonEvent{
  final int bool;
  final String button;

  BoolButtonEvent(this.bool, this.button);
}

class ShowAllCommentsEvent extends JsonEvent{
  final int? garageId;
  ShowAllCommentsEvent(this.garageId);
}