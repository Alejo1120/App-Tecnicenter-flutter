import 'package:fruver/data/response/day_model.dart';
import 'package:fruver/domain/models/calendary_model.dart';

abstract class CalendaryRepository {
  Future<DayModel> getDay(DateTime date);
  Future<List<DayModel>> getDaysMonth(String year, String month);
  Future<List<DayModel>> getDaysYear(String year);

  Future<bool> addDate(CalendaryModel calendaryModel);
  Future<bool> updateDate(int id, CalendaryModel calendaryModel);
}
