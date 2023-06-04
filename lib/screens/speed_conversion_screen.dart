import 'package:flutter/material.dart';

import '../models/models.dart';
import '../utils/utils.dart';
import '../widgets/field_list_tile.dart';
import '../widgets/keypad.dart';

class SpeedConversionScreen extends StatefulWidget {
  const SpeedConversionScreen({super.key});

  @override
  State<SpeedConversionScreen> createState() => _SpeedConversionScreenState();
}

class _SpeedConversionScreenState extends State<SpeedConversionScreen> {
  final TextEditingController _firstFieldController =
      TextEditingController(text: "1");
  final TextEditingController _secondFieldController =
      TextEditingController(text: "0.0001");

  bool isFirstFieldSelected = true;

  int firstFieldIndex = 0;
  int secondFieldIndex = 1;

  void convert() {
    convertUnit(
      _firstFieldController,
      _secondFieldController,
      firstFieldIndex,
      secondFieldIndex,
      Speed.speedList,
      isFirstFieldSelected,
    );
  }

  @override
  void dispose() {
    _firstFieldController.dispose();
    _secondFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Speed Conversion')),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  FieldListTile(
                    list: Speed.speedList,
                    controller: _firstFieldController,
                    isSelected: isFirstFieldSelected,
                    fieldIndex: firstFieldIndex,
                    onSelect: () {
                      setState(() {
                        isFirstFieldSelected = true;
                      });
                    },
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8),
                    child: Divider(),
                  ),
                  FieldListTile(
                    list: Speed.speedList,
                    controller: _secondFieldController,
                    isSelected: !isFirstFieldSelected,
                    fieldIndex: secondFieldIndex,
                    onSelect: () {
                      setState(() {
                        isFirstFieldSelected = false;
                      });
                    },
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8),
                    child: Divider(),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Keypad(
              controller: isFirstFieldSelected
                  ? _firstFieldController
                  : _secondFieldController,
              onChanged: convert,
            ),
          ),
        ],
      ),
    );
  }
}
