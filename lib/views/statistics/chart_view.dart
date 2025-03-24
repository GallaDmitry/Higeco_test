import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:higeco_test/core/models/log_data_model.dart';

import 'components/chart.dart';

class ChartView extends StatelessWidget {
  const ChartView({super.key, this.logData, this.type});
  final LogDataModel? logData;
  final String? type;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () => context.pop(),
          child: Icon(Icons.chevron_left),
        ),
        title: Text('Chart of $type'
      )),
      body: Chart(logsData: logData,
        type: type,
      ),
    );
  }
}
