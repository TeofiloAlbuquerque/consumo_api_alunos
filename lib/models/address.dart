import 'dart:convert';

import 'package:consumo_api_alunos/models/city.dart';
import 'package:consumo_api_alunos/models/phone.dart';

class Address {
  String road; // rua
  int number;
  String cep;
  City city;
  Phone phoneNumber;
  Address({
    required this.road,
    required this.number,
    required this.cep,
    required this.city,
    required this.phoneNumber,
  });
  // SERIALIZAÇÃO
  // Passo 1
  Map<String, dynamic> toMap() {
    return {
      "rua": road,
      "numero": number,
      "CEP": cep,
      // toMap trará automaticamente um id e um nome, não precisamos ficar remontando,
      // ele trará em formato de Map os dados que precisamos de city
      "cidade": city.toMap(),
      "telefone": phoneNumber.toMap()
    };
  }

  // Passo 2
  String toJson() => jsonEncode(toMap());

  // DESSERIALIZAÇÃO
  // Passo 1
  factory Address.fromJson(String json) => Address.fromMap(jsonDecode(json));
  // Passo 2
  factory Address.fromMap(Map<String, dynamic> map) {
    return Address(
      road: map['rua'] ?? "",
      number: map['numero'] ?? 0,
      cep: map['CEP'] ?? "",
      // o map['cidade'] já será o nosso Map<chave,valor>, com isso delegamos para
      // a City que já sabe se converter e automaticamente irá desserializar cidade
      city: City.fromMap(map['cidade'] ?? <String, dynamic>{}),
      // Tratamos o null com uma Map vazio do tipo <String, dynamic>
      phoneNumber: Phone.fromMap(map['telefone'] ?? <String, dynamic>{}),
    );
  }
}
