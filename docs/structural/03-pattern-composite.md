# Компоновщик

> **Также известен как:** Дерево,  Composite

## Суть паттерна


Компоновщик — это структурный паттерн проектирования, который позволяет сгруппировать множество объектов в древовидную структуру, а затем работать с ней так, как будто это единичный объект.


Компоновщик предлагает рассматривать разные объекты, которые могут быть вложены друг в друга, через единый интерфейс с общими методами.

Преимущества:

-  Упрощает архитектуру клиента при работе со сложным деревом компонентов.
- Облегчает добавление новых видов компонентов.

Недостатки:

- Создаёт слишком общий дизайн классов.


Пример:

```dart
abstract class Graphic {
  void move(int x, int y);
  void draw();
}

class Dot extends Graphic {
  int _x;
  int _y;

  Dot(this._x, this._y);

  @override
  void draw() {
    print("Нарисовать точку");
  }

  @override
  void move(int x, int y) {
    this._x = x;
    this._y = y;
  }
}

class Circle extends Dot {
  int _radius;

  Circle(this._radius, int x, int y) : super(x, y);

  @override
  void draw() {
    print("Нарисовать окружность в координате X, Y и радиусом R.");
  }
}

class CompoundGraphic extends Graphic {
  List<Graphic> _children = [];

  void add(Graphic child) {
    this._children.add(child);
  }

  void remove(Graphic child) {
    this._children.remove(child);
  }

  @override
  void draw() {
    this._children.forEach((element) {
      element.draw();
    });
  }

  @override
  void move(int x, int y) {
    this._children.forEach((element) {
      element.move(x, y);
    });
  }
}

class ImageEditor {
  CompoundGraphic _all = CompoundGraphic();

  void load() {
    this._all = CompoundGraphic();
    this._all.add(Dot(1, 2));
    this._all.add(Circle(5, 3, 10));
  }

  void groupSelected(List<Graphic> components) {
    final group = CompoundGraphic();
    components.forEach((element) {
      group.add(element);
    });
    this._all.add(group);
    this._all.draw();
  }
}

void main(List<String> args) {
  final editor = ImageEditor();
  editor.load();
  editor.groupSelected([Circle(10, 10, 10)]);
}
```