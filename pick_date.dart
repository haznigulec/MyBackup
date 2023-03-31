//The Pick Date Widget on this page helps to pick a day.

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PickSingleDate extends StatefulWidget {
  PickSingleDate({super.key, required this.title, required this.value});
  final String title;
  DateTime? value;
  @override
  State<PickSingleDate> createState() => _PickSingleDateState();
}

class _PickSingleDateState extends State<PickSingleDate> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(children: [SizedBox(width: 10), Text(widget.title, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold))]),
        const SizedBox(height: 5),
        MaterialButton(
          minWidth: MediaQuery.of(context).size.width * .8,
          height: 48,
          padding: const EdgeInsets.only(left: 10, right: 10),
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(11)), side: BorderSide()),
          child: Text(
            widget.value == null ? "Select a Date" : DateFormat.yMMMMd().format(widget.value!),
            style: TextStyle(height: double.parse((1).toString())),
          ),
          onPressed: () async {
            widget.value = await showDatePicker(
                context: context, initialDate: DateTime.now(), firstDate: DateTime.parse("1900-01-01T01:00:00.000000"), lastDate: DateTime.now());
            setState(() {});
          },
        ),
      ],
    );
  }
}
