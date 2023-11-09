import 'dart:convert';

class Course {
  int id;
  String name;
  bool isStudent;
  Course({
    required this.id,
    required this.name,
    required this.isStudent,
  });

  // SERIALIZAÇÃO
  // Passo 1, toMap
  // Metodo toMap transformará o Object Course em um Map<chave, valor>
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "isStudent": false,
    };
  }

  // Passo 2, toJson
  // Metodo toJson() transforma um Map<chave,valor> em uma String json
  String toJson() => jsonEncode(toMap());

  // DESSERIALIZAÇÃO
  // Passo 1
  factory Course.fromJson(String json) => Course.fromMap(jsonDecode(json));

  // Passo 2
  factory Course.fromMap(Map<String, dynamic> map) {
    return Course(
      id: map['id'],
      name: map['name'],
      isStudent: map['isStudent'],
    );
  }
}
