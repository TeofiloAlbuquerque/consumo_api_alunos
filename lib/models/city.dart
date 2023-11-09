import 'dart:convert';

class City {
  int id;
  String name;
  City({
    required this.id,
    required this.name,
  });

  // SERIALIZAÇÃO
  // Passo 1
  // Transformar o Object City e transforma em um Map<chave,valor>
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
    };
  }

  // Passo 2
  // Transformar um Map<chave, valor> em uma String json
  String toJson() => jsonEncode(toMap());

  // DESSERIALIZAÇÃO
  // Passo 1
  // Construtor transforma uma String json em um map<chave,valor>
  // jsonDecode irá transformar a String json em um Map<chave,valor>
  factory City.fromJson(String json) => City.fromMap(jsonDecode(json));

  // Passo 2
  // Construtor fromMap transformará um Map em um Object City
  factory City.fromMap(Map<String, dynamic> map) {
    return City(
      id: map['id'] ?? 0,
      name: map['nome'] ?? "",
    );
  }
}
