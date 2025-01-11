import 'package:test/test.dart';

import 'fromJson/empty_from_json_test.dart' as empty_from_json_test;
import 'fromJson/multiple_named_from_json_test.dart' as multiple_named_from_json_test;
import 'fromJson/multiple_position_from_json_test.dart' as multiple_position_from_json_test;

void main(){

  group(
    '⬇️  FromJson', 
    (){
      empty_from_json_test.main();
      multiple_named_from_json_test.main();
      multiple_position_from_json_test.main();
    }
  );

}