
import 'package:appbank/http/interceptors/logging_interceptor.dart';
import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';

const String baseUrl = "http://192.168.0.116:8080/transactions";

final Client client =
    HttpClientWithInterceptor.build(interceptors: [LoggingInterceptor()]);