import 'package:e_comm/utiles/App-constant.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
      backgroundColor: AppConstant.appSecondryColor,
      title: const Text('Flutter demo'),
      centerTitle: true,
      elevation: 0,
    ));
  }
}
