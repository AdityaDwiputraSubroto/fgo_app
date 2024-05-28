// controllers/servant_controller.dart
import 'package:flutter/material.dart';
import '../models/servant.dart';
import '../services/servant_service.dart';

class ServantController extends ChangeNotifier {
  final ServantService _servantService = ServantService();
  ValueNotifier<List<Servant>> searchedServants = ValueNotifier([]);
  List<Servant> servants = [];
  ValueNotifier<bool> isLoading = ValueNotifier(true);
  ValueNotifier<ServantDetail?> servantDetail = ValueNotifier(null);

  Future<void> fetchServants() async {
    try {
      final fetchedServants = await _servantService.fetchServants();
      searchedServants.value = fetchedServants;
      servants = fetchedServants;
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
}
