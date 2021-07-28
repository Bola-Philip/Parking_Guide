import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:parking_guide/Map/Models/CommentsModel.dart';

class RequestJson {

  Future<List<Comments>>getComments(int ?id)async{
    String url='https://parkingprojectgp.herokuapp.com/api/commentindex/$id';
    String token = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOi8vMTI3LjAuMC4xOjgwMDAvYXBpL2F1dGgvbG9naW4iLCJpYXQiOjE2MjU3OTM2NzgsImV4cCI6MTYyNzI2MjQ3OCwibmJmIjoxNjI1NzkzNjc4LCJqdGkiOiJmZjgzSWtZMWxrRE1PcE01Iiwic3ViIjoiNDJhS1V5YVdMRFZPamZGTzh3T0dET3hBTXZiMiIsInBydiI6IjIzYmQ1Yzg5NDlmNjAwYWRiMzllNzAxYzQwMDg3MmRiN2E1OTc2ZjcifQ.Ux-3se9XtYte0f8lxo-EyCQFG5BB360ufk3FLLWYY_Y';
    http.Response response= await http.get(Uri.parse(url),
        headers:{
          'Accept':'Application/json',
          'Authorization':"Bearer $token"
        });
    print('response status: ${response.body}');
    final responseBody = jsonDecode(response.body);
      List<Comments> getAllComments = responseBody.map<Comments>((
          json) => Comments.fromJson(json)).toList();

    return getAllComments;
  }

  Future addComment(int? garage_id, String? comment) async {
    String url = 'https://parkingprojectgp.herokuapp.com/api/nearest_garage';
    String token =
        "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC9wYXJraW5ncHJvamVjdGdwLmhlcm9rdWFwcC5jb21cL2FwaVwvYXV0aFwvbG9naW4iLCJpYXQiOjE2MTg2ODExODksImV4cCI6MTYyMDE0OTk4OSwibmJmIjoxNjE4NjgxMTg5LCJqdGkiOiJzZndGUUx0RUtFOHc4N09DIiwic3ViIjoiNDJhS1V5YVdMRFZPamZGTzh3T0dET3hBTXZiMiIsInBydiI6IjIzYmQ1Yzg5NDlmNjAwYWRiMzllNzAxYzQwMDg3MmRiN2E1OTc2ZjcifQ.XdLZmkDPOgy2RzlUVzJUcT6JoapJ4qhCsBjUh8xMr3o";
    http.Response response = await http.post(Uri.parse(url), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    }, body: {
      "garage_id": garage_id,
      "comment": comment
    });
    print('///////////////////');
    var body= jsonDecode(response.body);
    print('status code = $body');
  }

  Future editComment(int? garage_id, String? comment) async {
    String url = 'https://parkingprojectgp.herokuapp.com/api/nearest_garage';
    String token =
        "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC9wYXJraW5ncHJvamVjdGdwLmhlcm9rdWFwcC5jb21cL2FwaVwvYXV0aFwvbG9naW4iLCJpYXQiOjE2MTg2ODExODksImV4cCI6MTYyMDE0OTk4OSwibmJmIjoxNjE4NjgxMTg5LCJqdGkiOiJzZndGUUx0RUtFOHc4N09DIiwic3ViIjoiNDJhS1V5YVdMRFZPamZGTzh3T0dET3hBTXZiMiIsInBydiI6IjIzYmQ1Yzg5NDlmNjAwYWRiMzllNzAxYzQwMDg3MmRiN2E1OTc2ZjcifQ.XdLZmkDPOgy2RzlUVzJUcT6JoapJ4qhCsBjUh8xMr3o";
    http.Response response = await http.post(Uri.parse(url), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    }, body: {
      "comment": comment
    });
  }
}