import 'package:money2/money2.dart';

class MoneyToIntEncoder extends MoneyEncoder<int> {
  @override
  int encode(MoneyData data) {
    var _major = data.getMajorUnits();
    var _minor = data.getMinorUnits();
    var _pow = 10;

    print('Major Unit: $_major');
    print('Minor Unit: $_minor');

    while (_minor.toInt() >= _pow) {
      _pow *= 10;
    }
    var myInt = _major.toInt() * _pow + _minor.toInt();

    print('MYENCODED INT: $myInt');

    return myInt;
  }
}
