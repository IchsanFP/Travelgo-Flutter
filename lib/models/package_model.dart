// To parse this JSON data, do
//
//     final package = packageFromJson(jsonString);

import 'dart:convert';

Package packageFromJson(String str) => Package.fromJson(json.decode(str));

String packageToJson(Package data) => json.encode(data.toJson());

class Package {
    int id;
    String title;
    String location;
    String about;
    String featuredEvent;
    String language;
    String foods;
    DateTime departureDate;
    String duration;
    String type;
    int price;
    int vendorId;
    List<Gallery> galleries;

    Package({
        required this.id,
        required this.title,
        required this.location,
        required this.about,
        required this.featuredEvent,
        required this.language,
        required this.foods,
        required this.departureDate,
        required this.duration,
        required this.type,
        required this.price,
        required this.vendorId,
        required this.galleries,
    });

    factory Package.fromJson(Map<String, dynamic> json) => Package(
        id: json["id"],
        title: json["title"],
        location: json["location"],
        about: json["about"],
        featuredEvent: json["featured_event"],
        language: json["language"],
        foods: json["foods"],
        departureDate: DateTime.parse(json["departure_date"]),
        duration: json["duration"],
        type: json["type"],
        price: json["price"],
        vendorId: json["vendor_id"],
        galleries: json["galleries"] == null? [] : List<Gallery>.from(json["galleries"].map((x) => Gallery.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "location": location,
        "about": about,
        "featured_event": featuredEvent,
        "language": language,
        "foods": foods,
        "departure_date": "${departureDate.year.toString().padLeft(4, '0')}-${departureDate.month.toString().padLeft(2, '0')}-${departureDate.day.toString().padLeft(2, '0')}",
        "duration": duration,
        "type": type,
        "price": price,
        "vendor_id": vendorId,
        "galleries": List<dynamic>.from(galleries.map((x) => x.toJson())),
    };
}

class Gallery {
    int id;
    int travelPackagesId;
    String image;
    dynamic deletedAt;
    DateTime createdAt;
    DateTime updatedAt;

    Gallery({
        required this.id,
        required this.travelPackagesId,
        required this.image,
        this.deletedAt,
        required this.createdAt,
        required this.updatedAt,
    });

    factory Gallery.fromJson(Map<String, dynamic> json) => Gallery(
        id: json["id"],
        travelPackagesId: json["travel_packages_id"],
        image: json["image"],
        deletedAt: json["deleted_at"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "travel_packages_id": travelPackagesId,
        "image": image,
        "deleted_at": deletedAt,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}
