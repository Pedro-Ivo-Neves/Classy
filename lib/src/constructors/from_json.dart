import 'dart:async';

// ignore: depend_on_referenced_packages
import 'package:macros/macros.dart';


macro class FromJson implements ClassDeclarationsMacro{

  final bool hasNamedConstructor;

  const FromJson({this.hasNamedConstructor = true});

  @override
  Future<void> buildDeclarationsForClass(ClassDeclaration clazz, MemberDeclarationBuilder builder) async {

    // final classConstructors = await builder.constructorsOf(clazz);

    // final constructor = classConstructors.firstWhere(
    //   (constructor) => constructor.identifier.name == '',
    //   orElse: () => throw StateError("No fields available for FromJson to work on."),
    // );
    
    final String constructorName = clazz.identifier.name;    

    final List<FieldDeclaration> fields = await builder.fieldsOf(clazz);

    builder.declareInType(
      DeclarationCode.fromParts(
        _generateFromJson(
          fields: fields, 
          constructorName: constructorName, 
          hasNamedParameters: hasNamedConstructor
        )
      )
    );
  }

}

macro class FromJsonDefinition implements ClassDefinitionMacro{

  @override
  FutureOr<void> buildDefinitionForClass(ClassDeclaration clazz, TypeDefinitionBuilder builder) async{

    // final classConstructors = await builder.constructorsOf(clazz);

    // final constructor = classConstructors.firstWhere(
    //   (constructor) => constructor.identifier.name == '',
    //   orElse: () => throw StateError("No fields available for FromJson to work on."),
    // );

    final constructorName = clazz.identifier.name;

    final List<FieldDeclaration> fields = await builder.fieldsOf(clazz);

    final fromJsonBuild = await builder.buildMethod(clazz.identifier);

    fromJsonBuild.augment(
      FunctionBodyCode.fromParts(
        _generateFromJson(
          fields: fields, 
          constructorName: constructorName, 
          hasNamedParameters: FromJson().hasNamedConstructor
        )
      )
    );

  }

}


List<String> _generateFromJson({
  required List<FieldDeclaration> fields, 
  required String constructorName, 
  required bool hasNamedParameters
}){
  final List<String> parts = ["\t"];

  parts.addAll(['\n\tfactory ',constructorName,".fromJson(Map<String,dynamic> json){\n","\t\treturn ", constructorName, "("]);

  for(var field in fields){

    if(field.hasStatic) continue;
    
    String fieldName = field.identifier.name;
    parts.addAll([
      "\n\t\t\t",
      hasNamedParameters
      ? 
      "$fieldName : "
      : "",
      "json['",fieldName,"'],"
    ]);
  }

  parts.addAll(["\n\t\t);","\n\t}"]);

  return parts;
}