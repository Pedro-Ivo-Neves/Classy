import 'package:classy/classy.dart';
import 'package:test/test.dart';

@Constructor()
class Person {}

void main() {
  
  group(
    'Empty Test -', 
    (){

      test(
        'Should be a Person instance', 
        (){
          expect(Person(), isA<Person>());
        }
      );

    }
  );

}