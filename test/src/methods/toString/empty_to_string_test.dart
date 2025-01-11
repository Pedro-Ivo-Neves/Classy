import 'package:classy/classy.dart';
import 'package:test/test.dart';

@ToString()
class Person{}

void main() {
  group(
    'Empty Test -', 
    (){
      test(
        'Should return a String', 
        (){
          expect(Person().toString(), isA<String>());
        }
      );

      test(
        'Should return a String Representation of Person with no Attributes.', 
        (){
          expect(true, RegExp(r'^Person\s*{\s*}$').hasMatch(Person().toString()));
        }
      );
    }
  );
}