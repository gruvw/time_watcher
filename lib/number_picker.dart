import 'package:flutter/material.dart';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:numberpicker/numberpicker.dart';

import 'package:time_watcher/main.dart';

class DBNumberPicker extends HookWidget {
  final String name;
  final int defaultValue;
  final int min;
  final int max;

  const DBNumberPicker({
    super.key,
    required this.name,
    required this.defaultValue,
    required this.min,
    required this.max,
  });

  @override
  Widget build(BuildContext context) {
    final value = useState(Hive.box<int>(box).get(name) ?? defaultValue);

    return ElevatedButton(
      style: const ButtonStyle(
        backgroundColor: MaterialStatePropertyAll(accentColor),
      ),
      onPressed: () async {
        value.value = await showDialog(
            context: context,
            builder: (context) {
              return _NumberPickerDialog(
                initValue: value.value,
                minValue: min,
                maxValue: max,
              );
            });
        Hive.box<int>(box).put(name, value.value);
      },
      child: Text("$name: ${value.value}"),
    );
  }
}

class _NumberPickerDialog extends HookWidget {
  final int initValue;
  final int minValue;
  final int maxValue;

  const _NumberPickerDialog({
    required this.initValue,
    required this.minValue,
    required this.maxValue,
  });

  @override
  Widget build(BuildContext context) {
    final value = useState(initValue);

    return AlertDialog(
      contentPadding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
      content: NumberPicker(
        minValue: minValue,
        maxValue: maxValue,
        value: value.value,
        onChanged: (newValue) => value.value = newValue,
      ),
      actions: [
        TextButton(
          child: const Text("OK", style: TextStyle(color: accentColor)),
          onPressed: () => Navigator.pop(context, value.value),
        )
      ],
    );
  }
}
