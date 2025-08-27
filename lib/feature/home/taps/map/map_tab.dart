import 'package:flutter/material.dart';

class MapTab extends StatelessWidget {
  const MapTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Map Tap')),
      body: Center(
        child: Text(
          'This is the Map Tap',
          style: Theme.of(context).textTheme.headlineLarge,
        ),
      ),
    );
  }
}
