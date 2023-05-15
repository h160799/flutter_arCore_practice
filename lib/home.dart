import 'package:flutter_arkit_practice/screens/augmented_faces.dart';
import 'package:flutter/material.dart';
import 'screens/remote_object.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter ArCore'),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => RemoteObject()));
            },
            title: const Text("Add Remote object"),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const AugmentedFacesScreen()));
            },
            title: const Text("Decorate Face"),
          ),
        ],
      ),
    );
  }
}
