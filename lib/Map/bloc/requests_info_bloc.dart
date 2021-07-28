import 'dart:async';
import 'package:parking_guide/Map/Json/Json.dart';
import 'package:parking_guide/Map/Models/LastRequest.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:parking_guide/Map/Models/ShowAllRequests.dart';

part 'requests_info_event.dart';
part 'requests_info_state.dart';

class RequestsInfoBloc extends Bloc<RequestsInfoEvent, RequestsInfoState> {
  FetchData fetchData ;
  RequestsInfoBloc(this.fetchData) : super(RequestsInfoInitial());

  @override
  Stream<RequestsInfoState> mapEventToState(
    RequestsInfoEvent event,
  ) async* {
    if (event is ClickedRequestEvent){
      yield RequestsInfoInitial();
      yield RequestsInfoLoading();
        Requests? RequestList = await fetchData.requestData();
        yield RequestsInfoLoaded(RequestList);
    }

    if (event is ShowRequestsEvent){
      yield ShowInitial();
      yield ShowLoading();
        List<ShowRequests> RequestList = await fetchData.showAllRequests(event.garage_id);
        yield ShowLoaded(RequestList);
    }
  }
}
