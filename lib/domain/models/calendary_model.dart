class CalendaryModel {
  CalendaryModel({
    required this.initialBalance,
    required this.saleBalance,
    required this.expensesBalances,
    required this.day,
    required this.month,
    required this.year,
  });
  final int initialBalance;
  final int saleBalance;
  final int expensesBalances;
  final int day;
  final int month;
  final int year;

  Map<String, dynamic> toMap() {
    return {
      'initialBalance': initialBalance,
      'saleBalance': saleBalance,
      'expensesBalances': expensesBalances,
      'day': day,
      'month': month,
      'year': year,
    };
  }
}
