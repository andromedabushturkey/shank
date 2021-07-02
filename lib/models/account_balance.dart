class AccountBalance {
  // String _accountBalance;

  // AccountBalance(this._accountBalance);

  // String get accountBalance => this._accountBalance;

  // set accountBalance(String newAccountBalance) {
  //   this._accountBalance = newAccountBalance;
  // }

  static Map<String, dynamic> toMap(String accountbalance) {
    Map<String, dynamic> map = Map<String, dynamic>();
    map['Balance'] = accountbalance;
    return map;
  }
}
