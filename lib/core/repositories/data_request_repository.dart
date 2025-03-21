import 'package:higeco_test/core/api_client/api_client.dart';

class DataRequestRepository extends ApiClient {
  Future<dynamic> getLogData(int plantId, String deviceId, String logId) async {
    return await get('getLogData/$plantId/$deviceId/$logId', {'from': '1741966268'});
  }
  Future<dynamic> getLogDataByItem(int plantId, String deviceId, String logId, String itemId) async {
    return await get('getLogData/$plantId/$deviceId/$logId/$itemId?from=${1740843068}&to=1742571814&isoTimestamps=false');
  }
}