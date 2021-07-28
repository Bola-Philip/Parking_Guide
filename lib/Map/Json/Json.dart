import 'package:parking_guide/Map/Models/GetDataModel.dart';
import 'package:parking_guide/Map/Models/OrderModel.dart';
import 'package:parking_guide/Map/Models/LastRequest.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:parking_guide/Map/Models/ShowAllRequests.dart';

class FetchData {

  Future<List<GettingData>?> GetData() async {
    String url = 'https://parkingprojectgp.herokuapp.com/api/garages';
    var response = await http.get(Uri.parse(url));
    final responseBody = jsonDecode(response.body);
    List<GettingData>? fetch = responseBody['data'].map<GettingData>((json) =>
        GettingData.fromJson(json)).toList();
    return fetch;
  }


  Future<List<OrderCards>?> orderData(double? lat, double? long) async {
    String url = 'https://parkingprojectgp.herokuapp.com/api/nearest_garage';
    String token =
        "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC9wYXJraW5ncHJvamVjdGdwLmhlcm9rdWFwcC5jb21cL2FwaVwvYXV0aFwvbG9naW4iLCJpYXQiOjE2MTg2ODExODksImV4cCI6MTYyMDE0OTk4OSwibmJmIjoxNjE4NjgxMTg5LCJqdGkiOiJzZndGUUx0RUtFOHc4N09DIiwic3ViIjoiNDJhS1V5YVdMRFZPamZGTzh3T0dET3hBTXZiMiIsInBydiI6IjIzYmQ1Yzg5NDlmNjAwYWRiMzllNzAxYzQwMDg3MmRiN2E1OTc2ZjcifQ.XdLZmkDPOgy2RzlUVzJUcT6JoapJ4qhCsBjUh8xMr3o";
    http.Response response = await http.post(Uri.parse(url), headers: {
      'Accept': 'appli'
          '.cation/json',
      'Authorization': 'Bearer $token',
    }, body: {
      "lat": lat.toString(),
      "long": long.toString()
    });
    var responseBody = jsonDecode(response.body);
    List<OrderCards>? fetchOrder = responseBody['locations'].map<OrderCards>((
        json) => OrderCards.fromJson(json)).toList();
    return fetchOrder;
  }

  Future<Requests> requestData() async {
    String url = 'https://parkingprojectgp.herokuapp.com/api/request/showLastActive';
    String token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOi8vcGFya2luZ3Byb2plY3RncC5oZXJva3VhcHAuY29tL2FwaS9hdXRoL2xvZ2luIiwiaWF0IjoxNjI2MTE2MzcxLCJleHAiOjE2Mjc1ODUxNzEsIm5iZiI6MTYyNjExNjM3MSwianRpIjoiM29VY0ZDMTZCd2tOSWVIdCIsInN1YiI6IjQyYUtVeWFXTERWT2pmRk84d09HRE94QU12YjIiLCJwcnYiOiIyM2JkNWM4OTQ5ZjYwMGFkYjM5ZTcwMWM0MDA4NzJkYjdhNTk3NmY3In0.IaBbM2_h_18s3-AeXU4z64k5jfSXi8hGYdvYgp4IqZw";
    var response = await http.get(
        Uri.parse(url), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'});
    final responseBody = jsonDecode(response.body);
    Requests req = Requests.fromJson(responseBody['data']);
    return req;
  }

  Future<List<ShowRequests>> showAllRequests(int? garage_id) async {
    String url = 'https://parkingprojectgp.herokuapp.com/api/nearest_garage';
    String token =
        "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC9wYXJraW5ncHJvamVjdGdwLmhlcm9rdWFwcC5jb21cL2FwaVwvYXV0aFwvbG9naW4iLCJpYXQiOjE2MTg2ODExODksImV4cCI6MTYyMDE0OTk4OSwibmJmIjoxNjE4NjgxMTg5LCJqdGkiOiJzZndGUUx0RUtFOHc4N09DIiwic3ViIjoiNDJhS1V5YVdMRFZPamZGTzh3T0dET3hBTXZiMiIsInBydiI6IjIzYmQ1Yzg5NDlmNjAwYWRiMzllNzAxYzQwMDg3MmRiN2E1OTc2ZjcifQ.XdLZmkDPOgy2RzlUVzJUcT6JoapJ4qhCsBjUh8xMr3o";
    http.Response response = await http.post(Uri.parse(url), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    }, body: {
      "garage_id": garage_id,
    });
    final responseBody = jsonDecode(response.body);
    List<ShowRequests> show =responseBody['data'].map<ShowRequests>((json) => ShowRequests.fromJson(json)).toList();
    return show;
  }


}