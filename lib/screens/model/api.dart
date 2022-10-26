// To parse this JSON data, do
//
//     final welcome = welcomeFromMap(jsonString);

import 'dart:convert';

Welcome welcomeFromMap(String str) => Welcome.fromMap(json.decode(str));

String welcomeToMap(Welcome data) => json.encode(data.toMap());

class Welcome {
    Welcome({
        required this.id,
        required this.url,
        required this.width,
        required this.height,
    });

    String id;
    String url;
    int width;
    int height;

    factory Welcome.fromMap(Map<String, dynamic> json) => Welcome(
        id: json["id"],
        url: json["url"],
        width: json["width"],
        height: json["height"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "url": url,
        "width": width,
        "height": height,
    };
}
