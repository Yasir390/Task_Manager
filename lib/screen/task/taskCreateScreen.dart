import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../api/apiClient.dart';
import '../../style/style.dart';

class taskCreateScreen extends StatefulWidget {
  const taskCreateScreen({Key? key}) : super(key: key);

  @override
  State<taskCreateScreen> createState() => _taskCreateScreenState();
}

class _taskCreateScreenState extends State<taskCreateScreen> {

  Map<String,String> FormValues={"title":"","description":"","status":"New"};
  bool Loading=false;

 InputOnChange(MapKey,Textvalue){
   setState(() {
     FormValues.update(MapKey, (value) => Textvalue);
   });
 }

 
 FormOnSubmit() async {
   if(FormValues['title']!.length==0){
     ErrorToast("Title Required !");
   }
   else if(FormValues['description']!.length==0){
     ErrorToast("Description Required !");
   }
   else{
     setState(() {
       Loading=true;
     });
     bool res=await TaskCreateRequest(FormValues);
     if(res==true){
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
      //appBar: AppBar(title: Text("Create New Task"),backgroundColor: colorGreen,),
      body: Stack(
        children: [
          BackgroundImage(context),
          Container(
            alignment: Alignment.topCenter,
            margin: EdgeInsets.only(top: 45),
            child: Loading?(Center(child: CircularProgressIndicator(),)):(SingleChildScrollView(
              padding: EdgeInsets.all(30),

              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [

                  Text("Add New Task",style: Head1Text(colorDarkBlue),),
                  SizedBox(height: 35 ,),


                  TextFormField(
                    decoration: AppInputDecoration("Task Name"),
                    onChanged: (Textvalue){
                      InputOnChange("title", Textvalue);
                    },
                  ),

                  SizedBox(height: 20 ,),

                  TextFormField(
                    decoration: AppInputDecoration("Details"),
                    maxLines: 10,
                    onChanged: (Textvalue){
                      InputOnChange("description", Textvalue);
                    },
                  ),
                  SizedBox(height: 20 ,),

                  Container(
                      child: ElevatedButton(
                        style: AppButtonStyle(),
                        child:SuccessButtonChild("Create"),
                        onPressed: (){
                          FormOnSubmit();
                        },
                      )
                  ),

                  SizedBox(height: 20 ,),


                ],
              ),
            )),
          )
        ],
      ),
    );
  }
}
