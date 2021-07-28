part of 'requests_info_bloc.dart';

@immutable
abstract class RequestsInfoEvent {}
class ClickedRequestEvent extends RequestsInfoEvent{}
class ShowRequestsEvent extends RequestsInfoEvent{
  int ?garage_id;

  ShowRequestsEvent(this.garage_id);
}
