import 'package:flutter/material.dart';

class CabinetScreen extends StatelessWidget {
  const CabinetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Center(child: Column(children: [Text('Cabinet Screen')])),
      ),
    );
  }
}
