import 'package:fgo_app/models/currency.dart';
import 'package:fgo_app/services/currency_service.dart';
import 'package:flutter/material.dart';

class CurrencyController {
  final CurrencyService _service = CurrencyService();
  Currency? currencyModel;

  Future<void> loadRates(BuildContext context, String baseCurrency) async {
    try {
      currencyModel = await _service.fetchRates(baseCurrency);
    } catch (e) {
      print("failed to load rates : $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to load rates : $e'),
        ),
      );
    }
  }

  double? convert(
      BuildContext context, fromCurrency, String toCurrency, double amount) {
    try {
      if (currencyModel != null) {
        double fromRate = currencyModel!.rates[fromCurrency] ?? 1;
        double toRate = currencyModel!.rates[toCurrency] ?? 1;
        return amount * toRate / fromRate;
      }
      return null;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to convert : $e'),
        ),
      );
    }
  }
}
