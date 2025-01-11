import 'dart:async';

import './constructors/constructor.dart';
import './constructors/from_json.dart';
import './methods/to_json.dart';
import './methods/to_string.dart';

import 'package:macros/macros.dart';

macro class Data implements ClassDeclarationsMacro{
  
  final bool hasNamedConstructor;

  const Data({this.hasNamedConstructor = true});

  @override
  FutureOr<void> buildDeclarationsForClass(ClassDeclaration clazz, MemberDeclarationBuilder builder) async {
    await Constructor(isNamedConstructor: hasNamedConstructor).buildDeclarationsForClass(clazz, builder);
    await FromJson(hasNamedConstructor: hasNamedConstructor).buildDeclarationsForClass(clazz, builder);
    await ToJson().buildDeclarationsForClass(clazz, builder);
    await ToString().buildDeclarationsForClass(clazz, builder);
  }

}

macro class DataDefinition implements ClassDefinitionMacro{
  
  @override
  FutureOr<void> buildDefinitionForClass(ClassDeclaration clazz, TypeDefinitionBuilder builder) async{
    await ConstructorDefinition().buildDefinitionForClass(clazz, builder);
    await FromJsonDefinition().buildDefinitionForClass(clazz, builder);
    await ToJsonDefinition().buildDefinitionForClass(clazz, builder);
    await ToStringDefinition().buildDefinitionForClass(clazz, builder);
  }

}