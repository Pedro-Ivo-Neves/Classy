import 'dart:convert';

import 'package:classy/classy.dart';

@Constructor()
@ToJson()
@FromJson()
class Person{
  String name;
  int age;
  String ? username;
}

/// ✅ The Code Generated:
/// part of 'file:///D:/Flutter%20Workspace/My%20Packages/Dart/classy/example/classy_example.dart';
/// augment class Person {
///	factory Person.fromJson(Map<String,dynamic> json){
/// 		return Person(
/// 			name: json['name'],
/// 			age: json['age'],
/// 			username: json['username'],
/// 		);
/// 	}
/// 	Map<String,dynamic> toJson(){
/// 		return {
/// 			'name': name,
/// 			'age': age,
// 			'username': username,
/// 		};
/// 	}
/// 	Person({
/// 		required this.name,
/// 		required this.age,
/// 		this.username
/// 	});
/// }

 


void main(List<String> args) {
  Person p = Person(name: 'Pedro', age: 23);

  print(p.name); // Output: Pedro

  print(jsonEncode(p.toJson())); // Output {"name":"Pedro", "age":23}
}