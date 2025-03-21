import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:higeco_test/core/models/log_model.dart';
import 'package:higeco_test/core/repositories/log_repository.dart';

class LogsView extends StatefulWidget {
  final int plantId;
  final String deviceId;
  const LogsView({super.key, required this.plantId, required this.deviceId});

  @override
  State<LogsView> createState() => _LogsViewState();
}

class _LogsViewState extends State<LogsView> {
  List<LogModel> logs = [];
  bool loading = false;
  @override
  void initState() {
    super.initState();
    getLogs();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: ()=>context.pop(),
          child: Icon(Icons.chevron_left)),
        title: Text('Logs of device #${widget.deviceId}'),
      ),
      body: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 10),
        itemCount: logs.length,
        itemBuilder: (_, i) {
          LogModel log = logs[i];
          return Column(
            children: [
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Icon(Icons.list),
                title: Text(log.name),
                subtitle: Text('sampling Time: ${log.samplingTime ?? '---'}, tag: ${log.tag ?? '---'}'),
                trailing: Icon(Icons.chevron_right),
              ),
              Divider(),
            ],
          );
        },
      ),
    );
  }

  void getLogs() async {
    setState(() {
      loading = true;
    });
    try {
      var body = await LogRepository().getLogs(widget.plantId, widget.deviceId);
      setState(() {
        loading = false;
        logs = body.map<LogModel>((e) => LogModel.fromJson(e)).toList();
      });
    } catch (e) {
      setState(() {
        loading = false;
      });
    }
  }
}
