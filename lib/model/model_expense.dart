class ModelExpense {
  int? id;
  String? title;
  String? amount;
  String? date;


  ModelExpense(
      {this.id,
        this.title = '',
        this.amount = '',
        this.date = '',

      });

  ModelExpense.fromJson(Map<String, dynamic> res) {
    id = res["id"];
    title = res["title"];
    amount = res["amount"];
    date = res["date"];
  }

  Map<String, Object?> toJson() {
    return {
      'id': id,
      'title': title,
      'amount': amount,
      'date': date,
    };
  }
}