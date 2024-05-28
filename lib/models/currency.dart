class Currency {
  final String base;
  final Map<String, double> rates;

  Currency({required this.base, required this.rates});

  factory Currency.fromJson(Map<String, dynamic> json) {
    Map<String, double> rates = {};
    json['conversion_rates'].forEach((key, value) {
      rates[key] = value.toDouble();
    });

    return Currency(
      base: json['base_code'],
      rates: rates,
    );
  }
}
