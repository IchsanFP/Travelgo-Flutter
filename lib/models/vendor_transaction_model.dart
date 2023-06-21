class VendorTransaction {
  int id;
  String travel_packages_id;
  String users_id;
  String transaction_total;
  String transaction_status;

  VendorTransaction(
      {required this.id,
      required this.travel_packages_id,
      required this.users_id,
      required this.transaction_total,
      required this.transaction_status});
  
  factory VendorTransaction.fromJson(Map<String, dynamic> json) {
    return VendorTransaction(
      id: json['id'],
      travel_packages_id: json['travel_packages_id'].toString(),
      users_id: json['users_id'].toString(),
      transaction_total: json['transaction_total'].toString(),
      transaction_status: json['transaction_status']
    );
  }
}

class VendorTransactionDetail {
  int id;
  String transactions_id;
  String name;
  String nik_ktp;

  VendorTransactionDetail({
    required this.id,
    required this.transactions_id,
    required this.name,
    required this.nik_ktp
  });

  factory VendorTransactionDetail.fromJson(Map<String, dynamic> json) => VendorTransactionDetail(
        id: json["id"],
        transactions_id: json["transactions_id"].toString(),
        name: json["name"],
        nik_ktp: json["nik_ktp"].toString(),
    );
}
