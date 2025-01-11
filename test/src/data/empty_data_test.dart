import 'package:classy/classy.dart';
import 'package:test/test.dart';

@Data()
class Person{}

void main() {
  group(
    'Empty Test -', 
    (){

      test(
        'Instantiating with Constructor should be Person instance.', 
        (){
          expect(Person(), isA<Person>());
        }
      );

      test(
        'Instantiating with FromJson should be Person instance.', 
        (){
          expect(Person.fromJson({}), isA<Person>());
        }
      );

      test(
        'Should return an empty Json from ToJson.', 
        (){
          expect(Person().toJson(), {});
          expect(Person.fromJson({}).toJson(), {});
        }
      );

      test(
        'Should return a String with the name of the class.', 
        (){
          expect(Person().toString(), isA<String>());
          expect(Person().toString(), 'Person {  }');
        }
      );
    }
  );  
}