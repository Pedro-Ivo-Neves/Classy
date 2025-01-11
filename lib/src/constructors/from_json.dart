import 'dart:async';

// ignore: depend_on_referenced_packages
import 'package:macros/macros.dart';

/// A macro to automatically generate `fromJson` factory methods for Dart classes.
///
/// The `fromJson` method will convert a `Map<String, dynamic>` into an instance
/// of the target class. It inspects the class's fields and generates the 
/// appropriate constructor call.
///
/// Example usage:
/// ```dart
/// @FromJson(hasNamedConstructor: true)
/// class Example {
///   final String name;
///   final int age;
/// }
/// ```
/// The macro will generate:
/// ```dart
/// factory Example.fromJson(Map<String, dynamic> json) {
///   return Example(
///     name: json['name'],
///     age: json['age'],
///   );
/// }
/// ```
macro class FromJson implements ClassDeclarationsMacro {
  /// Indicates whether the generated `fromJson` method will use named parameters.
  ///
  /// Defaults to `true`.
  final bool hasNamedConstructor;

  /// Creates a new instance of the [FromJson] macro.
  ///
  /// - [hasNamedConstructor]: A boolean value indicating if the factory method
  ///   will use named constructor parameters.
  const FromJson({this.hasNamedConstructor = true});

  @override
  /// Builds declarations (factory methods) for the target class.
  ///
  /// - [clazz]: The class for which the `fromJson` factory method will be generated.
  /// - [builder]: The builder used to create and modify member declarations.
  ///
  /// Throws [StateError] if no fields are available for generating the method.
  Future<void> buildDeclarationsForClass(
      ClassDeclaration clazz, MemberDeclarationBuilder builder) async {
    final String constructorName = clazz.identifier.name;

    final List<FieldDeclaration> fields = await builder.fieldsOf(clazz);

    builder.declareInType(
      DeclarationCode.fromParts(
        _generateFromJson(
          fields: fields,
          constructorName: constructorName,
          hasNamedParameters: hasNamedConstructor,
        ),
      ),
    );
  }
}

/// A macro to augment the definition of the `fromJson` factory method.
///
/// This macro allows further customization or modification of the `fromJson` method
/// within the class definition, such as the ability to add additional behavior
/// to the factory method.
macro class FromJsonDefinition implements ClassDefinitionMacro {
  @override
  /// Builds and augments the `fromJson` factory method definition for the target class.
  ///
  /// - [clazz]: The class for which the factory method definition will be generated.
  /// - [builder]: The builder used to augment type-level definitions.
  FutureOr<void> buildDefinitionForClass(
      ClassDeclaration clazz, TypeDefinitionBuilder builder) async {
    final constructorName = clazz.identifier.name;

    final List<FieldDeclaration> fields = await builder.fieldsOf(clazz);

    final fromJsonBuild = await builder.buildMethod(clazz.identifier);

    fromJsonBuild.augment(
      FunctionBodyCode.fromParts(
        _generateFromJson(
          fields: fields,
          constructorName: constructorName,
          hasNamedParameters: FromJson().hasNamedConstructor,
        ),
      ),
    );
  }
}

/// Generates the `fromJson` factory method for the target class.
///
/// - [fields]: The fields of the class.
/// - [constructorName]: The name of the class constructor to be invoked.
/// - [hasNamedParameters]: Indicates whether the generated constructor call
///   should use named parameters.
///
/// Returns a list of strings representing the `fromJson` method's code.
List<String> _generateFromJson({
  required List<FieldDeclaration> fields,
  required String constructorName,
  required bool hasNamedParameters,
}) {
  final List<String> parts = ["\t"];

  parts.addAll([
    '\n\tfactory ',
    constructorName,
    ".fromJson(Map<String,dynamic> json){\n",
    "\t\treturn ",
    constructorName,
    "("
  ]);

  for (var field in fields) {
    if (field.hasStatic) continue;

    String fieldName = field.identifier.name;
    parts.addAll([
      "\n\t\t\t",
      hasNamedParameters ? "$fieldName : " : "",
      "json['",
      fieldName,
      "'],"
    ]);
  }

  parts.addAll(["\n\t\t);", "\n\t}"]);

  return parts;
}
