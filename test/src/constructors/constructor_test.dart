import 'package:test/test.dart';

import 'constructor/empty_constructor_test.dart' as empty_constructor_test;
import 'constructor/multiple_named_constructor_test.dart' as multiple_named_constructor_test;
import 'constructor/multiple_position_constructor_test.dart' as multiple_position_constructor_test;

void main(){
  group(
    '🏗️  Constructor', 
    (){
      empty_constructor_test.main();
      multiple_named_constructor_test.main();  
      multiple_position_constructor_test.main();
    }
  );
}