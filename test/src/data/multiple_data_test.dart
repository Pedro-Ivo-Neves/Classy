import 'package:classy/classy.dart';
import 'package:test/test.dart';

@Data()
class Person{
  String name;
  int age;
  String ? username;
}

void main(){

  group(
    'Multiple Test -', 
    (){

      late Person p;
      const String name = 'Pedro';
      const int age = 23;

      group('Constructor Test: ', 
        (){
          
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

      group(
        'FromJson Test: ', 
        (){

          setUpAll((){
            p = Person.fromJson({
              'name': 'Pedro',
              'age': 23
            });
          });

          test(
            'Should be a Person instance.', 
            (){
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
              expect(p.username, isNull);
            }
          );
        
        }
      );


      group(
        'ToJson Test: ', 
        (){

          setUpAll((){
            p = Person(name: name, age: age);
          });

          test(
            'Should return a Map.', 
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

      group(
        'ToString Test: ', 
        (){

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

  );

}