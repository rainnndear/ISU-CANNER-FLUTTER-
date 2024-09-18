import 'dart:convert';
import 'package:http/http.dart' as http;
import '../variables/ip_address.dart';
import '../model/api_response.dart';
import '../model/user.dart';

Future<ApiResponse> register(
  String lastname,
  String firstname,
  String middlename,
  String account_type,
  String department,
  String email,
  String password,
  String password_confirmation,
) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    final response = await http.post(
      Uri.parse('$ipaddress/register'), // Use the IP address variable here
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'lastname': lastname,
        'firstname': firstname,
        'middlename': middlename,
        'account_type': account_type,
        'department': department,
        'email': email,
        'password': password,
        'password_confirmation': password_confirmation,
      }),
    );

    switch (response.statusCode) {
      case 200:
        apiResponse.data = User.fromJson(jsonDecode(response.body));
        break;
      case 422:
        final errors = jsonDecode(response.body)['errors'];
        apiResponse.error = errors.toString();
        break;
      case 403:
        apiResponse.error = jsonDecode(response.body)['message'];
        break;
      default:
        apiResponse.error = 'Something went wrong.';
        break;
    }
  } catch (e) {
    apiResponse.error = 'Something went wrong.';
  }
  return apiResponse;
}
