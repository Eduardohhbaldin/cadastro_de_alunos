import 'package:cadastro_de_alunos/models/student.dart';
import 'package:cadastro_de_alunos/models/db_local.dart';
import 'package:cadastro_de_alunos/repositories/student/student_repository.dart';
import 'package:sqflite/sqflite.dart';

class StudentDBRepository implements StudentRepository {
  @override
  late DBLocal dblocal;

  StudentDBRepository() {
    this.dblocal = DBLocal(
      table: "students",
    );
  }

  @override
  Future<Student> find(int id) async {
    Database database = await dblocal.getConnection();

    List<Map<String, dynamic>> data = await database.query(
      dblocal.table,
      where: "id=?",
      whereArgs: [id],
    );
    database.close();
    return Student.fromMap(data.first);
  }

  @override
  Future<int> insert(Student entity) async {
    Database database = await dblocal.getConnection();
    int id = await database.insert(dblocal.table, entity.toMap());
    database.close();
    return id;
  }

  @override
  Future<int> remove({
    required String conditions,
    required List conditionsValue,
  }) async {
    Database database = await dblocal.getConnection();
    int id = await database.delete(
      dblocal.table,
      where: conditions,
      whereArgs: conditionsValue,
    );
    database.close();
    return id;
  }

  @override
  Future<List<Student>> search() async {
    Database database = await dblocal.getConnection();
    var data = await database.query(dblocal.table);
    List<Student> students =
        data.map((objMap) => Student.fromMap(objMap)).toList();
    database.close();
    return students;
  }

  @override
  Future<int> update({
    required Student entity,
    required String conditions,
    required List conditionsValue,
  }) async {
    Database database = await dblocal.getConnection();
    int id = await database.update(
      dblocal.table,
      entity.toMap(),
      where: conditions,
      whereArgs: conditionsValue,
    );
    database.close();
    return id;
  }
}
