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
