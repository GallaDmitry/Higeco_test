import '../api_client/api_client.dart';

class SignalRepository extends ApiClient {

  Future<dynamic> getSignals(int plantId, String deviceId, String logId) async {
    return await get('plants/$plantId/devices/$deviceId/logs/$logId/items');
  }
  Future<dynamic> getSignal(int plantId, String deviceId, String logId, String id) async {
    return await get('plants/$plantId/devices/$deviceId/logs/$logId/items/$id');
  }
}