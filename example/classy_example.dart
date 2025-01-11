import 'package:classy/classy.dart';

@Data()
class Person{
  String name;
  int age;
  String ? username;
}

// ✅ The Code Generated:
// part of 'file:///D:/Flutter%20Workspace/My%20Packages/Dart/classy/example/classy_example.dart';
//
// augment class Person {
//
// 	Person({
// 		required this.name,
// 		required this.age,
// 		this.username
// 	});
//
// 	factory Person.fromJson(Map<String,dynamic> json){
// 		return Person(
// 			name: json['name'],
// 			age: json['age'],
// 			username: json['username'],
// 		);
// 	}
//
// 	Map<String,dynamic> toJson(){
// 		return {
// 			'name': this.name,
// 			'age': this.age,
// 			'username': this.username,
// 		};
// 	}
//
// 	@override
// 	String toString() {
// 		return 'Person { name: $name, age: $age, username: $username }';
// 	}
// }


void main(List<String> args) {
  Person p = Person(name: 'Pedro', age: 23);

  print(p.name); // Output: Pedro

  print(p.toJson()['name']); // Output: {name: Pedro, age: 23, username: null}

  print(p.toString()); // Output: Person { name: Pedro, age: 23, username: null }
  
  Person p2 = Person.fromJson({
    'name' : 'Neves',
    'age': 23
  });

  print(p2.name); // Output: Neves
}