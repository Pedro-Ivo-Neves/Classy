import 'dart:async';

// ignore: depend_on_referenced_packages
import 'package:macros/macros.dart' show ClassDeclaration, ClassDeclarationsMacro, ConstructorDeclaration, DeclarationCode, FieldDeclaration, MemberDeclarationBuilder, MethodDeclaration;

macro class FromJson implements ClassDeclarationsMacro{

  final bool hasFactory;

  const FromJson({
    this.hasFactory = true
  });

  @override
  Future<void> buildDeclarationsForClass(ClassDeclaration clazz, MemberDeclarationBuilder builder) async {
    
    final List<ConstructorDeclaration> constructors = await builder.constructorsOf(clazz);
    
    final String constructorName = clazz.identifier.name;

    if(
      constructors.any(
        (constructor)=> hasFactory ? constructor.isFactory : false 
      )
    ) throw ArgumentError('Can\'t Generate Factory FromJson, cause it already Exists a Factory Method');

    final List<String> parts = ["\t"];

    if(hasFactory){
      parts.add("factory ");
    }

    parts.addAll([constructorName,".fromJson(Map<String,dynamic> json){\n","\t\treturn ", constructorName, "("]);

    final List<FieldDeclaration> fields = await builder.fieldsOf(clazz);

    for(var field in fields){
      
      String fieldName = field.identifier.name;
      
      parts.addAll(["\n\t\t\t",fieldName,": json['",fieldName,"'],"]);
    }

    parts.addAll(["\n\t\t);","\n\t}"]);

    builder.declareInType(DeclarationCode.fromParts(parts));
  }

}