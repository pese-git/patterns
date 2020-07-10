main(List<String> args) {
  CoinMainer mainer = new LiteCoinMainer();
  mainer.working();
}

abstract class CoinMainer {
  void working() {
    print("Maining coin: " + createCoin().toString());
  }

  //  Фабричный метод
  Coin createCoin();
}

class BitCoinMainer extends CoinMainer {
  @override
  Coin createCoin() {
    return BitCoin();
  }
}

class LiteCoinMainer extends CoinMainer {
  @override
  Coin createCoin() {
    return LiteCoin();
  }
}

abstract class Coin {}

class BitCoin extends Coin {}

class LiteCoin extends Coin {}
