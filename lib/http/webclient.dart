import 'package:http_interceptor/http_interceptor.dart';
import 'package:http/http.dart';

class LoggingInterceptor implements InterceptorContract {
  @override
  Future<RequestData> interceptRequest({RequestData data}) async {
    print('Request');
    print('url: ${data.url}');
    print('headers: ${data.headers}');
    print('body: ${data.body}');
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({ResponseData data}) async {
    print('Response');
    print('status code: ${data.statusCode}');
    print('headers: ${data.headers}');
    print('body: ${data.body}');
    return data;
  }

}

void findAll() async {
  Client client = HttpClientWithInterceptor.build(interceptors: [LoggingInterceptor()]);
  final Response response = await client.get('http://192.168.0.57:8080/transactions');
  print(response.body);
}