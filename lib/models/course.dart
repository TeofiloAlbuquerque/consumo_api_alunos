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
      "nome": name,
      "isAluno": false,
    };
  }

  // Passo 2, toJson
  // Metodo toJson() transforma um Map<chave,valor> em uma String json
  String toJson() => jsonEncode(toMap());

  // DESSERIALIZAÇÃO

  // Passo 2
  factory Course.fromMap(Map<String, dynamic> map) {
    return Course(
      id: map['id'] ?? 0,
      name: map['nome'] ?? "",
      isStudent: map['isAluno'] ?? false,
    );
  }
  // Passo 1
  factory Course.fromJson(String json) => Course.fromMap(jsonDecode(json));
}
