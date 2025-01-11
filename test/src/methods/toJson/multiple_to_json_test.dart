import 'package:classy/classy.dart';
import 'package:test/test.dart';

@ToJson()
class Person{

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
      const String name = 'Pedro';
      const int age = 23;

      setUpAll((){
        p = Person(name: name, age: age);
      });


      test(
        'Should be a Map.', 
        (){
          expect(p.toJson(), isA<Map>());
        }
      );


      test(
        'The name in the Map should be $name and it should be a String.', 
        (){

          var nameMap = p.toJson()['name'];

          expect(nameMap, isA<String>());
          expect(nameMap, name);
          
        }
      );

      test(
        'The username should be null.', 
        (){
          expect(p.toJson()['username'], isNull);
        }
      );
    }
  );
}