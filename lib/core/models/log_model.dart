class LogModel {
  final int id;
  final String name;
  final int? samplingTime;
  final String? tag;

  LogModel({
    required this.id,
    required this.name,
    this.samplingTime,
    this.tag,
  });

  factory LogModel.fromJson(Map<String, dynamic> json) {
    return LogModel(
      id: json['id'],
      name: json['name'],
      samplingTime: json['samplingTime'],
      tag: json['tag'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'samplingTime': samplingTime,
      'tag': tag,
    };
  }
}
