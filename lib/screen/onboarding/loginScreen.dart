import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taskmanager/api/apiClient.dart';
import 'package:taskmanager/style/style.dart';

class loginScreen extends StatefulWidget {
  const loginScreen({Key? key}) : super(key: key);

  @override
  State<loginScreen> createState() => _loginScreenState();
}

class _loginScreenState extends State<loginScreen> {

  Map<String,String> FormValues={"email":"","password":""};
  bool Loading = false;

  InputOnChange(MapKey,Textvalue){

    setState(() {
      FormValues.update(MapKey, (value) => Textvalue);
    });
  }



  FormOnSubmit() async{

    if(FormValues["email"]!.length==0){
      ErrorToast("Email Required");
    }
    else if(FormValues["password"]!.length==0){
      ErrorToast("Password Required");
    }

    else{
      setState(() {
        Loading = true; // here Loading is bool variable.which we declare in above
      });

      bool res= await LoginRequest(FormValues);

      if(res==true){
        //Navigate to Home page
        Navigator.pushNamedAndRemoveUntil(context, "/", (route) => false);
      }

      else{
        setState(() {
          Loading=false;
        });
      }

    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body: Stack(
       children: [
         BackgroundImage(context),
         Container(
           alignment: Alignment.center,
           child: Loading?(Center(child: CircularProgressIndicator(),)):(SingleChildScrollView(
              padding: EdgeInsets.all(30),
               child: Column(
               mainAxisAlignment: MainAxisAlignment.center,
               crossAxisAlignment: CrossAxisAlignment.start,

               children: [
               Text("Get Starated With",style: Head1Text(colorDarkBlue),),
         SizedBox(height: 1 ,),
         Text("YASIR ARAFAT",style: Head6Text(colorLightGray),),
         SizedBox(height: 20 ,),

         TextFormField(
           decoration: AppInputDecoration("Email Address"),
           onChanged: (Textvalue){
             InputOnChange("email", Textvalue);
           },
         ),

         SizedBox(height: 20 ,),

         TextFormField(
           decoration: AppInputDecoration("Password"),
           onChanged: (Textvalue){
             InputOnChange("password", Textvalue);
           },
         ),
         SizedBox(height: 20 ,),

         Container(
             child: ElevatedButton(
               style: AppButtonStyle(),
               child:SuccessButtonChild("Login"),
               onPressed: (){
                 FormOnSubmit();
               },
             )
         ),

         SizedBox(height: 20 ,),

         Container(
           alignment: Alignment.center,
           child: Column(
             children: [
               SizedBox(height: 20 ,),
               InkWell(
                 onTap: (){
                   Navigator.pushNamed(context, "/emailVerification");
                 },
                 child: Text("Forget Password?",style: Head7Text(colorLightGray),),
               ),
               SizedBox(height: 15 ,),

               InkWell(
                 onTap: (){
                   Navigator.pushNamed(context, "/registration");
                 },

                 child: Row(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                     Text("Don't have an account?",style: Head7Text(colorDarkBlue),),
                     Text("Sign Up",style: Head7Text(colorGreen),),
                   ],
                 ),
               )
             ],
           ),
         )
       ],
     ),
           )),
         )
       ],
     ),
    );
  }
}
