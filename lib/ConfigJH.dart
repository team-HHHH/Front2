import 'package:flutter/material.dart';

const Color SSU_BLUE = Color(0xFF60C1C3);
const Color GRAY = Color(0xFFFAFAFA);

const Color BORDER_GRAY = Color.fromARGB(255, 199, 198, 198);
const Color CALANDER_TEXT_GRAY = Color(0xFF585757);
const Color RED = Color(0xFFEA1B1B);

//const String SERVER_DOMAIN = "10.0.2.2:8080"; //for android localhost
//const String SERVER_DOMAIN = "3.36.57.137:8080"; //for android localhost
const String SERVER_DOMAIN = "211.221.75.4:8080"; //for android localhost
const String ACCESS_TOKEN =
    "Bearer eyJhbGciOiJIUzI1NiJ9.eyJjYXRlZ29yeSI6ImFjY2VzcyIsInVzZXJJZCI6MSwicm9sZSI6Im1lbWJlciIsImlhdCI6MTczMTQyNzM2MywiZXhwIjoxNzMxNDI3OTYzfQ.-3hbbl-7ZQ7P6y0jd9l1xglEml_MYdUvs-xFJSF4V9Y";

class StringPointer {
  String value;
  StringPointer(this.value);
}
