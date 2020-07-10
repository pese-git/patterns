abstract class Notepad {}

abstract class Magazine {}

abstract class Book {}

class PaperNotepad extends Notepad {}

class PaperMagazine extends Magazine {}

class PaperBook extends Book {}

class ElectronicNotepad extends Notepad {}

class ElectronicMagazine extends Magazine {}

class ElectronicBook extends Book {}

abstract class InfoFactory {
  Book createBook();
  Magazine createMagazine();
  Notepad createNotepad();
}

class PaperInfoFactory extends InfoFactory {
  @override
  Book createBook() {
    return PaperBook();
  }

  @override
  Magazine createMagazine() {
    return PaperMagazine();
  }

  @override
  Notepad createNotepad() {
    return PaperNotepad();
  }
}

class ElectronicInfoFactory extends InfoFactory {
  @override
  Book createBook() {
    return ElectronicBook();
  }

  @override
  Magazine createMagazine() {
    return ElectronicMagazine();
  }

  @override
  Notepad createNotepad() {
    return ElectronicNotepad();
  }
}

main(List<String> args) {
  final config = "electronic";
  InfoFactory factory;
  if (config == "paper") {
    factory = new PaperInfoFactory();
  } else if (config == "electronic") {
    factory = new ElectronicInfoFactory();
  } else {
    throw new Exception("Error! Unknown info type.");
  }
  print("FACTORY: " + factory.createBook().toString());
}
