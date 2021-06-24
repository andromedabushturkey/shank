class DailyModel {
  int? _id;
  late DateTime _date;
  late String _description;
  late double _deposit;
  late double _withdrawl;
  late String _notes;

  DailyModel(
    this._date,
    this._description,
    this._deposit,
    this._withdrawl,
    this._notes,
  );

  DailyModel.withId(
    this._id,
    this._date,
    this._description,
    this._deposit,
    this._withdrawl,
    this._notes,
  );

  //convert Daily object to Map
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map<String, dynamic>();

    if (_id != null) {
      map['id'] = _id;
    }
    map['date'] = _date.toIso8601String();
    map['description'] = _description;
    map['deposit'] = _deposit;
    map['withdrawl'] = _withdrawl;
    map['notes'] = _notes;

    return map;
  }

  factory DailyModel.fromMapObject(Map<String, dynamic> map) {
    return DailyModel.withId(map['id'], map['date'], map['description'],
        map['deposit'], map['withdrawl'], map['notes']);
  }
}
