# Порождающие паттерны проектирования

> Эти паттерны отвечают за удобное и безопасное создание новых объектов или даже целых семейств объектов.

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


## Абстрактная фабрика

> **Также известен как:** Abstract Factory


### Суть паттерна

**Абстрактная фабрика** — это порождающий паттерн проектирования, который позволяет создавать семейства связанных объектов, не привязываясь к конкретным классам создаваемых объектов.

Абстрактная фабрика предлагает выделить общие интерфейсы для отдельных продуктов, составляющих семейства.

||блокнот|журнал|книга
---|---|--|---
Бумага|Бум блокнот|Бум журнад| Бум книга
Электро| Эл блокнот|Эл журнал | Эл книга

Преимущества:

 - Гарантирует сочетаемость создаваемых продуктов.
 - Избавляет клиентский код от привязки к конкретным классам продуктов.
 - Выделяет код производства продуктов в одно место, упрощая поддержку кода.
 - Упрощает добавление новых продуктов в программу.
 - Реализует принцип открытости/закрытости.

Недостатки:

 - Усложняет код программы из-за введения множества дополнительных классов.
 - Требует наличия всех типов продуктов в каждой вариации.



Пример: 

```dart
abstract class Notepad {}

abstract class Magazine {}

abstract class Book {}

class PaperNotepad extends Notepad {}

class PaperMagazine extends Magazine {}

class PaperBook extends Book {}

class ElectronicNotepad extends Notepad {}

class ElectronicMagazine extends Magazine {}

class ElectronicBook extends Book {}

abstract class InfoFactory {
  Book createBook();
  Magazine createMagazine();
  Notepad createNotepad();
}

class PaperInfoFactory extends InfoFactory {
  @override
  Book createBook() {
    return PaperBook();
  }

  @override
  Magazine createMagazine() {
    return PaperMagazine();
  }

  @override
  Notepad createNotepad() {
    return PaperNotepad();
  }
}

class ElectronicInfoFactory extends InfoFactory {
  @override
  Book createBook() {
    return ElectronicBook();
  }

  @override
  Magazine createMagazine() {
    return ElectronicMagazine();
  }

  @override
  Notepad createNotepad() {
    return ElectronicNotepad();
  }
}

main(List<String> args) {
  final config = "electronic";
  InfoFactory factory;
  if (config == "paper") {
    factory = new PaperInfoFactory();
  } else if (config == "electronic") {
    factory = new ElectronicInfoFactory();
  } else {
    throw new Exception("Error! Unknown info type.");
  }
  print("FACTORY: " + factory.createBook().toString());
}

```

## Строитель

> **Также известен как:** Builder

## Суть паттерна

**Строитель** — это порождающий паттерн проектирования, который позволяет создавать сложные объекты пошагово. Строитель даёт возможность использовать один и тот же код строительства для получения разных представлений объектов.

Паттерн Строитель предлагает вынести конструирование объекта за пределы его собственного класса, поручив это дело отдельным объектам, называемым строителями.

Паттерн предлагает разбить процесс конструирования объекта на отдельные шаги. Чтобы создать объект, вам нужно поочерёдно вызывать методы строителя. Причём не нужно запускать все шаги, а только те, что нужны для производства объекта определённой конфигурации.

Преимущества:

 - Позволяет создавать продукты пошагово.
 - Позволяет использовать один и тот же код для создания различных продуктов.
 - Изолирует сложный код сборки продукта от его основной бизнес-логики.

Недостатки:

 - Усложняет код программы из-за введения дополнительных классов.
 - Клиент будет привязан к конкретным классам строителей, так как в интерфейсе строителя может не быть метода получения результата.

