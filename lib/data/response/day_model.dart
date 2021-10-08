class DayModel {
  DayModel({
    required this.id,
    required this.initialBalance,
    required this.saleBalance,
    required this.expensesBalances,
    required this.day,
    required this.month,
    required this.year,
  });
  final int id;
  final int initialBalance;
  final int saleBalance;
  final int expensesBalances;
  final int day;
  final int month;
  final int year;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'initialBalance': initialBalance,
      'saleBalance': saleBalance,
      'expensesBalances': expensesBalances,
      'day': day,
      'month': month,
      'year': year,
    };
  }

  factory DayModel.fromMap(Map<String, dynamic> json) => DayModel(
      initialBalance: json['initialBalance'],
      saleBalance: json['saleBalance'],
      expensesBalances: json['expensesBalances'],
      id: json['id'],
      day: json['day'],
      month: json['month'],
      year: json['year']);
}
