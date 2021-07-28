class ShowRequests {
  String? user_id;
  int? garage_id;
  String? time_start;
  String? time_end;
  int? status;

  ShowRequests({this.user_id, this.garage_id, this.time_start, this.time_end,
      this.status});


  factory ShowRequests.fromJson(Map<String, dynamic> json) {
    return ShowRequests(
      user_id: json['user_id'],
      garage_id: json['garage_id'],
      time_start: json['time_start'],
      time_end: json['time_end'],
      status: json['status'],
    );
  }
}
