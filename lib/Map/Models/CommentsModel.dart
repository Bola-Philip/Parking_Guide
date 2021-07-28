class Comments {
  // int? id;

  int? id;
  String? user_id;
  int? garage_id;
  String? comment;
  String? first_name;
  String? last_name;

  Comments({this.id, this.user_id, this.garage_id, this.comment, this.first_name,
    this.last_name});






  factory Comments.fromJson(Map<String, dynamic> json){
    return Comments(
        id: json['id'],
        user_id: json['user_id'],
        garage_id: json['garage_id'],
        comment: json['comment'],
        first_name: json['user']['first_name'],
        last_name: json['user']['last_name']);
  }
}
