class AccountBalance {
  double _accountBalance;

  AccountBalance([this._accountBalance]);

  double get accountBalance => this._accountBalance;

  set accountBalance(double newAccountBalance) {
    this._accountBalance = newAccountBalance;
  }

  Map<String, dynamic> toMap() {
    Map map = Map<String, dynamic>();
    map['accountBalance'] = _accountBalance;
    return map;
  }
}
