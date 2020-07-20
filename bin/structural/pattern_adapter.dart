abstract class USB {
  void connectWithUsbCable();
}

class MemoryCard {
  void insert() {
    print("Карта памяти успешно вставлена!");
  }

  void copyData() {
    print("Данные скопированы на компьютер!");
  }
}

class CardReader extends USB {
  MemoryCard memoryCard;

  CardReader(this.memoryCard);

  @override
  void connectWithUsbCable() {
    this.memoryCard.insert();
    this.memoryCard.copyData();
  }
}

main(List<String> args) {
  final memoryCard = MemoryCard();
  final cardReader = CardReader(memoryCard);

  cardReader.connectWithUsbCable();
}
