import 'dart:async';

// ignore: depend_on_referenced_packages
import 'package:macros/macros.dart';

macro class ToJson implements ClassDeclarationsMacro{

  const ToJson();

  @override
  FutureOr<void> buildDeclarationsForClass(ClassDeclaration clazz, MemberDeclarationBuilder builder) async{

    List<MethodDeclaration> methods = await builder.methodsOf(clazz);

    if(
      methods.any(
        (method)=> method.identifier.name == 'toJson'
      )
    ) {
      throw ArgumentError('Can\'t Generate ToJson, cause it already Exists a ToJson Method');
    }
    
    final List<FieldDeclaration> fields = await builder.fieldsOf(clazz);

    builder.declareInType(
      DeclarationCode.fromParts(
        _generateToJson(fields)
      )
    );
  }
}

macro class ToJsonDefinition implements ClassDefinitionMacro{

  @override
  FutureOr<void> buildDefinitionForClass(ClassDeclaration clazz, TypeDefinitionBuilder builder) async{

    final methods = await builder.methodsOf(clazz);

    if(
      methods.any(
        (method)=> method.identifier.name == 'toJson'
      )
    ) {
      throw ArgumentError('Can\'t Generate ToJson, cause it already Exists a ToJson Method');
    }

    final List<FieldDeclaration> fields = await builder.fieldsOf(clazz);

    final FunctionDefinitionBuilder toJsonBuilder = await builder.buildMethod(clazz.identifier);

    toJsonBuilder.augment(
      FunctionBodyCode.fromParts(
        _generateToJson(fields)
      )
    );

  }

}

List<String> _generateToJson(List<FieldDeclaration> fields){

  List<String> parts = ["\n\t","Map<String,dynamic> toJson(){","\n"];

  parts.addAll(["\t\t","return {"]);

  if(fields.isNotEmpty){
    for(FieldDeclaration field in fields){

      if(field.hasStatic) continue;
      
      String fieldName = field.identifier.name;
      parts.addAll(["\n\t\t\t'",fieldName,"': this.",fieldName,","]);
    }
  } else{
    parts.add('');
  }

  parts.removeLast();
  
  parts.addAll(["\n\t\t","};","\n\t","}"]);

  return parts;

}