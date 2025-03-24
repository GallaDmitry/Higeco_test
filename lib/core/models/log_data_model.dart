//{log: {}, items: [], data: []}

class LogDataModel {
  LogDataModel({
    required this.log,
    required this.items,
    required this.data,
  });

  final Map<String, dynamic> log;
  final List<dynamic> items;
  final List<dynamic> data;

  factory LogDataModel.fromJson(Map<String, dynamic> json) => LogDataModel(
        log: json["log"],
        items: List<dynamic>.from(json["items"].map((x) => x)),
        data: List<dynamic>.from(json["data"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "log": log,
        "items": List<dynamic>.from(items.map((x) => x)),
        "data": List<dynamic>.from(data.map((x) => x)),
      };
}