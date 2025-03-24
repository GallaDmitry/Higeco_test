import 'package:higeco_test/core/models/log_data_model.dart';

class Formulas {
  static const double nominalPower_kW = 3;
  static const double standartIrradiation_W_m2 = 1000;

  static String calculatePR(LogDataModel logsData) {
    int? energyIndex, irradiationIndex;
    double energyReal = 0;
    double energyModule = 0;
    double irradiationKoef = 0;
    double timeDelta = 0;
    if (logsData.data.isNotEmpty) {
      energyIndex = logsData.items.firstWhere((item) => item['name'] == 'Energia', orElse: ()=>null)?['index'];
      irradiationIndex = logsData.items.firstWhere((item) => item['name'] == 'Irraggiamento', orElse: ()=>null)?['index'];

      if (energyIndex == null || irradiationIndex == null) {
        return '0';
      }

      timeDelta = (logsData.data[1][0].toDouble() - logsData.data.first[0].toDouble()) / 3600;
      energyReal = logsData.data.last[energyIndex].toDouble() - logsData.data.first[energyIndex].toDouble();

      irradiationKoef = logsData.data
          .map((item) => (item[irradiationIndex].toDouble() / standartIrradiation_W_m2) * timeDelta)
          .reduce((a, b) => a + b);
    }
    energyModule = nominalPower_kW * irradiationKoef;
    return energyModule > 0 ? '${((energyReal / energyModule) * 100).toStringAsFixed(2)}%' : '0';
  }
}
