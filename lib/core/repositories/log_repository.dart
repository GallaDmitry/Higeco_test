import 'package:higeco_test/core/api_client/api_client.dart';

class LogRepository extends ApiClient {
  Future<dynamic> getLogs(int plantId, String deviceId) async {
    return await get('plants/$plantId/devices/$deviceId/logs');
  }
  Future<dynamic> getLog(int plantId, String deviceId, String id) async {
    return await get('plants/$plantId/devices/$deviceId/logs/$id');
  }
}