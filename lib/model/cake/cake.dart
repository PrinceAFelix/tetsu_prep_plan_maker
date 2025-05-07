class Cake {
  final int ogCake;
  final int ccCake;
  final int mtCake;
  final int vbCake;
  final int hjCake;
  final int hyCake;
  final int yzCake;

  Cake({
    required this.ogCake,
    required this.ccCake,
    required this.mtCake,
    required this.vbCake,
    required this.hjCake,
    required this.hyCake,
    required this.yzCake,
  });

  @override
  String toString() {
    return 'Cake(ogCake: $ogCake, ccCake: $ccCake, mtCake: $mtCake, '
        'vbCake: $vbCake, hjCake: $hjCake, hyCake: $hyCake, yzCake: $yzCake)';
  }

  factory Cake.defaultValues() {
    return Cake(
      ogCake: 0,
      ccCake: 0,
      mtCake: 0,
      vbCake: 0,
      hjCake: 0,
      hyCake: 0,
      yzCake: 0,
    );
  }

  Map<String, int> toJson() {
    return {
      'ogCake': ogCake,
      'ccCake': ccCake,
      'mtCake': mtCake,
      'vbCake': vbCake,
      'hjCake': hjCake,
      'hyCake': hyCake,
      'yzCake': yzCake,
    };
  }

  factory Cake.fromJson(Map<String, dynamic> json) {
    return Cake(
      ogCake: json['ogCake'] ?? 0,
      ccCake: json['ccCake'] ?? 0,
      mtCake: json['mtCake'] ?? 0,
      vbCake: json['vbCake'] ?? 0,
      hjCake: json['hjCake'] ?? 0,
      hyCake: json['hyCake'] ?? 0,
      yzCake: json['yzCake'] ?? 0,
    );
  }

  factory Cake.withFlashcard({
    required int og,
    required int cc,
    required int mt,
    required Map<String?, int?> special,
  }) {
    int vb = 0, hj = 0, hy = 0, yz = 0;

    if (special.values.first != null) {
      switch (special.keys.first) {
        case 'vbCake':
          vb = special.values.first!;
          break;
        case 'hjCake':
          hj = special.values.first!;
          break;
        case 'hyCake':
          hy = special.values.first!;
          break;
        case 'yzCake':
          yz = special.values.first!;
          break;
        default:
          break;
      }
    }

    return Cake(
      ogCake: og,
      ccCake: cc,
      mtCake: mt,
      vbCake: vb,
      hjCake: hj,
      hyCake: hy,
      yzCake: yz,
    );
  }
}
