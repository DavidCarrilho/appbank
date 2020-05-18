import 'package:appbank/models/transaction.dart';
import 'package:flutter_test/flutter_test.dart';

void main(){
  test("deve tertornar o valor, quando criarmos uma transação", (){
    final transaction = Transaction(null, 200, null);
    expect(transaction.value, 200);
  });
  test("deve mostrar erro, quando criarmos uma transferencia com o valor menor que zero", (){
    expect(()=> Transaction(null, 0, null), throwsAssertionError);
  });
}