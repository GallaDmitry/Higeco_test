import 'package:higeco_test/core/api_client/api_client.dart';

class DeviceRepository extends ApiClient {
  Future<dynamic> getDevices(int plantId) async {
    return await get('plants/$plantId/devices');
  }
  Future<dynamic> getDevice(int plantId, String deviceId) async {
    return await get('plants/$plantId/devices/$deviceId');
  }
}