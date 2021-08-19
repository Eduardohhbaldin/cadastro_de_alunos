//import 'dart:convert';

class Student {
  final int? id;
  final String name;
  final String email;



  Student({
    this.id,
    required this.name,
    required this.email,
  });
  //de objeto map para map 
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
    };
  }
  //de map para objeto  
  factory Student.fromMap(Map<String, dynamic> map) {
    return Student(
      id: map['id'],
      name: map['name'],
      email: map['email'],
    );
  }

}
