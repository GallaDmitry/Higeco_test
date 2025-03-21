class PlantModel {
  final String name;
  final int id;
  final String? description;
  final String? note;
  final String? timezone;
  final String? lat;
  final String? lng;
  final List? tags;
  final int? nodeId;
  final String? address;
  PlantModel({
    required this.name,
    required this.id,
    this.description,
    this.note,
    this.timezone,
    this.lat,
    this.lng,
    this.tags,
    this.nodeId,
    this.address,
  });
  factory PlantModel.fromJson(Map<String, dynamic> json) {
    return PlantModel(
      name: json['name'],
      id: json['id'],
      description: json['description'],
      note: json['note'],
      timezone: json['timezone'],
      lat: json['lat'],
      lng: json['lng'],
      tags: json['tags'],
      nodeId: json['nodeId'],
      address: json['address'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'id': id,
      'description': description,
      'note': note,
      'timezone': timezone,
      'lat': lat,
      'lng': lng,
      'tags': tags,
      'nodeId': nodeId,
      'address': address,
    };
  }
}