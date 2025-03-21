import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:higeco_test/core/models/plant_model.dart';
import 'package:higeco_test/core/repositories/plant_repository.dart';
import 'package:higeco_test/utils/router.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<PlantModel> plants = [];
  bool loading = false;
  @override
  void initState() {
    super.initState();
    getPlants();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Plants'),
      ),
      body: RefreshIndicator(
        onRefresh: () {
          getPlants();
          return Future.value(true);
        },
        child: ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: 10),
            itemCount: plants.length,
            itemBuilder: (_, i) {
              var plant = plants[i];
              return Column(
                children: [
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    onTap: () => context.push('/plant/${plant.id}'),
                    leading: Icon(Icons.eco),
                    title: Text(plant.name),
                    trailing: Icon(Icons.chevron_right),
                  ),
                  Divider(),
                ],
              );
            }),
      ),
    );
  }

  void getPlants() async {
    setState(() {
      loading = true;
    });
    try {
      final body = await PlantRepository().getPlants();
      setState(() {
        loading = false;
        plants = body.map<PlantModel>((item) => PlantModel.fromJson(item)).toList();
      });
    } catch (e) {
      print('Error: $e');
    }
  }
}
