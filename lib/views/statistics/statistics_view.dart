import 'dart:io';

import 'package:csv/csv.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:higeco_test/core/models/log_data_model.dart';
import 'package:higeco_test/core/models/log_model.dart';
import 'package:higeco_test/core/repositories/data_request_repository.dart';
import 'package:higeco_test/core/repositories/log_repository.dart';
import 'package:higeco_test/utils/formulas.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';

class StatisticsView extends StatefulWidget {
  final int plantId;
  final String deviceId;
  final String logId;

  const StatisticsView(
      {super.key, required this.plantId, required this.deviceId, required this.logId});

  @override
  State<StatisticsView> createState() => _StatisticsViewState();
}

class _StatisticsViewState extends State<StatisticsView> {
  late LogDataModel logsData;
  late LogModel log;
  bool loading = false;
  late int from, to;

  @override
  void initState() {
    super.initState();
    initPeriod();
    getLog();
    getLogsData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: InkWell(onTap: () => context.pop(), child: Icon(Icons.chevron_left)),
          title: Text('Statistics of log #${widget.logId}')),
      body: loading
          ? Center(child: CupertinoActivityIndicator())
          : Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Period:'),
                  Container(
                    margin: EdgeInsets.only(bottom: 20),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            readOnly: true,
                            controller: TextEditingController(
                                text: DateTime.fromMillisecondsSinceEpoch(from).toString()),
                            decoration: InputDecoration(labelText: 'From'),
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: TextField(
                            readOnly: true,
                            controller: TextEditingController(
                                text: DateTime.fromMillisecondsSinceEpoch(to).toString()),
                            decoration: InputDecoration(labelText: 'To'),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text('PR:'),
                  Text(
                    Formulas.calculatePR(logsData, log.samplingTime).toString(),
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.symmetric(vertical: 20),
                      child: ElevatedButton(onPressed: ()=>goToChart('Energia'), child: Text('Show Energy Chart'))),
                  Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(bottom: 20),
                      child: ElevatedButton(onPressed: ()=>goToChart('Irraggiamento'), child: Text('Show Irraggiamento Chart'))),
                  Container(
                      width: double.infinity,
                      child: ElevatedButton(onPressed: () => saveCSV(), child: Text('Save CSV'))),
                ],
              ),
            ),
    );
  }

  void initPeriod() {
    from = DateTime.now()
        .copyWith(day: 1, hour: 0, minute: 0, second: 0, millisecond: 0)
        .millisecondsSinceEpoch;
    to = DateTime.now()
        .copyWith(day: 2, hour: 0, minute: 0, second: 0, millisecond: 0).subtract(Duration(hours: 1)).millisecondsSinceEpoch;
  }

  void getLog() async {
    try {
      var body = await LogRepository().getLog(widget.plantId, widget.deviceId, widget.logId);
      log = LogModel.fromJson(body);
    } catch (e) {

    }
  }
  void getLogsData() async {
    setState(() {
      loading = true;
    });
    try {
      var body = await DataRequestRepository().getLogData(
          widget.plantId, widget.deviceId, widget.logId,
          from: (from / 1000).toString(), to: (to / 1000).toString(), samplingTime: '3600');
      setState(() {
        loading = false;
        logsData = LogDataModel.fromJson(body);
      });
    } catch (e) {
      setState(() {
        loading = false;
      });
    }
  }
  void goToChart(String type) {
    context.push('/chart', extra: {'logData': logsData, 'type': type});
  }
  void saveCSV() async {
    List<List<dynamic>> data = [
      ['Time', 'Energia', 'Irraggiamento'],
    ];
    int energyIndex = logsData.items.firstWhere((item) => item['name'] == 'Energia', orElse: ()=>null)?['index'];
    int irradiationIndex = logsData.items.firstWhere((item) => item['name'] == 'Irraggiamento', orElse: ()=>null)?['index'];
    data.addAll(logsData.data.map((e) => [DateTime.fromMillisecondsSinceEpoch(e[0] * 1000).toString(), e[energyIndex], e[irradiationIndex]]).toList());
    String csvData = const ListToCsvConverter().convert(data);
    Directory? directory;

    if (Platform.isAndroid) {
      if (await Permission.storage.request().isGranted) {
        directory = await getExternalStorageDirectory();
      }
    } else {
      directory = await getApplicationDocumentsDirectory();
    }

    if (directory == null) {
      return;
    }

    String filePath = "${directory.path}/data.csv";
    File file = File(filePath);
    await file.writeAsString(csvData);
    Share.shareXFiles([XFile(filePath)]);
  }
}
