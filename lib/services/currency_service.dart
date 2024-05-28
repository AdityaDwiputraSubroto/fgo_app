import 'dart:convert';
import 'package:fgo_app/models/currency.dart';
import 'package:http/http.dart' as http;

class CurrencyService {
  final String apiUrl =
      'https://v6.exchangerate-api.com/v6/fe4e52059eeb81f211dac145/latest/';

  Future<Currency> fetchRates(String baseCurrency) async {
    final response = await http.get(Uri.parse('$apiUrl$baseCurrency'));

    if (response.statusCode == 200) {
      return Currency.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load exchange rates');
    }
  }
}
