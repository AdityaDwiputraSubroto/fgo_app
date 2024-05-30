import 'package:flutter/material.dart';
import '../models/servant.dart';
import '../services/servant_service.dart';

class ServantController {
  final ServantService _servantService = ServantService();
  ValueNotifier<List<Servant>> searchedServants = ValueNotifier([]);
  static List<Servant> servants = [];
  List<Servant> favorites = [];
  ValueNotifier<bool> isLoading = ValueNotifier(true);
  ValueNotifier<ServantDetail?> servantDetail = ValueNotifier(null);

  Future<void> fetchServants() async {
    try {
      if (servants.isNotEmpty) {
        searchedServants.value = servants;
        return;
      }
      final fetchedServants = await _servantService.fetchServants();
      searchedServants.value = fetchedServants;
      servants = fetchedServants;
      print("fetch servant success");
    } catch (e) {
      print(e);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchServantDetail(int id) async {
    try {
      servantDetail.value = await _servantService.fetchServantDetail(id);
    } catch (e) {
      print(e);
    } finally {
      isLoading.value = false;
    }
  }

  void deleteFavorite(int id) {
    favorites.removeWhere((element) => element.id == id);
  }

  void searchServants(String query) {
    if (query.isEmpty) {
      searchedServants.value = servants;
    } else {
      searchedServants.value = servants
          .where((servant) =>
              servant.name.toLowerCase().contains(query.toLowerCase()) ||
              servant.className.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
  }

  void searchFavorites(String query) {
    if (query.isEmpty) {
      searchedServants.value = favorites;
    } else {
      searchedServants.value = favorites
          .where((servant) =>
              servant.name.toLowerCase().contains(query.toLowerCase()) ||
              servant.className.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
  }

  int getServantIndex(int servantId) {
    return servants.indexWhere((s) => s.id == servantId);
  }

  Future<void> getFavoritedServants() async {
    favorites =
        servants.where((servant) => servant.isFavorite == true).toList();
    searchedServants.value = favorites;
  }

  Future<void> toggleFavorite(int servantId) async {
    try {
      //int index = servants.indexWhere((s) => s.id == servantId);

      int index = getServantIndex(servantId);
      servants[index].isFavorite = !servants[index].isFavorite;

      await _servantService.toggleFavorite(
          servantId, servants[index].isFavorite);
      print("favorite success");
    } catch (e) {
      print("error favorite : $e");
    }
  }
}
