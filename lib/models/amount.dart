class BudgetEntry {
  final String name;
  final String amount;

  BudgetEntry({required this.name, required this.amount});

  factory BudgetEntry.fromJson(Map<String, dynamic> json) =>
      BudgetEntry(name: json['name'], amount: json['amount']);

    Map<String, dynamic> toJson() => {
        "name": name,
        "amount": amount,
    };
}
