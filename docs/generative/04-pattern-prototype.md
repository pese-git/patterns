
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

