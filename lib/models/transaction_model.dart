class Transaction {
  int id;
  String travel_packages_id;
  String users_id;
  String transaction_total;
  String transaction_status;

  Transaction(
      {required this.id,
      required this.travel_packages_id,
      required this.users_id,
      required this.transaction_total,
      required this.transaction_status});
  
  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['transaction']['id'],
      travel_packages_id: json['transaction']['travel_packages_id'],
      users_id: json['transaction']['users_id'],
      transaction_total: json['transaction']['transaction_total'],
      transaction_status: json['transaction']['transaction_status']
    );
  }
}