Пример:

 ```dart
class Pizza {
  int _size;
  bool _peperony;
  bool _tomatos;
  bool _chees;

  Pizza(this._size, this._peperony, this._chees, this._tomatos);
}

class PizzaBuilder {
  int _size = 0;
  bool _peperony = false;
  bool _tomatos = false;
  bool _chees = false;

  PizzaBuilder setSize(int size) {
    this._size = size;
    return this;
  }

  PizzaBuilder setPeperony(bool peperony) {
    this._peperony = peperony;
    return this;
  }

  PizzaBuilder setTomatos(bool tomatos) {
    this._tomatos = tomatos;
    return this;
  }

  PizzaBuilder setChees(bool chees) {
    this._chees = chees;
    return this;
  }

  Pizza build() {
    return Pizza(this._size, this._peperony, this._tomatos, this._chees);
  }
}

main(List<String> args) {
  final builder = PizzaBuilder().setSize(32).setChees(true).setTomatos(true);
  print("Create Pizza: " + builder.build().toString());
}
 ```

## Прототип

> **Также известен как:** Клон,  Prototype

### Суть паттерна

**Прототип** — это порождающий паттерн проектирования, который позволяет копировать объекты, не вдаваясь в подробности их реализации.


Паттерн Прототип поручает создание копий самим копируемым объектам. Он вводит общий интерфейс для всех объектов, поддерживающих клонирование. Это позволяет копировать объекты, не привязываясь к их конкретным классам. Обычно такой интерфейс имеет всего один метод `clone`.


Преимущества:

- Позволяет клонировать объекты, не привязываясь к их конкретным классам.
- Меньше повторяющегося кода инициализации объектов.
- Ускоряет создание объектов.
- Альтернатива созданию подклассов для конструирования сложных объектов.

Недостатки:

- Сложно клонировать составные объекты, имеющие ссылки на другие объекты.


Пример:

```dart
abstract class Shape {
  int x;
  int y;
  String color;

  Shape.create();

  Shape(Shape shape) {
    this.x = shape.x;
    this.y = shape.y;
    this.color = shape.color;
  }

  Shape clone();
}

class Circle extends Shape {
  int radius;

  Circle.create() : super.create();

  Circle(Circle shape) : super(shape) {
    this.radius = shape.radius;
  }

  @override
  Shape clone() {
    return Circle(this);
  }
}

class Rectangle extends Shape {
  int width;
  int height;

  Rectangle.create() : super.create();

  Rectangle(Rectangle shape) : super(shape) {
    this.width = shape.width;
    this.height = shape.height;
  }

  @override
  Rectangle clone() {
    return Rectangle(this);
  }
}

main(List<String> args) {
  final shapes = <Shape>[];

  Circle circle = new Circle.create();
  circle.x = 10;
  circle.y = 10;
  circle.radius = 20;
  shapes.add(circle);

  Circle anotherCircle = circle.clone();
  shapes.add(anotherCircle);
  // anotherCircle будет содержать точную копию circle.

  Rectangle rectangle = new Rectangle.create();
  rectangle.width = 10;
  rectangle.height = 20;
  shapes.add(rectangle);

  for (var item in shapes) {
    print("SHAPE: " + item.toString());
  }
}

```


## Одиночка

> **Также известен как:** Singleton

### Суть паттерна


**Одиночка** — это порождающий паттерн проектирования, который гарантирует, что у класса есть только один экземпляр, и предоставляет к нему глобальную точку доступа.

Все реализации одиночки сводятся к тому, чтобы скрыть конструктор по умолчанию и создать публичный статический метод, который и будет контролировать жизненный цикл объекта-одиночки.

Преимущества:

- Гарантирует наличие единственного экземпляра класса.
- Предоставляет к нему глобальную точку доступа.
- Реализует отложенную инициализацию объекта-одиночки.

Недостатки:

- Нарушает принцип единственной ответственности класса.
- Маскирует плохой дизайн.
- Проблемы мультипоточности.
- Требует постоянного создания Mock-объектов при юнит-тестировании.


Пример:

```dart
class Database {
  static Database _instance;

  Database._() {}

  static Database getInstance() {
    if (_instance == null) {
      _instance = Database._();
    }
    return _instance;
  }

  void query(String query) {
    print("EXECUTE query: " + query);
  }
}

main(List<String> args) {
  final instance = Database.getInstance();
  instance.query("SELECT * WEHERE userId=1 FROM users");
}
```