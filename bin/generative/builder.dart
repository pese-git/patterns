class Pizza {
  int _size;
  bool _peperony;
  bool _tomatos;
  bool _chees;

  Pizza(this._size, this._peperony, this._chees, this._tomatos);
}

class PizzaBuilder {
  int _size = 0;
  bool _peperony = false;
  bool _tomatos = false;
  bool _chees = false;

  PizzaBuilder setSize(int size) {
    this._size = size;
    return this;
  }

  PizzaBuilder setPeperony(bool peperony) {
    this._peperony = peperony;
    return this;
  }

  PizzaBuilder setTomatos(bool tomatos) {
    this._tomatos = tomatos;
    return this;
  }

  PizzaBuilder setChees(bool chees) {
    this._chees = chees;
    return this;
  }

  Pizza build() {
    return Pizza(this._size, this._peperony, this._tomatos, this._chees);
  }
}

main(List<String> args) {
  final builder = PizzaBuilder().setSize(32).setChees(true).setTomatos(true);
  print("Create Pizza: " + builder.build().toString());
}
