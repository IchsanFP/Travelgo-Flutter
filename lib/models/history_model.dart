// To parse this JSON data, do
//
//     final history = historyFromJson(jsonString);

import 'dart:convert';

History historyFromJson(String str) => History.fromJson(json.decode(str));

String historyToJson(History data) => json.encode(data.toJson());

class History {
    int id;
    int travelPackagesId;
    int usersId;
    int transactionTotal;
    String transactionStatus;
    dynamic paymentProof;
    dynamic deletedAt;
    DateTime createdAt;
    DateTime updatedAt;

    History({
        required this.id,
        required this.travelPackagesId,
        required this.usersId,
        required this.transactionTotal,
        required this.transactionStatus,
        this.paymentProof,
        this.deletedAt,
        required this.createdAt,
        required this.updatedAt,
    });

    factory History.fromJson(Map<String, dynamic> json) => History(
        id: json["id"],
        travelPackagesId: json["travel_packages_id"],
        usersId: json["users_id"],
        transactionTotal: json["transaction_total"],
        transactionStatus: json["transaction_status"],
        paymentProof: json["payment_proof"],
        deletedAt: json["deleted_at"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "travel_packages_id": travelPackagesId,
        "users_id": usersId,
        "transaction_total": transactionTotal,
        "transaction_status": transactionStatus,
        "payment_proof": paymentProof,
        "deleted_at": deletedAt,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}
