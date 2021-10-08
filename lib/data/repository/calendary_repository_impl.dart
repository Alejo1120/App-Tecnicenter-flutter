import 'package:fruver/data/response/day_model.dart';
import 'package:fruver/data/services/calendary_services.dart';
import 'package:fruver/domain/models/calendary_model.dart';
import 'package:fruver/domain/repository/calendary_repository.dart';

class CalendaryRepositoryImpl extends CalendaryRepository {
  final CalendaryServices calendaryServices = CalendaryServices();

  @override
  Future<DayModel> getDay(DateTime date) async {
    late final DayModel day;
    try {
      day = await CalendaryServices.getDay(date);
      return day;
    } catch (err) {
      throw Exception();
    }
  }

  @override
  Future<bool> addDate(CalendaryModel calendaryModel) async {
    late final bool res;
    try {
      res = await CalendaryServices.addDay(calendaryModel);
      return res;
    } catch (err) {
      throw Exception();
    }
  }

  @override
  Future<List<DayModel>> getDaysMonth(String year, String month) async {
    late final List<DayModel> days;
    try {
      days = await CalendaryServices.getMont(year, month);
      return days;
    } catch (err) {
      throw Exception();
    }
  }

  @override
  Future<List<DayModel>> getDaysYear(String year) async {
    late final List<DayModel> days;
    try {
      days = await CalendaryServices.getDaysYear(year);
      return days;
    } catch (err) {
      throw Exception();
    }
  }

  @override
  Future<bool> updateDate(int id, CalendaryModel calendaryModel) async {
    late final bool res;
    try {
      res = await CalendaryServices.updateDate(calendaryModel, id);
      return res;
    } catch (err) {
      throw Exception();
    }
  }
}
