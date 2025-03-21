import '../api_client/api_client.dart';

class PlantRepository extends ApiClient {
  Future<dynamic> getPlants([List<String>? parameters]) async {
    return await get('plants', {'parameters': parameters});
  }
  Future<dynamic> getPlant(int id) async {
    return await get('plants/$id');
  }
}