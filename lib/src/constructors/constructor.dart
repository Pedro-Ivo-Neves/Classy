import 'dart:async';
import 'package:macros/macros.dart';

/// A macro to automatically generate constructors for Dart classes.
///
/// This macro inspects the fields of a class and creates either a named or unnamed
/// constructor based on the configuration provided. If a constructor with the
/// same name as the class already exists, it throws an error.
///
/// Example usage:
/// ```dart
/// @Constructor(isNamedConstructor: true)
/// class Example {
///   final String name;
///   final int age;
/// }
/// ```
/// The macro will generate:
/// ```dart
/// Example({
///   required this.name,
///   required this.age,
/// });
/// ```
macro class Constructor implements ClassDeclarationsMacro {
  
  /// Determines whether the generated constructor should be a named constructor.
  ///
  /// Defaults to `true`.
  final bool isNamedConstructor;

  /// Creates a new instance of the [Constructor] macro.
  ///
  /// - [isNamedConstructor]: A boolean value indicating if the constructor should be named.
  const Constructor({
    this.isNamedConstructor = true,
  });

  @override
  /// Builds declarations (constructors) for the target class.
  ///
  /// - [clazz]: The class for which constructors will be generated.
  /// - [builder]: The builder used to create and modify member declarations.
  ///
  /// Throws [ArgumentError] if a constructor with the same name as the class already exists.
  Future<void> buildDeclarationsForClass(
      ClassDeclaration clazz, MemberDeclarationBuilder builder) async {
    final List<ConstructorDeclaration> constructors =
        await builder.constructorsOf(clazz);

    String className = clazz.identifier.name;

    if (constructors.any((constructor) => constructor.identifier.name == '')) {
      throw ArgumentError(
          "Can't generate constructor because there is already one constructor called '$className'");
    }

    List<FieldDeclaration> fields = await builder.fieldsOf(clazz);

    builder.declareInType(DeclarationCode.fromParts(
        _generateConstructor(fields, className, isNamedConstructor)));
  }
}

/// A macro to augment constructor definitions with additional functionality.
///
/// This macro enables additional modification or augmentation of constructors
/// generated for a class. For instance, it provides the capability to define
/// a constructor's body, adding flexibility during macro generation.
macro class ConstructorDefinition implements ClassDefinitionMacro {
  @override
  /// Builds and augments the constructor definition for the target class.
  ///
  /// - [clazz]: The class for which constructor definitions will be generated.
  /// - [builder]: The builder used to augment type-level definitions.
  FutureOr<void> buildDefinitionForClass(
      ClassDeclaration clazz, TypeDefinitionBuilder builder) async {
    final constructorBuild = await builder.buildConstructor(clazz.identifier);

    constructorBuild.augment(
      body: FunctionBodyCode.fromString(';'),
    );
  }
}

/// Generates a list of strings representing the parts of a Dart constructor.
///
/// - [fields]: The fields of the class for which the constructor is generated.
/// - [className]: The name of the class for which the constructor is generated.
/// - [isNamedConstructor]: Indicates whether the constructor should be named.
///
/// Returns a list of strings representing the constructor code.
List<String> _generateConstructor(
    List<FieldDeclaration> fields, String className, bool isNamedConstructor) {
  List<String> parts = ["\n\t", className, "(", "{", "\n"];
  
  if (fields.isNotEmpty) {
    for (FieldDeclaration field in fields) {
      if (field.hasStatic || field.hasInitializer) continue;

      parts.add("\t\t");
      if (!field.type.isNullable &&
          !field.hasInitializer &&
          isNamedConstructor) {
        parts.addAll(["required", " "]);
      }

      parts.add("this.");
      parts.add(field.identifier.name);
      if (fields.last != field) {
        parts.add(",\n");
      }
    }
  }
  
  parts.addAll(["\n\t", "}"]);

  // Remove named constructor syntax if unnecessary
  if (fields.length == 1 &&
      (fields[0].hasStatic || fields[0].hasInitializer) ||
      !isNamedConstructor || fields.isEmpty) {
    parts.removeWhere((part) => part == "{" || part == "}");
  }

  parts.add(");");

  return parts;
}
