# Приспособленец/Легковес

> **Также известен как:** Приспособленец,  Кэш,  Flyweight

## Суть паттерна

**Легковес** — это структурный паттерн проектирования, который позволяет вместить бóльшее количество объектов в отведённую оперативную память. Легковес экономит память, разделяя общее состояние объектов между собой, вместо хранения одинаковых данных в каждом объекте.


Паттерн Легковес предлагает не хранить в классе внешнее состояние, а передавать его в те или иные методы через параметры. Таким образом, одни и те же объекты можно будет повторно использовать в различных контекстах. Но главное — понадобится гораздо меньше объектов, ведь теперь они будут отличаться только внутренним состоянием, а оно имеет не так много вариаций.


Преимущества:

- Экономит оперативную память

Недостатки:

- Расходует процессорное время на поиск/вычисление контекста.
- Усложняет код программы из-за введения множества дополнительных классов.


```dart
abstract class EnglishCharacter {
  String _symbol;
  int _width;
  int _height;

  EnglishCharacter(this._symbol, this._width, this._height);

  void printCharacter();
}

class CharacterA extends EnglishCharacter {
  CharacterA() : super('A', 10, 20);

  @override
  void printCharacter() {
    print("Symbol = " +
        _symbol +
        " Width = " +
        _width.toString() +
        " Height = " +
        _height.toString());
  }
}

class CharacterB extends EnglishCharacter {
  CharacterB() : super('B', 10, 20);

  @override
  void printCharacter() {
    print("Symbol = " +
        _symbol +
        " Width = " +
        _width.toString() +
        " Height = " +
        _height.toString());
  }
}

class CharacterC extends EnglishCharacter {
  CharacterC() : super('C', 10, 20);

  @override
  void printCharacter() {
    print("Symbol = " +
        _symbol +
        " Width = " +
        _width.toString() +
        " Height = " +
        _height.toString());
  }
}

class FlyweightFactory {
  Map<int, EnglishCharacter> _characters = {};

  EnglishCharacter getCharacter(int characterCode) {
    EnglishCharacter character = _characters[characterCode];
    if (character == null) {
      switch (characterCode) {
        case 1:
          {
            character = new CharacterA();
            break;
          }
        case 2:
          {
            character = new CharacterB();
            break;
          }
        case 3:
          {
            character = new CharacterC();
            break;
          }
      }
      _characters[characterCode] = character;
    }
    return character;
  }
}

/* 
 * Класс, показывающий работу шаблона проектирования "Приспособленец".
 * */
void main(List<String> args) {
  FlyweightFactory factory = new FlyweightFactory();

  final characterCodes = [1, 2, 3];

  characterCodes.forEach((nextCode) {
    EnglishCharacter character = factory.getCharacter(nextCode);
    character.printCharacter();
  });
}
```