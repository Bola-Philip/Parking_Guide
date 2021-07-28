part of 'json_bloc.dart';

@immutable
abstract class JsonState {}

class JsonInitial extends JsonState {}

class JsonLoading extends JsonState {}

class JsonLoaded extends JsonState {
  final List<GettingData>? jsonData;
  JsonLoaded(this.jsonData);
}

class JsonError extends JsonState {
  final String message;
  JsonError(this.message);
}

class OrderInitial extends JsonState {}

class OrderLoading extends JsonState {}

class OrderLoaded extends JsonState {
  final List<OrderCards>? orderData;
  OrderLoaded(this.orderData);
}


class GetMarkersState extends JsonState {
  final List<Marker>? allMarkers;

  GetMarkersState(this.allMarkers);
}

class BoolButton extends JsonState{
  final int bool;
  final String button;

  BoolButton(this.bool, this.button);
}

class GetComments extends JsonState {
  final List<Comments>? allComments;

  GetComments(this.allComments);
}
class ShowAllComments extends JsonEvent{
  final int? garageId;

  ShowAllComments(this.garageId);
}