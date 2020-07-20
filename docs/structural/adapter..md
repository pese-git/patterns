## Адаптер

> **Также известен как:** Wrapper,  Обёртка,  Adapter


### Суть паттерна

**Адаптер** — это структурный паттерн проектирования, который позволяет объектам с несовместимыми интерфейсами работать вместе.


Адаптеры могут не только переводить данные из одного формата в другой, но и помогать объектам с разными интерфейсами работать сообща.


Преимущества:

- Отделяет и скрывает от клиента подробности преобразования различных интерфейсов.

Недостатки:

- Усложняет код программы из-за введения дополнительных классов.


Пример:

```dart
abstract class USB {
  void connectWithUsbCable();
}

class MemoryCard {
  void insert() {
    print("Карта памяти успешно вставлена!");
  }

  void copyData() {
    print("Данные скопированы на компьютер!");
  }
}

class CardReader extends USB {
  MemoryCard memoryCard;

  CardReader(this.memoryCard);

  @override
  void connectWithUsbCable() {
    this.memoryCard.insert();
    this.memoryCard.copyData();
  }
}

main(List<String> args) {
  final memoryCard = MemoryCard();
  final cardReader = CardReader(memoryCard);

  cardReader.connectWithUsbCable();
}

```