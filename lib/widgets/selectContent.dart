import 'package:flutter/material.dart';

class SelectContentWidget extends StatefulWidget {
  const SelectContentWidget({Key? key, required this.contents})
      : super(key: key);
  final List<String> contents;

  @override
  State<SelectContentWidget> createState() => _SelectContentWidgetState();
}

class _SelectContentWidgetState extends State<SelectContentWidget> {
  final List<String> _selectedContents = [];
  void _itemChange(String itemValue, bool isSelected) {
    setState(() {
      if (isSelected) {
        _selectedContents.add(itemValue);
      } else {
        _selectedContents.remove(itemValue);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Select Content'),
      content: SingleChildScrollView(
        child: ListBody(
          children: widget.contents
              .map((e) => CheckboxListTile(
                  value: _selectedContents.contains(e),
                  title: Text(e),
                  controlAffinity: ListTileControlAffinity.leading,
                  onChanged: (isChecked) => _itemChange(e, isChecked!)))
              .toList(),
        ),
      ),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Cancel')),
        ElevatedButton(
            onPressed: () {
              print(_selectedContents);
              Navigator.pop(context, _selectedContents);
            },
            child: const Text('Submit'))
      ],
    );
  }
}
