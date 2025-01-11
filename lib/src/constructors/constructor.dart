import 'dart:async';
import 'package:macros/macros.dart';

/// <h1>Constructor</h1>
/// It's the macro to automatically generate your constructors
macro class Constructor implements ClassDeclarationsMacro {
  final bool isNamedConstructor;

  const Constructor({
    this.isNamedConstructor = true,
  });

  @override
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


    builder.declareInType(DeclarationCode.fromParts(_generateConstructor(fields, className, isNamedConstructor)));

  }
}

macro class ConstructorDefinition implements ClassDefinitionMacro {
  @override
  FutureOr<void> buildDefinitionForClass(
      ClassDeclaration clazz, TypeDefinitionBuilder builder) async {

    final constructorBuild =
        await builder.buildConstructor(clazz.identifier);

    constructorBuild.augment(
      body: FunctionBodyCode.fromString(';'),
    );
  }
}


List<String> _generateConstructor(List<FieldDeclaration> fields, String className, bool isNamedConstructor){
  List<String> parts = ["\n\t", className, "(","{", "\n"];
  
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

  // In case there's only one static or one initialized field
  if (fields.length == 1 &&
      (fields[0].hasStatic || fields[0].hasInitializer) ||
      !isNamedConstructor || fields.isEmpty) {
    parts.removeWhere((part) => part == "{" || part == "}");
  }

  parts.add(");");

  return parts;
}