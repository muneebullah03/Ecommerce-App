// ignore_for_file: unused_local_variable

import 'dart:math';

String generateOrderId() {
  DateTime now = DateTime.now();
  int randomNumbers = Random().nextInt(99999);
  String id = '${randomNumbers}_$now';

  return id;
}
