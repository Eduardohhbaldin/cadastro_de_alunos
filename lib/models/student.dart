class Student {
  final int? id;
  final String name;
  final String email;

  Student({
    this.id,
    required this.name,
    required this.email,
  });

  // De Objeto para Map (Enviar para o banco de dados)
  Map<String, dynamic> toMap() {
    return {'id': this.id, 'name': this.name, 'email': this.email};
  }

  // De Map para Objeto (Receber do banco de dados)
  factory Student.fromMap(Map<String, dynamic> map) {
    return Student(
      id: map['id'],
      name: map['name'],
      email: map['email'],
    );
  }
}
