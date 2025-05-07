import 'package:tetsu_prep_plan_maker/model/cake/cake.dart';
import 'package:tetsu_prep_plan_maker/model/ingredient/madeleine.dart';

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

  factory Ingredients.fromJson(Map<String, dynamic> json) {
    return Ingredients(
      creamCheese: json['creamCheese'] ?? 0,
      butter: json['butter'] ?? 0,
      milk: json['milk'] ?? 0,
      flour: json['flour'] ?? 0,
      sugar: json['sugar'] ?? 0,
      eggWhite: json['eggWhite'] ?? 0,
      eggYolk: json['eggYolk'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'creamCheese': creamCheese,
      'butter': butter,
      'milk': milk,
      'flour': flour,
      'sugar': sugar,
      'eggWhite': eggWhite,
      'eggYolk': eggYolk,
    };
  }

  List<String> toList(Madeleine madeleine) {
    return [
      '${(creamCheese / 20000).toStringAsFixed(1)} Box',
      '${((butter + madeleine.butter) / 11350).toStringAsFixed(1)} Box', // 454 * 25 = 11350
      '${(milk / 4000).toStringAsFixed(1)} Bag', // 1000 * 4 = 4000
      '${((flour + madeleine.flour) / 20000).toStringAsFixed(1)} Bag', // 1000 * 20 = 20000
      '${((sugar + madeleine.sugar) / 20000).toStringAsFixed(1)} Bag', // 1000 * 20 = 20000
      '${((eggWhite + madeleine.eggWhite) / 500).round()} Pcs',
      '${((eggYolk + madeleine.eggYolk) / 10000).toStringAsFixed(1)} Box', // 1000 * 10 = 10000
    ];
  }

  List<String> getCheeseButterSummary() {
    return [
      '${(creamCheese / 20000).toStringAsFixed(1)} Box',
      '${(butter / 11350).toStringAsFixed(1)} Box', // 454 * 25 = 11350]
    ];
  }

  List<Map<String, List<int>>> getPrepPlanSummaryList(Cake cakeVal) {
    List<Map<String, List<int>>> result = [];

    // Standard cakes mapping
    Map<String, Ingredients Function(int)> standardCakes = {
      "og": Ingredients.ogCake,
      "cc": Ingredients.ccCake,
      "mc": Ingredients.mcCake,
    };

    // Standard cake calculations
    Map<String, int> cakeValues = {
      "og": cakeVal.ogCake,
      "cc": cakeVal.ccCake,
      "mc": cakeVal.mtCake,
    };

    Map<String, List<int>> baseDivisors = {
      "og": [1100, 500],
      "cc": [700, 500],
      "mc": [1000, 200],
    };

    for (var entry in standardCakes.entries) {
      int cakeCount = cakeValues[entry.key] ?? 0;
      if (cakeCount > 0) {
        Ingredients ingredients = entry.value(cakeCount);
        result.add({
          entry.key: [
            (ingredients.creamCheese / baseDivisors[entry.key]![0]).toInt(),
            (ingredients.butter / baseDivisors[entry.key]![1]).toInt(),
          ]
        });
      }
    }

    // Map of special cakes and their corresponding ingredient functions
    Map<String, Function(int)> specialCakes = {
      'vbCake': Ingredients.vbCake,
      'hjCake': Ingredients.hjCake,
      'hyCake': Ingredients.hyCake,
      'yzCake': Ingredients.yzCake,
    };

    // Base divisors for special cakes
    Map<String, List<int>> specialBaseDivisors = {
      "vbCake": [940, 250],
      "hjCake": [857, 200],
      "hyCake": [940, 400],
      "yzCake": [1150, 400],
    };

    // Find the first special cake that has a value > 0
    for (var entry in specialCakes.entries) {
      int value = cakeVal.toJson()[entry.key] ?? 0;
      if (value > 0) {
        Ingredients ingredients = entry.value(value);
        result.add({
          "sc": [
            (ingredients.creamCheese / specialBaseDivisors[entry.key]![0])
                .toInt(),
            (ingredients.butter / specialBaseDivisors[entry.key]![1]).toInt(),
          ]
        });
        return result; // Stop after the first found special cake
      }
    }
    return result;
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
      int value = cakeVal.toJson()[cakeType] ?? 0;
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
