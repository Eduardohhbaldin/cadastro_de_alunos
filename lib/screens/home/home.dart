import 'package:cadastro_de_alunos/models/student.dart';
import 'package:cadastro_de_alunos/repositories/student/studentdb_repository.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _registerController = TextEditingController();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();

  bool isEdit = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cadastro de alunos"),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(16),
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: "Matrícula do aluno",
                  hintText: "EX: 123",
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                controller: _registerController,
                enabled: (isEdit) ? true : false,
              ),
              SizedBox(
                height: 5,
              ),
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Nome do aluno",
                  hintText: "Digite o nome completo",
                ),
                keyboardType: TextInputType.name,
                controller: _nameController,
              ),
              SizedBox(
                height: 5,
              ),
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Email do aluno",
                  hintText: "seuemail@provedor.com.br",
                ),
                keyboardType: TextInputType.emailAddress,
                controller: _emailController,
              ),
              Row(
                children: [
                  Text(
                    "Edição?",
                  ),
                  Switch(
                    value: isEdit,
                    onChanged: (bool status) {
                      setState(() {
                        isEdit = !isEdit;
                      });
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: (isEdit)
                        ? null
                        : () {
                            saveRegister();
                          },
                    child: Text("Cadastrar"),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                    onPressed: (isEdit) ? () {} : null,
                    child: Text("Editar"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void saveRegister() async {
    final String name = _nameController.text;
    final String email = _emailController.text;
    String message;

    if (!EmailValidator.validate(email)) {
      // Não é válido
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Mensagem do sistema"),
          content: Text("Email inválido!!!"),
          actions: [
            TextButton(
              onPressed: () {
                // Fecha a mensagem
                Navigator.of(context).pop();
              },
              child: Text("OK"),
            ),
          ],
        ),
      );
    } else {
      // É válido
      Student student = Student(
        name: name,
        email: email,
      );

      // Cadastrar no banco
      var repository = StudentDBRepository();
      int register = await repository.insert(student);

      if (register != 0) {
        // Deu certo
        message =
            "O aluno $name foi cadastrado com sucesso. Sua matrícula é $register";
      } else {
        // Deu ruim
        message = "Não foi possível cadastrar o aluno $name";
      }

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Mensagem do sistema"),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                // Fecha a mensagem
                Navigator.of(context).pop();
              },
              child: Text("OK"),
            ),
          ],
        ),
      );
    }
  }
}
