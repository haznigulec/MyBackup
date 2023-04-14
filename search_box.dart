//The SearchBox Widget on this page have two suffix. First is clear second is filter by.




import 'dart:developer';
import 'package:flutter/material.dart';
import 'app_texts.dart';

class SearchBox extends StatelessWidget {
  SearchBox(
      {super.key,
      required this.title,
      required this.onPressed,
      required this.onChanged,
      required this.popMenuItems,
      required this.popMenuItemOnSelected,
      required this.controller});
  final TextEditingController controller;
  final String title;
  final Function() onPressed;
  final Function(String) onChanged;
  final Map<String, String> popMenuItems;
  final Function(String value) popMenuItemOnSelected;
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      cursorColor: Colors.grey,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 10,
          ),
          hintText: "Search by $title",
          fillColor: Colors.grey.withOpacity(.2),
          filled: true,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            borderSide: BorderSide(color: Colors.grey.withOpacity(.3)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            borderSide: BorderSide(color: Colors.grey.withOpacity(.2)),
          ),
          suffixIcon: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                padding: EdgeInsets.zero,
                icon: Icon(Icons.close, color: Colors.black.withOpacity(0.7)),
                onPressed: onPressed,
              ),
              popupMenuButton
            ],
          )),
      onChanged: onChanged,
    );
  }

  PopupMenuButton get popupMenuButton => PopupMenuButton<String>(
        onSelected: popMenuItemOnSelected,
        constraints: const BoxConstraints.tightFor(width: 200, height: 250),
        offset: Offset(0, 40),
        itemBuilder: (BuildContext context) {
          return <PopupMenuEntry<String>>[
            for (var i = 0; i < popMenuItems.length; i++)
              PopupMenuItem<String>(
                value: popMenuItems.keys.elementAt(i),
                child: Text(popMenuItems.values.elementAt(i)),
              )
          ];
        },
      );
}

--------------------------------------------------------------------------------------------------------------------------------------------
  Map<String, String> popMenuItems = {
    'displayName': 'Display Name',
    'primaryDomainName': 'Domain Name',
    "microsoftId": "Microsoft Id",
    'taxNumber': 'Tax Number',
    'description': 'Description'
  };

  SearchBox(
      title: popMenuItems[searchParam] ?? "",
      onPressed: () async {
        _filter.clear();
        sharedTenants.clear();
        await SubTenantRepo().getTenant("", searchParam);
        setState(() {});
      },
      onChanged: (value) {
        onSearchDebouncer.debounce(() async {
          sharedTenants.clear();
          if (value.isEmpty) {
            await SubTenantRepo().getTenant("orhan", searchParam);
            setState(() {});
            return;
          }
          await SubTenantRepo().getTenant(value, searchParam);
          setState(() {});
        });
      },
      popMenuItemOnSelected: (String value) async {
        searchParam = value;
        sharedTenants.clear();
        await SubTenantRepo().getTenant(_filter.text, value);
        setState(() {});
      },
      popMenuItems: popMenuItems,
      controller: _filter,
    ),