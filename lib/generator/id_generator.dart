import 'dart:math';

class IdGenerator {
  final int key = Random().nextInt(2 ^ 32);

  bool isRelPrime(int gcd) {
    return gcd == 1;
  }

  int generateId() {
    int p = Random().nextInt(2 ^ 32);
    int q = Random().nextInt(2 ^ 32);
    int phi = (p - 1) * (q - 1);

    List possibilities = <int>[];

    for (int i = 0; i < 2 ^ 32; i++) {
      int x = Random().nextInt(2 ^ 32);
      if (isRelPrime(x.gcd(phi))) {
        possibilities.add(x);
      }
    }

    String id = "";
    for (int i = 0; i < 10; i++) {
      id += possibilities
          .elementAt(Random().nextInt(
              possibilities.length < 50 ? possibilities.length - 1 : 50))
          .toString();
    }
    id = id.substring(0, 5);
    return int.parse(id);
  }
}
