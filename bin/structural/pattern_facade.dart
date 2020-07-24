/* Complex parts */

class CPU {
  void freeze() {}
  void jump(position) {}
  void execute() {}
}

class Memory {
  void load(position, data) {}
}

class HardDrive {
  dynamic read(lba, size) {}
}

/* Facade */
final BOOT_ADDRESS = 0x00001;
final BOOT_SECTOR = 0x000024;
final SECTOR_SIZE = 0x512;

class Computer {
  CPU _cpu;
  Memory _memory;
  HardDrive _hardDrive;

  Computer() {
    this._cpu = new CPU();
    this._memory = new Memory();
    this._hardDrive = new HardDrive();
  }

  void startComputer() {
    print("Start loading");
    _cpu.freeze();
    _memory.load(BOOT_ADDRESS, _hardDrive.read(BOOT_SECTOR, SECTOR_SIZE));
    _cpu.jump(BOOT_ADDRESS);
    _cpu.execute();
    print("Finish loading");
  }
}

void main(List<String> args) {
  Computer computer = new Computer();
  computer.startComputer();
}
