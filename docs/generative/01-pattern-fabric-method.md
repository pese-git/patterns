## Фабричный метод

> **Также известен как:** Виртуальный конструктор,  Factory Method

### Суть паттерна

**Фабричный метод** — это порождающий паттерн проектирования, который определяет общий интерфейс для создания объектов в суперклассе, позволяя подклассам изменять тип создаваемых объектов.

Паттерн Фабричный метод предлагает создавать объекты не напрямую, используя оператор `new`, а через вызов особого фабричного метода.

Преимущества:

 - Избавляет класс от привязки к конкретным классам продуктов.
 - Выделяет код производства продуктов в одно место, упрощая поддержку кода.
 - Упрощает добавление новых продуктов в программу.
 - Реализует принцип открытости/закрытости.

 Недостатки:

 - Может привести к созданию больших параллельных иерархий классов, так как для каждого класса продукта надо создать свой подкласс создателя.


Пример:

```dart
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

main(List<String> args) {
  CoinMainer mainer = new LiteCoinMainer();
  mainer.working();
}

```