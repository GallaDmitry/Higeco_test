import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:higeco_test/core/models/log_data_model.dart';

import '../../../utils/helpers.dart';

class Chart extends StatefulWidget {
  final LogDataModel? logsData;
  final String? type;

  const Chart({super.key, this.logsData, this.type});

  @override
  State<Chart> createState() => _ChartState();
}

class _ChartState extends State<Chart> {
  List<String> supportingTypes = ['Energia', 'Irraggiamento'];

  List data = [];
  int? index;
  @override
  void initState() {
    super.initState();
    index = widget.logsData!.items.firstWhere((element) => element['name'] == widget.type, orElse: ()=>null)?['index'];
  }

  @override
  Widget build(BuildContext context) {
    return widget.logsData != null
        ? supportingTypes.contains(widget.type) && index != null
            ? LineChart(LineChartData(
                lineBarsData: [
                  LineChartBarData(
                    spots: widget.logsData!.data
                        .map<FlSpot>(
                            (dataItem) => FlSpot(dataItem[0].toDouble(), dataItem[index].toDouble()))
                        .toList(),
                    isCurved: true,
                    color: Colors.blue,
                    barWidth: 4,
                    dotData: FlDotData(show: false),
                    isStrokeCapRound: true,
                    belowBarData: BarAreaData(show: false),
                  ),
                ],
                titlesData: FlTitlesData(
                    rightTitles: AxisTitles(sideTitles: SideTitles()),
                    topTitles: AxisTitles(sideTitles: SideTitles()),
                    leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (double value, titleMeta) {
                        return Text(
                          '${value}',
                          softWrap: false,
                          style: TextStyle(
                            fontSize: 10,
                          ),
                        );
                      },
                    )),
                    bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (double value, titleMeta) {
                        return Text(
                          '${Helpers.timestampToDateTime(value.toInt())}',
                          style: TextStyle(
                            fontSize: 10,
                          ),
                        );
                      },
                    ))),
                borderData: FlBorderData(show: true),
                gridData: FlGridData(show: false),
              ))
            : Center(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text('This type of chart is not supported or data is missing, (${widget.type})',
                  textAlign: TextAlign.center,),
                ),
              )
        : Center(
            child: Text('No data to show'),
          );
  }
}
