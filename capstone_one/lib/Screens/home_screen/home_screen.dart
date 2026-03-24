import 'package:capstone_one/core/routes/route_keys.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SafeArea(
          child: Center(child: Column(children: [Text('Hi!')])),
        ),
      ),
      floatingActionButton: Padding(
        padding: EdgeInsetsGeometry.only(right: 8, bottom: 16),
        child: FloatingActionButton.large(
          onPressed: () {
            context.push(RouteKeys.searchScreen);
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
