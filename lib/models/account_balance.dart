class AccountBalance {
  double? _accountBalance;

  AccountBalance(this._accountBalance);

  double get accountBalance => this._accountBalance ?? 0.0;

  set accountBalance(double newAccountBalance) {
    this._accountBalance = newAccountBalance;
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map<String, dynamic>();
    map['Balance'] = _accountBalance;
    return map;
  }
}
