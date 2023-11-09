import 'dart:convert';

import '../models/student.dart';
import 'package:http/http.dart' as http;

class StudentRepository {
  Future<List<Student>> findAll() async {
    // Acesso ao backend
    final studentResponse =
        await http.get(Uri.parse('http://localhost:8080/alunos'));

    // Conversão dos dados para um modelo
    // Devemos identificar o que o serviço API nos retorna, neste exemplo, nos
    // retorna um array, teremos que transformar esse array em cada um dos alunos
    // O http não faz uma conversão automatica, então precisamos fazer o Parse
    // desse Json, precisamos converter esse Json
    final studentsList = jsonDecode(studentResponse.body);

    // Transformar de um modelo que se tornou no jsonDecode, em um lista de Mapas
    // em uma lista de Alunos, para isso chamamos o ".map". Caso fique em duvida
    // do pq o auto complete do dart não retornou o ".map", o motivo é por o
    // jsonDecode retorna "dynamic", retornando dynamic ele não consegue saber
    // qual é o tipo que ele vai ser retornado.
    // Informamos ao ".map" o tipo que ele irá converter, o tipando ".map<Student>"
    // Passamos para o studentList.map<Student> um map "alunoMap", e o convertemos
    // passando em nosso Student.fromMap, e todo o restante ficará em responsabilidade
    // dos "froms". Mandaremos um Mapa para o Student e ele fará as chamadas do
    // fromMap e os dados do Student no map e fará a conversão, com isso centralizamos.
    // Lembre-se, os DTOs devem ter metodos de acesso e metodos conversores, o
    // fromMap é o nosso conversor, Json serializible, no caso o fromMap é uma
    // desserialização, ele está transformando um Map<String, dynamic> em um Student

    final allStudents = studentsList.map<Student>((studentMap) {
      return Student.fromMap(studentMap);
    }).toList();
    return allStudents;

    // Forma Simplificada e suncinta para o código acima
    // return studentsList
    //     .map<Student>((studentMap) => Student.fromMap(studentMap))
    //     .toList();
  }

  // Buscar alunos por Id
  Future<Student> findById(int id) async {
    final studentResponse =
        await http.get(Uri.parse('http://localhost:8080/alunos/$id'));
    return Student.fromJson(studentResponse.body);
  }
}
