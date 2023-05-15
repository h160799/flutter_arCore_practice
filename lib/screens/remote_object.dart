
import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart';

class RemoteObject extends StatefulWidget {
  @override
  _RemoteObjectState createState() => _RemoteObjectState();
}

class _RemoteObjectState extends State<RemoteObject> {
  ArCoreController? arCoreController;

  String? objectSelected;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Custom Object on plane detected'),
        ),
        body: ArCoreView(
          onArCoreViewCreated: _onArCoreViewCreated,
          enableTapRecognizer: true,
          enablePlaneRenderer: true,
        ),
      ),
    );
  }

  void _onArCoreViewCreated(ArCoreController controller) {
    arCoreController = controller;
    arCoreController?.onNodeTap = (name) => onTapHandler(name);
    arCoreController?.onPlaneTap = _handleOnPlaneTap;
  }

  void _addDuck(ArCoreHitTestResult plane) {
    final duckNode = ArCoreReferenceNode(
        name: "Duck",
        objectUrl:
            "https://github.com/KhronosGroup/glTF-Sample-Models/raw/master/2.0/Duck/glTF/Duck.gltf",
        position: plane.pose.translation,
        rotation: plane.pose.rotation,
        scale: Vector3.all(0.5));

    arCoreController?.addArCoreNodeWithAnchor(duckNode);
  }

  void _addFox(ArCoreHitTestResult plane) {
    final foxNode = ArCoreReferenceNode(
        name: "Fox",
        objectUrl:
            "https://github.com/KhronosGroup/glTF-Sample-Models/raw/master/2.0/Fox/glTF-Binary/Fox.glb",
        position: plane.pose.translation,
        rotation: plane.pose.rotation,
        scale: Vector3.all(0.05));

    arCoreController?.addArCoreNodeWithAnchor(foxNode);
  }

  void _handleOnPlaneTap(
    List<ArCoreHitTestResult> hits,
  ) {
    final hit = hits.first;
    showDialog<void>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Center(
              child:
                  Text('Choose One !!', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
          GestureDetector(
            onTap: () {
              _addDuck(hit);
              Navigator.pop(context);
            },
            child: const Text(
              "Duck",
              style: TextStyle(fontSize: 16.0),
            ),
          ),
          const SizedBox(width: 20.0,),
          GestureDetector(
            onTap: () {
              _addFox(hit);
              Navigator.pop(context);
            },
            child: const Text(
              "Fox",
              style: TextStyle(fontSize: 16.0),
            ),
          ),
        ]),
      ),
    );
  }

  void onTapHandler(String name) {
    print("Flutter: onNodeTap");
    showDialog<void>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        content: Row(
          children: <Widget>[
            Text('Remove $name?'),
            IconButton(
                icon: const Icon(
                  Icons.delete,
                ),
                onPressed: () {
                  arCoreController?.removeNode(nodeName: name);
                  Navigator.pop(context);
                })
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    arCoreController?.dispose();
    super.dispose();
  }
}
