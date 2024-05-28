// services/servant_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/servant.dart';

class ServantService {
  static const String _baseUrl = "https://api.atlasacademy.io";

  Future<List<Servant>> fetchServants() async {
    String apiUrl = "$_baseUrl/export/NA/basic_servant.json";
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => Servant.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load servants');
    }
  }

  Future<ServantDetail> fetchServantDetail(int id) async {
    String apiUrl = '$_baseUrl/nice/NA/servant/$id';
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return ServantDetail.fromJson(data);
    } else {
      throw Exception('Failed to load servant detail');
    }
  }
}
