## Мост


> **Также известен как:** Bridge


### Суть паттерна

**Мост** — это структурный паттерн проектирования, который разделяет один или несколько классов на две отдельные иерархии — абстракцию и реализацию, позволяя изменять их независимо друг от друга.


Паттерн Мост предлагает заменить наследование агрегацией или композицией. Для этого нужно выделить одну из таких «плоскостей» в отдельную иерархию и ссылаться на объект этой иерархии, вместо хранения его состояния и поведения внутри одного класса.



Преимущества:

- Позволяет строить платформо-независимые программы.
- Скрывает лишние или опасные детали реализации от клиентского кода.
- Реализует принцип открытости/закрытости.

Недостатки:

- Усложняет код программы из-за введения дополнительных классов.

Пример:

```dart
abstract class Device {
  bool isEnabled();
  void enable();
  void disable();
  int getVolume();
  void setVolume(int percent);
  int getChannel();
  void setChannel(channel);
}

class TV extends Device {
  int _channel = 0;
  int _percent = 0;
  bool _isSwiched = false;
  @override
  void disable() {
    _isSwiched = false;
  }

  @override
  void enable() {
    _isSwiched = true;
  }

  @override
  int getChannel() {
    return _channel;
  }

  @override
  int getVolume() {
    return _percent;
  }

  @override
  bool isEnabled() {
    return _isSwiched;
  }

  @override
  void setChannel(channel) {
    _channel = channel;
  }

  @override
  void setVolume(percent) {
    _percent = percent;
  }
}

class Radio extends Device {
  int _channel = 0;
  int _percent = 0;
  bool _isSwiched = false;

  @override
  void disable() {
    _isSwiched = false;
  }

  @override
  void enable() {
    _isSwiched = true;
  }

  @override
  int getChannel() {
    return _channel;
  }

  @override
  int getVolume() {
    return _percent;
  }

  @override
  bool isEnabled() {
    return _isSwiched;
  }

  @override
  void setChannel(channel) {
    _channel = channel;
  }

  @override
  void setVolume(percent) {
    _percent = percent;
  }
}

class Remote {
  Device _device;

  Remote(this._device);

  void togglePower() {
    print("TOGGLE_POWER");
    if (_device.isEnabled()) {
      _device.disable();
    } else {
      _device.enable();
    }
  }

  void volumeDown() {
    _device.setVolume(_device.getVolume() - 10);
  }

  void volumeUp() {
    _device.setVolume(_device.getVolume() + 10);
  }

  void channelDown() {
    _device.setChannel(_device.getChannel() - 1);
  }

  void channelUp() {
    _device.setChannel(_device.getChannel() + 1);
  }
}

class AdvancedRemote extends Remote {
  AdvancedRemote(Device device) : super(device);

  void mute() {
    print("MUTE");
    _device.setVolume(0);
  }
}

void main(List<String> args) {
  final tv = TV();
  final remote = Remote(tv);
  remote.togglePower();

  final radio = Radio();
  final remote1 = AdvancedRemote(radio);
  remote1.mute();
}
```