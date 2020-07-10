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