import 'src/constructors/constructor_test.dart' as constructor_macro_test;
import 'src/constructors/from_json_test.dart' as from_json_macro_test;
import 'src/methods/to_json_test.dart' as to_json_macro_test;
import 'src/methods/to_string_test.dart' as to_string_macro_test;
import 'src/data/data_test.dart' as data_macro_test;

void main() {
  constructor_macro_test.main();
  from_json_macro_test.main();
  to_json_macro_test.main();
  to_string_macro_test.main();
  data_macro_test.main();
}