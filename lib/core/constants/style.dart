import 'package:flutter/material.dart';

final appBarShape = RoundedRectangleBorder(
  borderRadius: BorderRadius.only(
    bottomRight: Radius.circular(7),
    bottomLeft: Radius.circular(7),
  ),
);
final searchFieldStyle = InputDecoration(
  hintText: 'Search here ...',
  contentPadding: EdgeInsets.all(10),
  filled: true,
  border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(7), borderSide: BorderSide.none),
);
