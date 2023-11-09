import 'dart:convert';

class Phone {
  int ddd;
  String phoneNumber;
  Phone({
    required this.ddd,
    required this.phoneNumber,
  });
  // Serialização passa pelos metodos toJson e toMap
  // SERIALIZAÇÃO
  // Metodo que pega o nosso objeto Phone e transforma em um Map<String, dynamic>
  // toMap()
  // Passo 1
  Map<String, dynamic> toMap() {
    return {
      "ddd": ddd,
      "phoneNumber": phoneNumber,
    };
  }

  // metodo que pega um Map<String, dynamic> e transforma em um json Pelo pacote
  // dart:convert (jsonEncode)
  // toJson
  // Passo 2
  String toJson() => jsonEncode(toMap());

  // DESSERIALIZAÇÃO
  // Passo 1
  // Construtor fromJson transforma uma String json em um map<chave,valor>
  factory Phone.fromJson(String json) {
    // jsonDecode irá transformar a String json em um Map chave/valor
    final jsonMap = jsonDecode(json);
    return Phone.fromMap(jsonMap);
  }
  // Podemos simplificar o Passo 1 da Disserialização, desta forma:
  factory Phone.fromJsonSimplificado(String json) => Phone.fromMap(jsonDecode(json));
  // Passo 2
  // Construtor fromMap transformará um Map em um Object Phone
  factory Phone.fromMap(Map<String, dynamic> map) {
    // Como estamos utilizando um construtor do tipo Factory, temos a possibilidade
    // de chamar outro construtor dentro dele, no caso chamamos o construtor padrão
    // da classe
    return Phone(
      // Com o uso do dynamic pode ocorrer de os dados serem retornados com Null,
      // logo devemos garantir que não ocorra erro de null safety. Podemos tratar
      // esse erro com validações (Exceptions) ou com null aware operator
      ddd: map['ddd'] ?? 000,
      phoneNumber: map['telefone'] ?? "",
    );
  }

  // Importante:
  // Dependendo de nosso Client Http, teremos respostas diferentes, se utilizarmos
  // o package Http, ele já responde como uma String Json, se utilizarmos o Dio,
  // ele já retorna um Map<chave/valor> (Não sendo necessário a passo 1 de
  // desserialização)
}
