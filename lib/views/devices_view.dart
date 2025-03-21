import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:higeco_test/core/models/device_model.dart';
import 'package:higeco_test/core/repositories/device_repository.dart';

class DevicesView extends StatefulWidget {
  final int plantId;
  const DevicesView({super.key, required this.plantId});

  @override
  State<DevicesView> createState() => _DevicesViewState();
}

class _DevicesViewState extends State<DevicesView> {
  bool loading = false;
  List devices = [];
  @override
  void initState() {
    super.initState();
    getDevices();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: ()=>context.pop(),
            child: Icon(Icons.chevron_left)),
        title: Text('Devices of plant #${widget.plantId}'),
      ),
      body: ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: 10),
        itemCount: devices.length,
          itemBuilder: (_, i) {
          DeviceModel device = devices[i];
        return Column(
          children: [
            ListTile(
              onTap: ()=>context.push('/device/${widget.plantId}/${device.id}'),
              contentPadding: EdgeInsets.zero,
              leading: Icon(Icons.devices),
              title: Text(device.name),
              subtitle: Text(device.description ?? '---'),
              trailing: Icon(Icons.chevron_right),
            ),
            Divider(),
          ],
        );
      }),
    );
  }

  void getDevices() async {
    setState(() {
      loading = true;
    });
    try {
      final body = await DeviceRepository().getDevices(widget.plantId);
      setState(() {
        loading = false;
        devices = body.map<DeviceModel>((e) => DeviceModel.fromJson(e)).toList();
      });
    } catch (e) {
      setState(() {
        loading = false;
      });
      print('Error: $e');
    }
  }
}
