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