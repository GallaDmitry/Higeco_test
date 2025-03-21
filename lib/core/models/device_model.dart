//{name: Impianto, id: 1560UMGGI9F3, description: ---, version: 25.2.5, hwType: GWC_V3, connectionStatus: 1, powerStatus: 1, ip: 10.9.0.37, port: 8001}

class DeviceModel {
  final String name;
  final String id;
  final String? description;
  final String? version;
  final String? hwType;
  final int? connectionStatus;
  final int? powerStatus;
  final String? ip;
  final int? port;

  DeviceModel({
    required this.name,
    required this.id,
    this.description,
    this.version,
    this.hwType,
    this.connectionStatus,
    this.powerStatus,
    this.ip,
    this.port,
  });

  factory DeviceModel.fromJson(Map<String, dynamic> json) {
    return DeviceModel(
      name: json['name'],
      id: json['id'],
      description: json['description'],
      version: json['version'],
      hwType: json['hwType'],
      connectionStatus: json['connectionStatus'],
      powerStatus: json['powerStatus'],
      ip: json['ip'],
      port: json['port'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'id': id,
      'description': description,
      'version': version,
      'hwType': hwType,
      'connectionStatus': connectionStatus,
      'powerStatus': powerStatus,
      'ip': ip,
      'port': port,
    };
  }
}
