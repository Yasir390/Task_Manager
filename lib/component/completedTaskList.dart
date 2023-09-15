import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../api/apiClient.dart';
import '../style/style.dart';
import 'TaskList.dart';

class completedTaskList extends StatefulWidget {
  const completedTaskList({Key? key}) : super(key: key);

  @override
  State<completedTaskList> createState() => _completedTaskListState();
}

class _completedTaskListState extends State<completedTaskList> {


  List TaskItems=[];
  bool Loading=true;
  String Status="Completed";

  @override
  void initState(){
    CallData();
    super.initState();
  }


  CallData() async{
    var data=await TaskListRequest("Completed");
    setState(() {
      Loading=false;
      TaskItems=data;
    });
  }



  UpdateStatus(id) async {
    setState((){
      Loading=true;
    });
    await  TaskUpdateRequest(id, Status);
    await CallData();
    setState((){
      Status="Completed";
    });
  }



  DeleteItem(id) async{
    showDialog(
        context:context ,
        builder: (BuildContext context){
          return AlertDialog(
            title: Text("Delete !"),
            content: Text("Once delete, you can't get it back !"),

            actions: [
              OutlinedButton(
                child: Text("Yes"),
                onPressed: () async {
                  Navigator.pop(context);
                  setState(() {
                    Loading=true;
                  });
                  await  TaskDeleteRequest(id);
                  await CallData();
                },
              ),

              OutlinedButton(
                child: Text("No"),
                onPressed: (){
                  Navigator.pop(context);
                },
              )
            ],
          );
        });
  }

  StatusChange(id) async{
    showModalBottomSheet(
        context: context,
        builder: (context){
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState){
                return Container(
                  padding: EdgeInsets.all(30),
                  height: 300,
                  child: Column(

                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      RadioListTile(
                          title: Text("New"),
                          value: "New",
                          groupValue: Status,
                          onChanged: (value){
                            setState((){
                              Status=value.toString();
                            });
                          }
                      ),
                      RadioListTile(
                          title: Text("Progress"),
                          value: "Progress",
                          groupValue: Status,
                          onChanged: (value){
                            setState((){
                              Status=value.toString();
                            });
                          }
                      ),
                      RadioListTile(
                          title: Text("Completed"),
                          value: "Completed",
                          groupValue: Status,
                          onChanged: (value){
                            setState((){
                              Status=value.toString();
                            });
                          }
                      ),
                      RadioListTile(
                          title: Text("Canceled"),
                          value: "Canceled",
                          groupValue: Status,
                          onChanged: (value){
                            setState((){
                              Status=value.toString();
                            });
                          }
                      ),

                      Container(
                        child: ElevatedButton(
                          style: AppButtonStyle(),
                          child: SuccessButtonChild("Confirm"),
                          onPressed: (){
                            Navigator.pop(context);
                            UpdateStatus(id);
                          },
                        ),
                      )
                    ],
                  ),
                );
              }
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Loading?(Center(child: CircularProgressIndicator(color: colorRed,backgroundColor: Colors.green,),)):(RefreshIndicator(
        child:TaskList(TaskItems,DeleteItem,StatusChange),
        onRefresh: ()async{
          await CallData();
        }
    ));

  }
}
