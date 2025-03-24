import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:higeco_test/core/models/log_data_model.dart';
import 'package:higeco_test/core/repositories/data_request_repository.dart';
import 'package:higeco_test/utils/formulas.dart';

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
  bool loading = false;
  late int from, to;

  @override
  void initState() {
    super.initState();
    initPeriod();
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
                    Formulas.calculatePR(logsData).toString(),
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
                      child: ElevatedButton(onPressed: () {}, child: Text('Download CSV'))),
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
        .toUtc()
        .copyWith(day: 7, hour: 0, minute: 0, second: 0, millisecond: 0).subtract(Duration(hours: 1)).millisecondsSinceEpoch;
  }

  void getLogsData() async {
    setState(() {
      loading = true;
    });
    try {
      var body = await DataRequestRepository().getLogData(
          widget.plantId, widget.deviceId, widget.logId,
          from: (from / 1000).toString(), to: (to / 1000).toString());
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
}
