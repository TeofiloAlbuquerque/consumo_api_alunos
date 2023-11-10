// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:consumo_api_alunos/models/address.dart';
import 'package:consumo_api_alunos/models/course.dart';

class Student {
  int id;
  String name;
  int? age;
  List<String> nameCourses;
  Address address;
  List<Course> courses;

  Student({
    required this.id,
    required this.name,
    this.age,
    required this.nameCourses,
    required this.address,
    required this.courses,
  });

  // SERIALIZAÇÃO
  // Passo 1
  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      "id": id,
      "nome": name,
      "nomeCursos": nameCourses,
      // Quando passamos um Objeto simples, podemos utilizar apenas o "toMap()",
      // como estamos tendo que passar uma lista de Objetos, a forma correta é
      // utilizar um transformador, para transformar a lista de curso, para uma
      // lista de Map<String, dynamic>, podemos fazer isso com o ".map()", o map
      // irá transformar o objeto "course" em um Map<chave, valor> com o toMap()
      // e ao final, transformar novamente em uma lista com o toList()
      // Com isso, transformamos um Map de courses em um Map<String, dynamic>
      "cursos": courses.map((course) => course.toMap()).toList(),
      "endereco": address.toMap(),
    };
    // Como a idade é um atributo opcional e não existe em nosso Objeto Json,
    // criamos a condição para identificar se a idade é passada ou não, se sim,
    // a idade é mapeada e adicionada ao campo idade do map.
    if (age != null) {
      map['idade'] = age;
    }
    return map;
  }

  // Passo 2
  String toJson() => jsonEncode(toMap());

  // DESSERIALIZAÇÃO
  factory Student.fromMap(Map<String, dynamic> map) {
    return Student(
      id: map['id'] ?? 0,
      name: map['nome'] ?? "",
      // Idade é opcional e pode ter retorno null, então não precisamos utilizar
      // o null aware operator
      age: map['idade'],
      // O map['nomeCursos'] ele virá com um map de uma forma diferente, que não
      // é o map que nós precisamos, e dará um  erro informando que é uma
      // List<dynamic> e não é uma List<String>, é um erro comum que poucos
      // sabem corrigir por gerarem pelos Jsons dart data class generator,
      // Temos duas formas de contornar esse erro:
      ////nameCourses: map['nomeCursos'] ?? "",
      // Forma 1, forma que o dart data class generator utiliza
      // A List<dynamic> será automaticamente convertida para uma List<String>
      nameCourses: List<String>.from(map['nomeCursos'] ?? <String>[]),
      //Forma 2, menos comum
      // O metodo "cas<String>() irá converter a List<dynamic> para uma List<String>
      //nameCourses: map['nomeCursos'].cast<String>(),
      // Devemos entender que o dart não consegue saber que é um Map<String>,
      // pode ser que ele saiba ou não, então na hora que ele for analisar o Json,
      // ele pode conseguir converter para uma List<String>, como ele pode achar
      // e não saber o que há dentro do Json e jogar uma List<dynamic> que é mais
      // fácil para ele na hora da conversão, mas nunca teremos certeza de quando
      // ele conseguirá.
      address: Address.fromMap(map['endereco'] ?? <String, dynamic>{}),
      // "cursos" é uma lista de objetos complexos, então precisamos converter
      // esse objeto, courses espera uma List<Course>, então, se ele já é uma
      // lista, devemos converter ele com o ".map()" para o tipo <Course>
      // (.map<Course>()), devemos tipar o .map() para evitar o problema do
      // dart retornar uma List<dynamic>
      courses: map['cursos']
              // Por algum motivo, o "cursos" pode vir null por algum erro do backend,
              // com isso devemos fazer o tratamento com o null aware operator
              // retornando uma List<Course> vazia.
              // Caso cursos não vier, estamos convertendo ele para uma
              // List<Course> vazia
              ?.map<Course>((cursoMap) => Course.fromMap(cursoMap))
              .toList() ??
          <Course>[],
    );
  }

  factory Student.fromJson(String json) => Student.fromMap(jsonDecode(json));

  @override
  String toString() {
    return 'Aluno: $name($id)';
  }
}
