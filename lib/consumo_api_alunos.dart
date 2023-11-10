import 'package:consumo_api_alunos/repositories/student_repository.dart';

Future<void> main() async {
  final studentRepository = StudentRepository();

  final students = await studentRepository.findAll();
  print(students);

  final studentsId = await studentRepository.findById(1);
  print(
    '${studentsId.id} \n'
    '${studentsId.name} \n'
    '${studentsId.address} \n'
    '${studentsId.nameCourses}',
  );
  print('Cursos:');
  for (var courseId in studentsId.courses) {
    print(
      '${courseId.name}: '
      '${studentsId.name}: '
      '${(courseId.isStudent ? 'Sim' : 'Não')}',
    );
  }
}
