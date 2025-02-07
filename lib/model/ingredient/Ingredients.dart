import 'package:tetsu_prep_plan_maker/model/cake/cake.dart';

class Ingredients {
  // Properties for each ingredient
  int creamCheese;
  int butter;
  int milk;
  int flour;
  int sugar;
  int eggWhite;
  int eggYolk;

  Ingredients({
    required this.creamCheese,
    required this.butter,
    required this.milk,
    required this.flour,
    required this.sugar,
    required this.eggWhite,
    required this.eggYolk,
  });

  @override
  String toString() {
    return 'Ingredients(creamCheese: $creamCheese, butter: $butter, milk: $milk, '
        'flour: $flour, sugar: $sugar, eggWhite: $eggWhite, eggYolk: $eggYolk)';
  }

  List<String> toList() {
    return [
      '${(creamCheese / 1000).toStringAsFixed(1)} Kg',
      '${((butter / 454) / 25).toStringAsFixed(1)} Box',
      '${((milk / 1000) / 4).toStringAsFixed(1)} Bag',
      '${((flour / 1000) / 20).toStringAsFixed(1)} Bag',
      '${((sugar / 1000) / 20).toStringAsFixed(1)} Bag',
      '${(eggWhite / 500).round()} Pcs',
      '${((eggYolk / 1000) / 10).toStringAsFixed(1)} Box',
    ];
  }

  factory Ingredients.empty() {
    return Ingredients(
      creamCheese: 0,
      butter: 0,
      milk: 0,
      flour: 0,
      sugar: 0,
      eggWhite: 0,
      eggYolk: 0,
    );
  }

  Ingredients add(Ingredients other) {
    return Ingredients(
      creamCheese: creamCheese + other.creamCheese,
      butter: butter + other.butter,
      milk: milk + other.milk,
      flour: flour + other.flour,
      sugar: sugar + other.sugar,
      eggWhite: eggWhite + other.eggWhite,
      eggYolk: eggYolk + other.eggYolk,
    );
  }

  factory Ingredients.ogCake(int multiplyVal) {
    return Ingredients(
      creamCheese: 1100 * multiplyVal,
      butter: 500 * multiplyVal,
      milk: 1100 * multiplyVal,
      flour: 420 * multiplyVal,
      sugar: 515 * multiplyVal,
      eggWhite: 700 * multiplyVal,
      eggYolk: 420 * multiplyVal,
    );
  }
  factory Ingredients.ccCake(int multiplyVal) {
    return Ingredients(
      creamCheese: 770 * multiplyVal,
      butter: 500 * multiplyVal,
      milk: 1100 * multiplyVal,
      flour: 420 * multiplyVal,
      sugar: 630 * multiplyVal,
      eggWhite: 1100 * multiplyVal,
      eggYolk: 400 * multiplyVal,
    );
  }
  factory Ingredients.mcCake(int multiplyVal) {
    return Ingredients(
      creamCheese: 1000 * multiplyVal,
      butter: 200 * multiplyVal,
      milk: 900 * multiplyVal,
      flour: 280 * multiplyVal,
      sugar: 700 * multiplyVal,
      eggWhite: 900 * multiplyVal,
      eggYolk: 320 * multiplyVal,
    );
  }
  factory Ingredients.vbCake(int multiplyVal) {
    return Ingredients(
      creamCheese: 940 * multiplyVal,
      butter: 250 * multiplyVal,
      milk: 500 * multiplyVal,
      flour: 350 * multiplyVal,
      sugar: 400 * multiplyVal,
      eggWhite: 770 * multiplyVal,
      eggYolk: 340 * multiplyVal,
    );
  }

  factory Ingredients.hjCake(int multiplyVal) {
    return Ingredients(
      creamCheese: 857 * multiplyVal,
      butter: 200 * multiplyVal,
      milk: 857 * multiplyVal,
      flour: 261 * multiplyVal,
      sugar: 250 * multiplyVal,
      eggWhite: 900 * multiplyVal,
      eggYolk: 300 * multiplyVal,
    );
  }

  factory Ingredients.hyCake(int multiplyVal) {
    return Ingredients(
      creamCheese: 940 * multiplyVal,
      butter: 400 * multiplyVal,
      milk: 840 * multiplyVal,
      flour: 355 * multiplyVal,
      sugar: 440 * multiplyVal,
      eggWhite: 770 * multiplyVal,
      eggYolk: 355 * multiplyVal,
    );
  }

  factory Ingredients.yzCake(int multiplyVal) {
    return Ingredients(
      creamCheese: 1150 * multiplyVal,
      butter: 400 * multiplyVal,
      milk: 670 * multiplyVal,
      flour: 415 * multiplyVal,
      sugar: 450 * multiplyVal,
      eggWhite: 950 * multiplyVal,
      eggYolk: 420 * multiplyVal,
    );
  }

  factory Ingredients.totalRequired(Cake cakeVal) {
    Ingredients returnVal = Ingredients.empty();

    // List of all cake keys
    List<String> cakeTypes = [
      'ogCake',
      'ccCake',
      'mtCake',
      'vbCake',
      'hjCake',
      'hyCake',
      'yzCake'
    ];

    // Iterate over the cake types and add the respective Ingredients if the value is non-zero
    for (String cakeType in cakeTypes) {
      int value = cakeVal.toMap()[cakeType] ?? 0;
      if (value > 0) {
        // Dynamically call the Ingredients method based on the cakeType
        switch (cakeType) {
          case 'ogCake':
            returnVal = returnVal.add(Ingredients.ogCake(value));
            break;
          case 'ccCake':
            returnVal = returnVal.add(Ingredients.ccCake(value));
            break;
          case 'mtCake':
            returnVal = returnVal.add(Ingredients.mcCake(value));
            break;
          case 'vbCake':
            returnVal = returnVal.add(Ingredients.vbCake(value));
            break;
          case 'hjCake':
            returnVal = returnVal.add(Ingredients.hjCake(value));
            break;
          case 'hyCake':
            returnVal = returnVal.add(Ingredients.hyCake(value));
            break;
          case 'yzCake':
            returnVal = returnVal.add(Ingredients.yzCake(value));
            break;
          default:
            break;
        }
      }
    }

    return returnVal;
  }
}
