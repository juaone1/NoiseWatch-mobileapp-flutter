import 'package:firebase_database/firebase_database.dart';
import 'package:noisewatch/model/student_record.dart';

class RecordsDatabaseService {
  final List<StudentRecord> list = [];

  getRecords() async {
    final recordsSnapshot =
        await FirebaseDatabase.instance.ref().child('Records').get();

    final map = recordsSnapshot.value as Map<dynamic, dynamic>;

    map.forEach((key, value) {
      final record = StudentRecord.fromMap(value);

      list.add(record);
    });

    return list;
  }
}
