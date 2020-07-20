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
