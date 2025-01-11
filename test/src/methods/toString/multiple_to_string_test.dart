import 'package:classy/classy.dart';
import 'package:test/test.dart';

@ToString()
class Person {

  Person({
    required this.name,
    required this.age,
    this.username
  });

  String name;
  int age;
  String ? username;
}

void main() {
  group(
    'Multiple Test -', 
    (){

      late Person p;

      setUpAll(
        (){
          p = Person(name: 'Pedro', age: 23);
        }
      );

      test(
        'Should return a String.', 
        (){
          expect(p.toString(), isA<String>());
        }
      );
      

      test(
        'Should return a String Representation of Person.', 
        (){
          expect(true, RegExp(r'Person\s{\s(\w+)(\w|\:|\s|\,)+}').hasMatch(p.toString()));
        }
      );
    }
  );
}