import 'toJson/multiple_to_json_test.dart' as multiple_to_json_test;
import 'toJson/empty_to_json_test.dart' as empty_to_json_test;
import 'package:test/test.dart';

void main() {
  group(
    '⬆️  ToJson', 
    (){
      empty_to_json_test.main();
      multiple_to_json_test.main();
    }
  );
}