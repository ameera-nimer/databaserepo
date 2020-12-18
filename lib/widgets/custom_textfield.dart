import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class CustumTextField extends StatelessWidget{
  Function saveFun ;
  Function validationFun ;
  String lable ;
  CustumTextField(this.lable , this.saveFun , this.validationFun);
  @override
  Widget build(BuildContext context) {
    return TextFormField(
                  onSaved:(value)=> saveFun(value),
                  validator: (value) => validationFun(value),
                  decoration: InputDecoration(
                    labelText: lable,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20))),
                ) ;
  }

}