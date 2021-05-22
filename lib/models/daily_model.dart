class DailyModel {
  int _id;
  int _date;
  String _description;
  double _deposit;
  double _withdrawl;
  String _notes;

  DailyModel([this._id, this._date, this._description, this._deposit, this._withdrawl, this._notes]);

  DailyModel.withId([this._id, this._date, this._description, this._deposit, this._withdrawl, this._notes]);

  int get id => this._id;

  int get date => this._date;

  String get description => this._description;

  double get deposit => this._deposit;

  double get withdrawl => this._withdrawl;

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

  set notes(String newNote) {
    this._notes = newNote;
  }
}
