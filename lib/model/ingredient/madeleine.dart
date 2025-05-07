class Madeleine {
  // Ingredient properties
  int flour;
  int sugar;
  int butter;
  int honey;
  int bakingPowder;
  int eggWhite;
  int eggYolk;

  Madeleine({
    required this.flour,
    required this.sugar,
    required this.butter,
    required this.honey,
    required this.bakingPowder,
    required this.eggWhite,
    required this.eggYolk,
  });

  List<String> toList() {
    return [
      '${(flour / 20000).toStringAsFixed(1)} Bag',
      '${(sugar / 20000).toStringAsFixed(1)} Bag',
      '${(butter / 11350).toStringAsFixed(1)} Box',
      '${(honey / 150000).toStringAsFixed(1)} Bucket',
      '${(bakingPowder / 450).toStringAsFixed(1)} Pack',
      '${(eggWhite / 500).round()} Pcs',
      '${(eggYolk / 10000).toStringAsFixed(1)} Box',
    ];
  }

  factory Madeleine.half(int multiplyVal) {
    return Madeleine(
      flour: 638 * multiplyVal,
      sugar: 315 * multiplyVal,
      butter: 625 * multiplyVal,
      honey: 275 * multiplyVal,
      bakingPowder: 26 * multiplyVal,
      eggWhite: 428 * multiplyVal,
      eggYolk: 275 * multiplyVal,
    );
  }

  factory Madeleine.empty() {
    return Madeleine(
      flour: 0,
      sugar: 0,
      butter: 0,
      honey: 0,
      bakingPowder: 0,
      eggWhite: 0,
      eggYolk: 0,
    );
  }

  Madeleine add(Madeleine other) {
    return Madeleine(
      flour: flour + other.flour,
      sugar: sugar + other.sugar,
      butter: butter + other.butter,
      honey: honey + other.honey,
      bakingPowder: bakingPowder + other.bakingPowder,
      eggWhite: eggWhite + other.eggWhite,
      eggYolk: eggYolk + other.eggYolk,
    );
  }

  factory Madeleine.totalRequired(int madVal) {
    return Madeleine.empty().add(Madeleine.half(madVal));
  }
}
