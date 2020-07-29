# Цепочка обязанностей


> **Также известен как:** CoR,  Chain of Command,  Chain of Responsibility

## Суть паттерна

**Цепочка обязанностей** — это поведенческий паттерн проектирования, который позволяет передавать запросы последовательно по цепочке обработчиков. Каждый последующий обработчик решает, может ли он обработать запрос сам и стоит ли передавать запрос дальше по цепи.


Цепочка обязанностей базируется на том, чтобы превратить отдельные поведения в объекты.

Паттерн предлагает связать объекты обработчиков в одну цепь. Каждый из них будет иметь ссылку на следующий обработчик в цепи. Таким образом, при получении запроса обработчик сможет не только сам что-то с ним сделать, но и передать обработку следующему объекту в цепочке.

Преимущества:

 - Уменьшает зависимость между клиентом и обработчиками.
 - Реализует принцип единственной обязанности.
 - Реализует принцип открытости/закрытости.

Недостатки:
 - Запрос может остаться никем не обработанным.



Пример:

```dart
final ERR = 3;
final NOTICE = 5;
final DEBUG = 7;

abstract class Logger {
  int _mask;

  // The next element in the chain of responsibility
  Logger _next;

  Logger(this._mask);

  Logger setNext(Logger log) {
    _next = log;
    return log;
  }

  void message(String msg, int priority) {
    if (priority <= _mask) {
      writeMessage(msg);
    }
    if (_next != null) {
      _next.message(msg, priority);
    }
  }

  void writeMessage(String msg);
}

class StdoutLogger extends Logger {
  StdoutLogger(int mask) : super(mask);

  @override
  void writeMessage(String msg) {
    print("Writing to stdout: " + msg);
  }
}

class EmailLogger extends Logger {
  EmailLogger(int mask) : super(mask);

  @override
  void writeMessage(String msg) {
    print("Sending via email: " + msg);
  }
}

class StderrLogger extends Logger {
  StderrLogger(int mask) : super(mask);

  @override
  void writeMessage(String msg) {
    print("Sending to stderr: " + msg);
  }
}

void main(List<String> args) {
  // Build the chain of responsibility
  Logger logger, logger1, logger2;
  logger = new StdoutLogger(DEBUG);
  logger1 = logger.setNext(new EmailLogger(NOTICE));
  logger2 = logger1.setNext(new StderrLogger(ERR));

  // Handled by StdoutLogger
  logger.message("Entering function y.", DEBUG);

  // Handled by StdoutLogger and EmailLogger
  logger.message("Step1 completed.", NOTICE);

  // Handled by all three loggers
  logger.message("An error has occurred.", ERR);
}

```