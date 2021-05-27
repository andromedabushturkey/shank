class DailyModel {
  int? _id;
  late int _date;
  late String _description;
  late double _deposit;
  late double _withdrawl;
  late double _accountBalance;
  late String _notes;

  DailyModel(this._date, this._description, this._deposit, this._withdrawl,
      this._notes, this._accountBalance);

  DailyModel.withId(this._id, this._date, this._description, this._deposit,
      this._withdrawl, this._notes, this._accountBalance);

  int get id => this._id ?? 1;

  int get date => this._date;

  String get description => this._description;

  double get deposit => this._deposit;

  double get withdrawl => this._withdrawl;

  double get accountBalance => this._accountBalance;

  String get notes => this._notes;

  set date(int newDate) {
    this._date = newDate;
  }

  set description(String newDescription) {
    this._description = newDescription;
  }

  set deposit(double newDesposit) {
    this._deposit = newDesposit;
  }

  set withdrawl(double newWithdrawl) {
    this._withdrawl = newWithdrawl;
  }

  set accountBalance(double newAccountBalance) {
    this._accountBalance = newAccountBalance;
  }

  set notes(String newNote) {
    this._notes = newNote;
  }

  //convert Daily object to Map
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map<String, dynamic>();

    if (_id != null) {
      map['id'] = _id;
    }
    map['date'] = _date;
    map['description'] = _description;
    map['deposit'] = _deposit;
    map['withdrawl'] = _withdrawl;
    map['notes'] = _notes;

    return map;
  }

  DailyModel.fromMapObject(Map<String, dynamic> map) {
    this._date = map['date'];
    this._description = map['description'];
    this._deposit = map['deposit'];
    this._withdrawl = map['withdrawl'];
    this._notes = map['notes'];
  }
}
