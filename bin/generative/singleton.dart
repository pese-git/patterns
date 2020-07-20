class Database {
  static Database _instance;

  Database._() {}

  static Database getInstance() {
    if (_instance == null) {
      _instance = Database._();
    }
    return _instance;
  }

  void query(String query) {
    print("EXECUTE query: " + query);
  }
}

main(List<String> args) {
  final instance = Database.getInstance();
  instance.query("SELECT * WEHERE userId=1 FROM users");
}
