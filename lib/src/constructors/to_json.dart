import 'dart:async';

// ignore: depend_on_referenced_packages
import 'package:macros/macros.dart';

///<h1>ToJson</h1>
///ToJson is a method to transform the data from the Object into a Map<String, dynamic>
///
///Example:
///```dart
///class Person {
///  String name;
///  int age;
///  String? username; // Optional field
///
///  // Constructor
///  Person({
///    required this.name,
///    required this.age,
///    this.username,
///  });
///
///  /// Converts the Person object to a Map<String, dynamic>
///  Map<String, dynamic> toJson() {
///    return {
///      'name': name,
///      'age': age,
///      'username': username, // It can be null, that's why it's safely included
///    };
///  }
///}
///```
///This method is useful when serializing a Dart object to a JSON-compatible map.
///In this example, the `Person` class has three fields: `name` (String), `age` (int),
///and `username` (String?, optional). The `toJson` method transforms these fields into a map
///with string keys corresponding to the property names and dynamic values based on the property types.
///This map can then be easily converted into JSON format using methods like `jsonEncode`.
macro class ToJson implements ClassDeclarationsMacro{

  const ToJson();

  @override
  FutureOr<void> buildDeclarationsForClass(ClassDeclaration clazz, MemberDeclarationBuilder builder) async{

    List<MethodDeclaration> methods = await builder.methodsOf(clazz);

    if(
      methods.any(
        (method)=> method.identifier.name == 'ToJson'
      )
    ) throw ArgumentError('Can\'t Generate ToJson, cause it already Exists a ToJson Method');
    
    final List<FieldDeclaration> fields = await builder.fieldsOf(clazz);

    List<String> parts = ["\tMap<String,dynamic> toJson(){","\n"];

    parts.add("\t\treturn {");

    for(FieldDeclaration field in fields){
      String fieldName = field.identifier.name;
      parts.addAll(["\n\t\t\t'",fieldName,"': ",fieldName,","]);
    }
    
    parts.add("\n\t\t};\n\t}");

    builder.declareInType(DeclarationCode.fromParts(parts));
  }
}