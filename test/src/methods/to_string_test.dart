import 'package:test/test.dart';

import 'toString/empty_to_string_test.dart' as empty_to_string_test;
import 'toString/multiple_to_string_test.dart' as multiple_to_string_test;

void main() {

  group(
    '📜 ToString', 
    (){
      empty_to_string_test.main();
      multiple_to_string_test.main();
    }
  );
  
}