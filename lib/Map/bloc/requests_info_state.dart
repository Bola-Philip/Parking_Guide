part of 'requests_info_bloc.dart';

@immutable
abstract class RequestsInfoState {}

class RequestsInfoInitial extends RequestsInfoState {}
class RequestsInfoLoading extends RequestsInfoState {}
class RequestsInfoLoaded extends RequestsInfoState {
  final Requests RequestList;

  RequestsInfoLoaded(this.RequestList);
}
class error extends RequestsInfoState{
  final String message;

  error(this.message);
}

class ShowInitial extends RequestsInfoState {}
class ShowLoading extends RequestsInfoState {}
class ShowLoaded extends RequestsInfoState{
  List<ShowRequests> ?myRequests;

  ShowLoaded(this.myRequests);
}
