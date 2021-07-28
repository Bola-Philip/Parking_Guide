class GettingData{
  int? id;
  String? city;
  String? street;
  int? b_number;
  int? capacity;
  String? name;
  int? price;
  double? lat;
  double? long;
  int? is_private;
  String? owner_id;

  GettingData({
    this.id,
    this.city,
    this.street,
    this.b_number,
    this.capacity,
    this.name,
    this.price,
    this.lat,
    this.long,
    this.is_private,
    this.owner_id
  });

  factory GettingData.fromJson(Map<String, dynamic> json){
    return GettingData(
        id: json['id'],
        city: json['city'],
        street: json['street'],
        b_number: json['b_number'],
        capacity: json['capacity'],
        name: json['name'],
        price:json['price'],
        lat: double.parse(json['lat']),
        long: double.parse(json['long']),
        is_private: json['is_private'],
        owner_id: json['owner_id']
    );
  }
}