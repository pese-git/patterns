abstract class DataSource {
  void writeData(data);
  dynamic readData();
}

class FileDataSouce extends DataSource {
  String _fileName;
  String _data = "";

  FileDataSouce(this._fileName);

  @override
  readData() {
    return this._data;
  }

  @override
  void writeData(data) {
    this._data = this._data + '\n' + data;
  }
}

// Родитель всех декораторов содержит код обёртывания.
class DataSourceDecorator extends DataSource {
  DataSource _wrapper;

  DataSourceDecorator(this._wrapper);

  @override
  readData() {
    return this._wrapper.readData();
  }

  @override
  void writeData(data) {
    this._wrapper.writeData(data);
  }
}

// Конкретные декораторы добавляют что-то своё к базовому
// поведению обёрнутого компонента.
class EncryptionDecorator extends DataSourceDecorator {
  EncryptionDecorator(DataSource wrapper) : super(wrapper);

  @override
  readData() {
    // 1. Получить данные из метода readData обёрнутого
    // объекта (wrappee).
    // 2. Расшифровать их, если они зашифрованы.
    // 3. Вернуть результат.
    return this._wrapper.readData();
  }

  @override
  void writeData(data) {
    // 1. Зашифровать поданные данные.
    // 2. Передать зашифрованные данные в метод writeData
    // обёрнутого объекта (wrappee).
    this._wrapper.writeData(data);
  }
}

// Декорировать можно не только базовые компоненты, но и уже
// обёрнутые объекты.
class CompressionDecorator extends DataSourceDecorator {
  CompressionDecorator(DataSource wrapper) : super(wrapper);

  @override
  readData() {
    // 1. Получить данные из метода readData обёрнутого
    // объекта (wrappee).
    // 2. Распаковать их, если они запакованы.
    // 3. Вернуть результат.
    return this._wrapper.readData();
  }

  @override
  void writeData(data) {
    // 1. Запаковать поданные данные.
    // 2. Передать запакованные данные в метод writeData
    // обёрнутого объекта (wrappee).
    this._wrapper.writeData(data);
  }
}

// Способ 1. Простой пример сборки и использования декораторов.
class Application {
  void dumbUsageExample() {
    dynamic source = FileDataSouce("somefile.dat");
    source.writeData("salaryRecords");
    // В файл были записаны чистые данные.

    source = CompressionDecorator(source);
    source.writeData("compress salaryRecords");
    // В файл были записаны сжатые данные.

    source = EncryptionDecorator(source);
    // Сейчас в source находится связка из трёх объектов:
    // Encryption > Compression > FileDataSource

    source.writeData("encrypt salaryRecords");
    // В файл были записаны сжатые и зашифрованные данные.
  }
}

// Способ 2. Клиентский код, использующий внешний источник
// данных. Класс SalaryManager ничего не знает о том, как именно
// будут считаны и записаны данные. Он получает уже готовый
// источник данных.
class SalaryManager {
  DataSource _source;

  SalaryManager(this._source);

  dynamic load() {
    return this._source.readData();
  }

  void save() {
    this._source.writeData("salaryRecords");
  }
}

// Приложение может по-разному собирать декорируемые объекты, в
// зависимости от условий использования.
class ApplicationConfigurator {
  bool _enableEncryption;
  bool _enableCompression;

  ApplicationConfigurator(this._enableEncryption, this._enableCompression);

  void configurationExample() {
    dynamic source = FileDataSouce("salary.dat");
    if (_enableEncryption) {
      source = EncryptionDecorator(source);
    }
    if (_enableCompression) {
      source = CompressionDecorator(source);
    }

    (source as DataSource).writeData("TEST DATA");

    final logger = SalaryManager(source);
    dynamic salary = logger.load();
    print("SALARY: " + salary);
  }
}

void main(List<String> args) {
  // Способ 1
  final conf1 = Application();
  conf1.dumbUsageExample();

  // Способ 2
  final conf2 = ApplicationConfigurator(true, true);
  conf2.configurationExample();
}
