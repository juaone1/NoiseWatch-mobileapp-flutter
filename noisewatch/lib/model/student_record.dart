import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class StudentRecord {
  final String name;
  final int offense;

  StudentRecord({
    required this.name,
    required this.offense,
  });

  factory StudentRecord.fromMap(Map<dynamic, dynamic> map) {
    return StudentRecord(
        name: map['name'] ?? '', offense: map['offense'] ?? '');
  }
}
