import 'dart:async';

import 'package:macros/macros.dart';

macro class ToString implements ClassDeclarationsMacro{
  
  const ToString();
  
  @override
  FutureOr<void> buildDeclarationsForClass(ClassDeclaration clazz, MemberDeclarationBuilder builder) async{
    final methods = await builder.methodsOf(clazz);

    if(
      methods.any(
        (method)=> method.identifier.name == 'ToString'
      )
    ){
      throw ArgumentError('Can\'t Generate ToString, cause it already Exists a ToString Method');
    }

    final String className = clazz.identifier.name;

    final List<FieldDeclaration> fields = await builder.fieldsOf(clazz);

    builder.declareInType(DeclarationCode.fromParts(_generateToString(fields, className)));
  }
  

}

macro class ToStringDefinition implements ClassDefinitionMacro{
  
  @override
  FutureOr<void> buildDefinitionForClass(ClassDeclaration clazz, TypeDefinitionBuilder builder) async{
    final methods = await builder.methodsOf(clazz);

    if(
      methods.any(
        (method)=> method.identifier.name == 'ToString'
      )
    ){
      throw ArgumentError('Can\'t Generate ToString, cause it already Exists a ToString Method');
    }

    final String className = clazz.identifier.name;

    final List<FieldDeclaration> fields = await builder.fieldsOf(clazz);

    final FunctionDefinitionBuilder toStringBuilder = await builder.buildMethod(clazz.identifier);

    toStringBuilder.augment(FunctionBodyCode.fromParts(_generateToString(fields, className)));
  }

}


List<String> _generateToString(List<FieldDeclaration> fields, String className){

  List<String> parts = ["\n\t@override","\n","\tString toString() {","\n", "\t\treturn", " '$className { "];

  if(fields.isNotEmpty){
    for(FieldDeclaration field in fields){
      if(field.hasStatic) continue;
      
      parts.addAll([field.identifier.name,": ", "\$",field.identifier.name, ", "]);
    }
  } else{
    parts.add('');
  }
  parts.removeLast();
  parts.addAll([" }';","\n","\t}"]);
  return parts;
}