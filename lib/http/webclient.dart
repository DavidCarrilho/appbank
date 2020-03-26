import 'package:http/http.dart';

void finalAll() async {
  final Response response = await get("http://192.168.0.116:8080/transactions");
  print(response.body);
}
