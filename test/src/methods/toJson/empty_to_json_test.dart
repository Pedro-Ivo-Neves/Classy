import 'package:classy/classy.dart';
import 'package:test/test.dart';

@ToJson()
class Person{}

void main() {
  group(
    'Empty Test -', 
    (){
      test(
        'Should be a Map.', 
        (){
          expect(Person().toJson(), isA<Map>());
        }
      );

      test(
        'Should be a Empty Map.', 
        (){
          expect(Person().toJson(), {});
        }
      );
    }
  );
}