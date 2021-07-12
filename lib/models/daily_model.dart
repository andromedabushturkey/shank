class DailyModel {
  int? _id;
  String _date;
  String _description;
  String _deposit;
  String _expense;
  String _notes;

  DailyModel(
    this._date,
    this._description,
    this._deposit,
    this._expense,
    this._notes,
  );

  DailyModel.withId(
    this._id,
    this._date,
    this._description,
    this._deposit,
    this._expense,
    this._notes,
  );

  //convert Daily object to Map
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map<String, dynamic>();

    if (_id != null) {
      map['id'] = _id;
    }
    map['Date'] = _date;
    map['Description'] = _description;
    map['Deposit'] = _deposit;
    map['Expense'] = _expense;
    map['Notes'] = _notes;

    return map;
  }

  factory DailyModel.fromMapObject(Map<String, dynamic> map) {
    return DailyModel.withId(map['id'], map['Date'], map['Description'],
        map['Deposit'], map['Expense'], map['Notes']);
  }
}
