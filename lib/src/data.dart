import 'dart:async';

import './constructors/constructor.dart';
import './constructors/from_json.dart';
import './methods/to_json.dart';
import './methods/to_string.dart';

import 'package:macros/macros.dart';

/// A macro to generate boilerplate methods and constructors for data classes.
///
/// This macro simplifies the creation of data-centric classes by automatically
/// generating the following:
/// - Constructors (both named and unnamed, depending on configuration)
/// - A `fromJson` method for deserializing objects from JSON
/// - A `toJson` method for serializing objects to JSON
/// - A `toString` method for generating a string representation of the object
///
/// Example usage:
/// ```dart
/// @Data()
/// class Example {
///   final String name;
///   final int age;
/// }
/// ```
/// The above will generate constructors, `fromJson`, `toJson`, and `toString` methods.
macro class Data implements ClassDeclarationsMacro {
  /// Whether the generated class should include a named constructor.
  final bool hasNamedConstructor;

  /// Creates a new instance of the [Data] macro.
  ///
  /// - [hasNamedConstructor]: If `true` (default), includes named constructors.
  const Data({this.hasNamedConstructor = true});

  @override
  /// Builds the declarations for the class, including constructors and methods.
  ///
  /// - [clazz]: The class for which the declarations are generated.
  /// - [builder]: The builder used to add member declarations to the class.
  FutureOr<void> buildDeclarationsForClass(
      ClassDeclaration clazz, MemberDeclarationBuilder builder) async {
    // Generate constructors.
    await Constructor(isNamedConstructor: hasNamedConstructor)
        .buildDeclarationsForClass(clazz, builder);

    // Generate the `fromJson` method.
    await FromJson(hasNamedConstructor: hasNamedConstructor)
        .buildDeclarationsForClass(clazz, builder);

    // Generate the `toJson` method.
    await ToJson().buildDeclarationsForClass(clazz, builder);

    // Generate the `toString` method.
    await ToString().buildDeclarationsForClass(clazz, builder);
  }
}

/// A macro to define and augment boilerplate methods for data classes.
///
/// This macro complements the `Data` macro by providing the method
/// implementations for the previously declared methods, such as:
/// - Constructors
/// - `fromJson`
/// - `toJson`
/// - `toString`
macro class DataDefinition implements ClassDefinitionMacro {
  @override
  /// Builds and augments the method definitions for the class.
  ///
  /// - [clazz]: The class for which the methods are augmented.
  /// - [builder]: The builder used to define and augment method bodies.
  FutureOr<void> buildDefinitionForClass(
      ClassDeclaration clazz, TypeDefinitionBuilder builder) async {
    // Define constructors.
    await ConstructorDefinition().buildDefinitionForClass(clazz, builder);

    // Define the `fromJson` method.
    await FromJsonDefinition().buildDefinitionForClass(clazz, builder);

    // Define the `toJson` method.
    await ToJsonDefinition().buildDefinitionForClass(clazz, builder);

    // Define the `toString` method.
    await ToStringDefinition().buildDefinitionForClass(clazz, builder);
  }
}