import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:isu_canner/variables/ip_address.dart';

class TaskService {
  final String baseUrl;

  TaskService(this.baseUrl);

  Future<List<dynamic>> fetchTasks() async {
    final response = await http.get(Uri.parse('$ipaddress/viewTask'));

    if (response.statusCode == 200) {
      return json.decode(response.body)['data'];
    } else {
      throw Exception('Failed to load tasks');
    }
  }
}
