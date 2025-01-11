import 'package:test/test.dart';

import './multiple_data_test.dart' as multiple_data_test;
import './empty_data_test.dart' as empty_data_test;


void main() {

  group(
    '😎 Data', 
    (){
      empty_data_test.main();
      multiple_data_test.main();
    }
  );

}