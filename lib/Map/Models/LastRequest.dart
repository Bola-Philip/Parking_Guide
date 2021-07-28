class Requests {
  int? user_id;
  int? garage_id;
  String? time_start;
  String? time_end;
  int? status;
  int? id;
  String? name;
  String? street;
  String? city;
  int? b_number;
  int? price;
  double? lat;
  double? long;
  int? is_private;
  int? has_system;
  String? owner_id;

  Requests({this.user_id,
      this.garage_id,
      this.time_start,
      this.time_end,
      this.status,
      this.id,
      this.name,
      this.street,
      this.city,
      this.b_number,
      this.price,
      this.lat,
      this.long,
      this.is_private,
      this.has_system,
      this.owner_id});


  factory Requests.fromJson(Map<String, dynamic> json){
    return Requests(
        user_id: json['id'],
        garage_id: json['garage_id'],
        time_start: json['time_start'],
        time_end: json['time_end'],
        status: json['status'],
        id: json['id'],
        name: json['name'],
        street: json['street'],
        city: json['city'],
        b_number: json['b_number'],
        price: json['price'],
        lat: double.parse(json['lat']),
        long: double.parse(json['long']),
        is_private: json['is_private'],
        has_system: json['has_system'],
        owner_id: json['owner_id']);
  }
}