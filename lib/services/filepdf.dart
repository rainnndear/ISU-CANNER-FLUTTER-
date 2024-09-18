import 'dart:convert';

import '../model/api_response.dart';
import '../variables/ip_address.dart';
import 'package:http/http.dart' as http;

Future<ApiResponse> getFiles(String? token) async {

  ApiResponse apiResponse = ApiResponse();

  try {

    final response = await http.get(
        Uri.parse('$ipaddress/client_file'),
        headers: {
          'Accept': 'application/json',
          'Authorization':'Bearer $token'
        }
    );

    switch(response.statusCode){
      case 200:
        apiResponse.data = jsonDecode(response.body)['files'];
        break;
      case 422:
        final errors = jsonDecode(response.body)['message'];
        apiResponse.error = errors;
        break;
      case 403:
        apiResponse.error = jsonDecode(response.body)['message'];
        break;
      default:
        print('Error: ${response.body}');  // Log the error response for debugging
        apiResponse.error = 'Something went wrong.';
        break;
    }

  } catch(e){
    print('Exception: $e');  // Log any exceptions for debugging
    apiResponse.error = 'Something went wrong.';
  }

  return apiResponse;
}
