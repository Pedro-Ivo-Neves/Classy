import 'dart:async';

import 'package:macros/macros.dart';

/// A macro to automatically generate a `toString` method for Dart classes.
///
/// The `toString` method provides a human-readable string representation of a
/// class instance, including its class name and field values.
///
/// Example usage:
/// ```dart
/// @ToString()
/// class Example {
///   final String name;
///   final int age;
/// }
/// ```
/// The macro will generate:
/// ```dart
/// @override
/// String toString() {
///   return 'Example { name: $name, age: $age }';
/// }
/// ```
macro class ToString implements ClassDeclarationsMacro {
  /// Creates a new instance of the [ToString] macro.
  const ToString();

  @override
  /// Builds the `toString` method declaration for the target class.
  ///
  /// - [clazz]: The target class for which the `toString` method is to be generated.
  /// - [builder]: The builder used to declare methods in the target class.
  ///
  /// Throws an [ArgumentError] if the class already has a `toString` method.
  FutureOr<void> buildDeclarationsForClass(
      ClassDeclaration clazz, MemberDeclarationBuilder builder) async {
    // Check if the class already defines a `toString` method.
    final methods = await builder.methodsOf(clazz);

    if (methods.any((method) => method.identifier.name == 'ToString')) {
      throw ArgumentError(
          'Can\'t generate ToString; a toString method already exists in the class.');
    }

    // Retrieve the class name and its fields.
    final String className = clazz.identifier.name;
    final List<FieldDeclaration> fields = await builder.fieldsOf(clazz);

    // Declare the `toString` method in the target class.
    builder.declareInType(
      DeclarationCode.fromParts(
        _generateToString(fields, className),
      ),
    );
  }
}

/// A macro to augment the definition of the `toString` method.
///
/// If a `toString` method is not defined in the target class, this macro
/// generates and augments the `toString` method to provide a string
/// representation of the class instance.
macro class ToStringDefinition implements ClassDefinitionMacro {
  @override
  /// Builds and augments the `toString` method definition for the target class.
  ///
  /// - [clazz]: The class for which the `toString` method definition is to be generated.
  /// - [builder]: The builder used to augment the class's method definitions.
  ///
  /// Throws an [ArgumentError] if the class already has a `toString` method.
  FutureOr<void> buildDefinitionForClass(
      ClassDeclaration clazz, TypeDefinitionBuilder builder) async {
    // Check if the class already defines a `toString` method.
    final methods = await builder.methodsOf(clazz);
    if (methods.any((method) => method.identifier.name == 'ToString')) {
      throw ArgumentError(
          'Can\'t generate ToString; a toString method already exists in the class.');
    }

    // Retrieve the class name and its fields.
    final String className = clazz.identifier.name;
    final List<FieldDeclaration> fields = await builder.fieldsOf(clazz);

    // Augment the `toString` method.
    final FunctionDefinitionBuilder toStringBuilder =
        await builder.buildMethod(clazz.identifier);

    toStringBuilder.augment(
      FunctionBodyCode.fromParts(
        _generateToString(fields, className),
      ),
    );
  }
}

/// Generates the `toString` method for the target class.
///
/// - [fields]: The fields of the class to be included in the `toString` method.
/// - [className]: The name of the class for which the `toString` method is being generated.
///
/// Returns a list of strings representing the `toString` method's code.
List<String> _generateToString(List<FieldDeclaration> fields, String className) {
  final List<String> parts = [
    "\n\t@override",
    "\n",
    "\tString toString() {",
    "\n",
    "\t\treturn",
    " '$className { "
  ];


  // Close the string and the method body.
  if (parts.isNotEmpty){
    // Add each field to the `toString` method output.
    for (FieldDeclaration field in fields) {
      // Skip static fields.
      if (field.hasStatic) continue;

      parts.addAll([
        field.identifier.name,
        ": ",
        "\$",
        field.identifier.name,
        ", "
      ]);
    }
  } else{
    parts.removeLast(); // Remove trailing comma.
  }
  
  
  parts.addAll([
    " }';",
    "\n",
    "\t}"
  ]);

  return parts;
}