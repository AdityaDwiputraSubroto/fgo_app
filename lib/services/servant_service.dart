import 'dart:convert';
import 'package:fgo_app/services/dB.dart';
import 'package:http/http.dart' as http;
import '../models/servant.dart';

class ServantService {
  static const String _baseUrl = "https://api.atlasacademy.io";
  final DatabaseHelper _dbHelper = DatabaseHelper();

  Future<List<Servant>> fetchServants() async {
    String apiUrl = "$_baseUrl/export/NA/basic_servant.json";
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      List<Servant> servants =
          data.map((json) => Servant.fromJson(json)).toList();

      List<int> favoriteIds = await getFavorites();
      print("favorites : $favoriteIds");
      for (var servant in servants) {
        if (favoriteIds.contains(servant.id)) {
          servant.isFavorite = true;
        }
      }

      return servants;
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

  Future<void> toggleFavorite(int servantId, bool isFavorite) async {
    print('servant id : $servantId');
    print('is favorite : $isFavorite');
    if (!isFavorite) {
      print('remove favorite');
      await removeFavorite(servantId);
    } else {
      print('add favorite');
      await addFavorite(servantId);
    }
  }

  Future<void> addFavorite(int servantId) async {
    final db = await _dbHelper.database;
    await db.insert(DatabaseHelper.favoritesTable, {'servantId': servantId});
  }

  Future<void> removeFavorite(int servantId) async {
    final db = await _dbHelper.database;
    await db.delete(DatabaseHelper.favoritesTable,
        where: 'servantId = ?', whereArgs: [servantId]);
  }

  Future<List<int>> getFavorites() async {
    final db = await _dbHelper.database;
    final List<Map<String, dynamic>> maps =
        await db.query(DatabaseHelper.favoritesTable);
    print('get favorite : ${maps}');
    return List.generate(maps.length, (i) {
      return maps[i]['servantId'];
    });
  }
}
