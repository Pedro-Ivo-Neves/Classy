import 'package:classy/classy.dart';
import 'package:test/test.dart';

@FromJson()
class Person { Person(); }


void main(){

  group(
    'Empty Test -', 
    (){
      test(
        'Should be Person instance.', 
        (){
          expect(Person.fromJson({}), isA<Person>());
        }
      );
    }
  );

}