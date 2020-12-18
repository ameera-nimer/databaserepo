import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:string_validator/string_validator.dart';



class RegisterScreen extends StatefulWidget{
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String userName ;

  String email ;

  String password ;

  String confirmPassword ;

  String city ;

  bool isAccepted=false;

  GlobalKey<FormState>  formKey = GlobalKey();

  GlobalKey <ScaffoldState> scaffoldKey = GlobalKey();
  List<String> cities =['gaza' , 'jabalia' , 'rafah' , 'buraij'];

  saveForm(){
    if(formKey.currentState.validate()){
      if(isAccepted==true){
          formKey.currentState.save();
          print('$userName  , $email  , $password  , $city');
      }else{
            scaffoldKey.currentState.showSnackBar(SnackBar(content: Text('you have to accept our condition '),));
      }
      
    }else{
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key:  scaffoldKey,
      appBar:  AppBar(
        title: Text("Register"),),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal : 20 ),
          child: Form(
            key:  formKey,
            child: SingleChildScrollView (
              child: Column(           
              children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: TextFormField(
                  onSaved: (newValue){
                    this.userName=newValue;
                  },
                  validator: (value){
                    if(value == null || value ==""){
                      return 'required field';
                    }
                  },
                  decoration: InputDecoration(
                    labelText: 'User Name ',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20))),
                ),
              ),

              Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: TextFormField(
                  
                  onSaved: (newValue){
                    this.email=newValue;
                  },
                  validator: (value){
                    if(value == null || value ==""){
                      return 'required field';
                    }else if(!isEmail(value)){
                      return 'worong email syntax ';
                    }
                  },
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'Email ',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20))),
                ),
              ),

              Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: TextFormField(
                  onChanged: (value){
                    this.password=value;
                  },
                  onSaved: (newValue){
                    this.password=newValue;
                  },
                  validator: (value){
                    if(value == null || value ==""){
                      return 'required field';
                    }else if (value .length<6){
                      return 'very weak password';
                    }
                  },
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20))),
                ),
              ),

              Container(                
                padding: EdgeInsets.symmetric(vertical: 10 ),
                child: TextFormField(
                  onChanged: (value){
                    this.confirmPassword=value;
                  },
                  onSaved: (newValue){
                    this.confirmPassword=newValue;
                  },
                  validator: (value){
                    if(value == null || value ==""){
                      return 'required field';
                    }else if(this.confirmPassword!=this.password){
                      return 'passwords not matched';
                    }
                  },
                  decoration: InputDecoration(
                    labelText: 'Confirm Password ',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20))),
                ),
              ),
             Container(
                padding: EdgeInsets.symmetric(horizontal:20),
                width: double.infinity,
                decoration: 
                    BoxDecoration(
                    borderRadius: BorderRadius.circular(25) , 
                    border: Border.all(color:Colors.black)),
                child: DropdownButton<String>(
                  hint: Text(city),
                  isExpanded: true,
                  underline: Container(),
                  items: <String>['gaza' , 'jabalia' , 'rafah' , 'buraij']
                    ?.map((e) => DropdownMenuItem<String >(
                        child: Text(e),
                        value: e,
                    ))
                    ?.toList() ??[] , 
                    onChanged: (value){
                        this.city = value;
                        setState(() {});
                    },) ,
              ),
              CheckboxListTile(
                title: Text('Accept All Conditions'),
                value: isAccepted,
                 onChanged: (value){
                this.isAccepted=value;
                setState(() {
                  
                });
                
              }),
              Container(
                width: double.infinity,
                height: 55,
                child: RaisedButton(
                  color: Colors.blueAccent,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                  child: Text('SUBMIT')
                  ,onPressed: (){
                   saveForm();
                },),
              )
             


          ],),
            ),),
        ),
        );
  }
}

