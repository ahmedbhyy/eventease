

class OrderModel {
  final String adress;
  final String phone;
  String id;
  final DateTime orderdate;

  final String status;
  final double total;

  final Map productlist;

  OrderModel({
    required this.adress,
    required this.orderdate,
    required this.total,
    required this.phone,

    required this.status,

    required this.productlist,
    required this.id,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      adress: json['adress'] ?? 'No adress found',
      orderdate: json['date'].toDate() ?? DateTime.now(),
      total: (json["total"] ?? 0.0).toDouble(),
      productlist: json['orderItems'] ?? {},
      id: json["id"] ?? "",
      phone: json["phone"] ?? "",
      status: json["status"] ?? "En cours",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'adress': adress,

      'date': orderdate,

      'total': total,
      'phone': phone,

      'id': id,
      'status': status,
      'ordersItems': productlist,
    };
  }
}
