import 'package:higeco_test/core/models/log_data_model.dart';

class Formulas {
  static const double nominalPower_kW = 4;
  static const double standartIrradiation_W_m2 = 1000;

  static String calculatePR(LogDataModel logsData, int? samplingTime) {
    int? energyIndex, irradiationIndex;
    double energyReal = 0;
    double energyModule = 0;
    double irradiationKoef = 0;
    double timeDelta = 1;
    if (logsData.data.isNotEmpty) {
      energyIndex = logsData.items.firstWhere((item) => item['name'] == 'Energia', orElse: ()=>null)?['index'];
      irradiationIndex = logsData.items.firstWhere((item) => item['name'] == 'Irraggiamento', orElse: ()=>null)?['index'];

      if (energyIndex == null || irradiationIndex == null) {
        return '0';
      }
      energyReal = logsData.data.last[energyIndex].toDouble() - logsData.data.first[energyIndex].toDouble();
      List irradiationValues = logsData.data.map((item) => item[irradiationIndex].toDouble()).toList();
      List energyValues = logsData.data.map((item) => item[energyIndex].toDouble()).toList();
      print('irradiationValues, ${irradiationValues.length}, energyValues, $energyValues');
      irradiationKoef = logsData.data
          .map((item) => (item[irradiationIndex].toDouble() / standartIrradiation_W_m2) * timeDelta)
          .reduce((a, b) => a + b);
    }
    energyModule = nominalPower_kW * irradiationKoef;
    print('energyReal: ${energyReal.toStringAsFixed(2)} kWh');
    print('irradiationKoef: ${irradiationKoef.toStringAsFixed(2)}');
    print('energyModule: ${energyModule.toStringAsFixed(2)} kWh');
    print('KPI: ${(energyReal / energyModule * 100).toStringAsFixed(2)} %');
    return energyModule > 0 ? '${((energyReal / energyModule) * 100).toStringAsFixed(2)}%' : '0';
  }
}
