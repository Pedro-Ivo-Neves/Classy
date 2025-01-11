import 'package:test/test.dart';
import 'package:classy/classy.dart';


@Constructor()
class Person{
  String name;
  int age;
  String ? username;
}

void main() {
  group(
    'Multiple Named Test -', 
    (){

      late Person p;
      const String name = 'Pedro';
      const int age = 23;

      setUpAll((){
        p = Person(name: name, age: age);
      });

      test(
        'Should be a Person instance.', 
        () {
          expect(p, isA<Person>());
        }
      );


      test(
        'The name field should be $name.', 
        (){
          expect(p.name, name);
        }
      );
      test(
        'Should update the name to Neves.', 
        (){
          p.name = 'Neves';

          expect(p.name, 'Neves');
        }
      );

      test(
        'The username field should be null.', 
        (){
          expect(p.username, isNull);
        }
      );

      test(
        'Should update username to pn and it can\'t be null.', 
        (){
          p.username = 'pn';
          expect(p.username, isNotNull);
          expect(p.username, 'pn');
        }
      );

    }
  );
}