import 'dart:async';

// ignore: depend_on_referenced_packages
import 'package:macros/macros.dart';

/// A macro to automatically generate a `toJson` method for Dart classes.
///
/// The `toJson` method converts an instance of the class into a `Map<String, dynamic>`,
/// with the map keys corresponding to the field names and the values to their respective
/// values in the class.
///
/// Example usage:
/// ```dart
/// @ToJson()
/// class Example {
///   final String name;
///   final int age;
/// }
/// ```
/// The macro will generate:
/// ```dart
/// Map<String, dynamic> toJson() {
///   return {
///     'name': this.name,
///     'age': this.age,
///   };
/// }
/// ```
macro class ToJson implements ClassDeclarationsMacro {
  /// Creates a new instance of the [ToJson] macro.
  const ToJson();

  @override
  /// Builds the `toJson` method declaration for the target class.
  ///
  /// - [clazz]: The target class for which the `toJson` method is to be generated.
  /// - [builder]: The builder used to declare methods in the target class.
  ///
  /// Throws an [ArgumentError] if the class already has a `toJson` method.
  FutureOr<void> buildDeclarationsForClass(
      ClassDeclaration clazz, MemberDeclarationBuilder builder) async {
    // Check if the class already defines a `toJson` method.
    List<MethodDeclaration> methods = await builder.methodsOf(clazz);
    if (methods.any((method) => method.identifier.name == 'toJson')) {
      throw ArgumentError(
          'Can\'t generate toJson; a toJson method already exists in the class.');
    }

    // Retrieve the fields of the class.
    final List<FieldDeclaration> fields = await builder.fieldsOf(clazz);

    // Declare the `toJson` method in the target class.
    builder.declareInType(
      DeclarationCode.fromParts(
        _generateToJson(fields),
      ),
    );
  }
}

/// A macro to augment the definition of the `toJson` method.
///
/// If a `toJson` method is not defined in the target class, this macro
/// generates and augments the `toJson` method to convert the class instance
/// into a `Map<String, dynamic>`.
macro class ToJsonDefinition implements ClassDefinitionMacro {
  @override
  /// Builds and augments the `toJson` method definition for the target class.
  ///
  /// - [clazz]: The class for which the `toJson` method definition is to be generated.
  /// - [builder]: The builder used to augment the class's method definitions.
  ///
  /// Throws an [ArgumentError] if the class already has a `toJson` method.
  FutureOr<void> buildDefinitionForClass(
      ClassDeclaration clazz, TypeDefinitionBuilder builder) async {
    // Check if the class already defines a `toJson` method.
    final methods = await builder.methodsOf(clazz);
    if (methods.any((method) => method.identifier.name == 'toJson')) {
      throw ArgumentError(
          'Can\'t generate toJson; a toJson method already exists in the class.');
    }

    // Retrieve the fields of the class.
    final List<FieldDeclaration> fields = await builder.fieldsOf(clazz);

    // Augment the `toJson` method.
    final FunctionDefinitionBuilder toJsonBuilder =
        await builder.buildMethod(clazz.identifier);

    toJsonBuilder.augment(
      FunctionBodyCode.fromParts(
        _generateToJson(fields),
      ),
    );
  }
}

/// Generates the `toJson` method for the target class.
///
/// - [fields]: The fields of the class to be included in the `toJson` method.
///
/// Returns a list of strings representing the `toJson` method's code.
List<String> _generateToJson(List<FieldDeclaration> fields) {
  final List<String> parts = ["\n\t", "Map<String, dynamic> toJson() {", "\n"];

  // Begin the `return` statement.
  parts.addAll(["\t\t", "return {"]);

  // Add each field to the returned map.
  for (FieldDeclaration field in fields) {
    // Skip static fields.
    if (field.hasStatic) continue;

    String fieldName = field.identifier.name;
    parts.addAll([
      "\n\t\t\t'",
      fieldName,
      "': this.",
      fieldName,
      ",",
    ]);
  }

  // Close the map and the method body.
  parts.addAll(["\n\t\t", "};", "\n\t", "}"]);

  return parts;
}