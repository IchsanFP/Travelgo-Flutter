class TransactionDetail {
  int id;
  String transactions_id;
  String name;
  String nik_ktp;

  TransactionDetail({
    required this.id,
    required this.transactions_id,
    required this.name,
    required this.nik_ktp
  });

  factory TransactionDetail.fromJson(Map<String, dynamic> json) => TransactionDetail(
        id: json['detailTransaction']["id"],
        transactions_id: json['detailTransaction']["transactions_id"],
        name: json['detailTransaction']["name"],
        nik_ktp: json['detailTransaction']["nik_ktp"],
    );
}