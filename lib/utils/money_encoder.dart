import 'package:money2/money2.dart';

class MoneyToIntEncoder extends MoneyEncoder<int> {
  @override
  int encode(MoneyData data) {
    return 1;
  }
}
