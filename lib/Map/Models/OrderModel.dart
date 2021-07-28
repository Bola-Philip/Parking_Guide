class OrderCards {
  int? id;
  String? name;
  int? price;
  double? lat;
  double? long;
  String? city;
  String? street;
  int? b_number;
  double? distance;

  OrderCards(
      {this.id, this.name, this.price, this.lat, this.long, this.distance, this.city, this.street, this.b_number,});

  factory OrderCards.fromJson(Map<String, dynamic> json) {
    return OrderCards(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      lat: double.parse(json['lat']),
      long: double.parse(json['long']),
      city: json['city'],
      street: json['street'],
      b_number: json['b_number'],
      distance: json['distance'],
    );
  }
}
