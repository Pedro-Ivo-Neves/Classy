import 'dart:async';

// ignore: depend_on_referenced_packages
import 'package:macros/macros.dart';

///<h1>Contructor</h1>
///It's the macro to generate automatically your contructors
macro class Constructor implements ClassDeclarationsMacro{

  final bool isNamedConstructor;

  const Constructor({
    this.isNamedConstructor = true
  });

  @override
  Future<void> buildDeclarationsForClass(ClassDeclaration clazz, MemberDeclarationBuilder builder) async {
    final List<ConstructorDeclaration> constructors = await builder.constructorsOf(clazz);

    String className = clazz.identifier.name;

    if(constructors.any((constructor)=>constructor.identifier.name=='')) throw ArgumentError("Can't Generate Constructor cause it already exists one Constructor Called '$className'");

    // Parts -> It's the list of Strings (parts) that it will be used to construct the Constructor
    List<String> parts = ["\t",className,"("];

    
    //If it Extends or it has a SuperClass
    // final NamedTypeAnnotation? superClass = clazz.superclass;

    parts.addAll(
      ["{","\n"]
    );

    // if(superClass != null){
    //   final lol = superClass.code;


      
    // }

    // Fields -> The fields/attributes/proprities of the class
    List<FieldDeclaration> fields = await builder.fieldsOf(clazz);

    if(fields.isNotEmpty){

      
      for(FieldDeclaration field in fields){

        if(field.hasStatic || field.hasInitializer) continue;

        parts.add("\t\t");
        if(!field.type.isNullable && !field.hasInitializer && isNamedConstructor) parts.addAll(["required", " "]);

        parts.add("this.");
        parts.add(field.identifier.name);
        if (fields.last != field){
          parts.add(",\n");
        }
      }


      parts.addAll(["\n\t","}"]);

      //In case there's only one static or one Initialized field
      if(
        fields.length == 1 && (
          fields[0].hasStatic || 
          fields[0].hasInitializer
        ) || !isNamedConstructor
      ) {
        parts.removeWhere(
          (part)=> part=="{" || part=="}"
        );
      }
    } 


    parts.add(")");


    parts.add(";");

    builder.declareInType(DeclarationCode.fromParts(parts));
  }

}

