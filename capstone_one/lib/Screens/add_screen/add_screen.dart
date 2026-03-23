import 'package:flutter/material.dart';

class AddScreen extends StatelessWidget {
  //TODO: use this brandName to send it to getMedicineDetails
  final String brandName;

  const AddScreen({super.key, required this.brandName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Center(child: Column(children: [Text(brandName)])),
      ),
    );
  }
}
