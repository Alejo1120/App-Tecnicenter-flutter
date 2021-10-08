import 'package:fruver/data/response/day_model.dart';
import 'package:fruver/domain/models/calendary_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class CalendaryServices {
  static Future<Database> _openDatebase() async {
    return await openDatabase(join(await getDatabasesPath(), 'fruver.db'),
        onCreate: (db, version) {
      return db.execute(
        'CREATE TABLE fruver ( id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,  initialBalance INTEGER, saleBalance INTEGER, expensesBalances INTEGER, day INTEGER, month INTEGER ,year INTEGER );',
      );
    }, version: 1);
  }

  static Future<DayModel> getDay(DateTime date) async {
    print(date.day);
    print(date.month);
    print(date.year);
    late final DayModel dayModel;
    Database database = await _openDatebase();
    try {
      final data = await database.query('fruver',
          where: 'day=? AND month=? AND year=?',
          whereArgs: [date.day, date.month, date.year]);
      dayModel = DayModel.fromMap(data.first);
      print('object');
      return dayModel;
    } catch (err) {
      throw Exception();
    }
  }

  static Future<List<DayModel>> getMont(String year, String month) async {
    late final List<DayModel> calendary;
    Database database = await _openDatebase();
    try {
      final List<Map<String, dynamic>> data = await database.query('fruver',
          where: 'year = ? and month = ?', whereArgs: [year, month]);

      calendary = List.generate(
          data.length,
          (i) => DayModel(
              id: data[i]['id'],
              initialBalance: data[i]['initialBalance'],
              saleBalance: data[i]['saleBalance'],
              expensesBalances: data[i]['expensesBalances'],
              day: data[i]['day'],
              month: data[i]['month'],
              year: data[i]['year']));
      print('object');
      return calendary;
    } catch (err) {
      throw Exception();
    }
  }

  static Future<List<DayModel>> getDaysYear(String year) async {
    late final List<DayModel> calendary;
    Database database = await _openDatebase();
    try {
      final List<Map<String, dynamic>> data =
          await database.query('fruver', where: 'year = ?', whereArgs: [year]);
      calendary = List.generate(
          data.length,
          (i) => DayModel(
              id: data[i]['id'],
              initialBalance: data[i]['initialBalance'],
              saleBalance: data[i]['saleBalance'],
              expensesBalances: data[i]['expensesBalances'],
              day: data[i]['day'],
              month: data[i]['month'],
              year: data[i]['year']));
      return calendary;
    } catch (err) {
      throw Exception();
    }
  }

  static Future<bool> addDay(CalendaryModel day) async {
    Database database = await _openDatebase();
    try {
      await database.insert('fruver', day.toMap());
      return true;
    } catch (err) {
      return false;
    }
  }

  static Future<bool> updateDate(CalendaryModel day, int id) async {
    Database databse = await _openDatebase();
    try {
      await databse
          .update('fruver', day.toMap(), where: 'id =? ', whereArgs: [id]);
      return true;
    } catch (err) {
      return false;
    }
  }

  static Future<bool> deleteCalendary(int id) async {
    Database database = await _openDatebase();
    try {
      database.delete('fruver', where: 'id = ?', whereArgs: [id]);
      return true;
    } catch (err) {
      return false;
    }
  }
}
