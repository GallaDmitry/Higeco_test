import 'package:higeco_test/core/api_client/api_client.dart';

class AuthRepository extends ApiClient {
  final String apiToken = '81b1acef983022068f2c38d6dd7c9bf8';

  Future<dynamic> authenticate() async {
    return await post('authenticate',  {
      'apiToken': apiToken,
    });
  }
}