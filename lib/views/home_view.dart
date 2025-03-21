import 'package:flutter/material.dart';
import 'package:higeco_test/core/models/plant_model.dart';
import 'package:higeco_test/core/repositories/plant_repository.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<PlantModel> plants = [];
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
      body: ListView.builder(
        itemCount: plants.length,
          itemBuilder: (_, i) {
        var plant = plants[i];
        return ListTile(
          leading: Icon(Icons.eco),
          title: Text(plant.name),
        );
      }),
    );
  }
  void getPlants() async {
    final body = await PlantRepository().getPlants();
    setState(() {
      plants = body.map<PlantModel>((item)=>PlantModel.fromJson(item)).toList();
    });
  }
}