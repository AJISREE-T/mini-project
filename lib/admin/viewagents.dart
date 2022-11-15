import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:trashcan/admin/agentdetail.dart';
import 'package:trashcan/common/colors.dart';
class ViewAgent extends StatefulWidget {

  ViewAgent({Key? key}) : super(key: key);

  @override
  _ViewAgentState createState() => _ViewAgentState();
}

class _ViewAgentState extends State<ViewAgent> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgcolor,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Agents",
          style: TextStyle(
            fontSize: 25,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Color(0xff01579b),
        elevation: 22,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.elliptical(20, 30)),
          side: BorderSide(
            width: 4,
            color: Color(0xff8bc34a),
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance.collection('Collecting Agent').snapshots(),
                  builder: (context, snapshot) {
                    if(!snapshot.hasData)
                      return Center(child: CircularProgressIndicator());
                    else if(snapshot.hasData && snapshot.data?.docs.length==0)
                      return Center(child: Text("No data found"));
                    else
                    return ListView.builder(
                        itemCount: snapshot.data?.docs.length,
                        itemBuilder: (BuildContext context,int index){


                        return  Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Card(
                            elevation: 6,
                            child: GestureDetector(
                              onTap:(){
                                Navigator.pushReplacement(context,
                                    MaterialPageRoute(builder:(context)=>AgentPage(uid:snapshot.data?.docs[index]['uid'] ,fullname: snapshot.data?.docs[index]['fullname'],address: snapshot.data?.docs[index]['address'],phone_no: snapshot.data?.docs[index]['phone_no'],place: snapshot.data?.docs[index]['place'],pincode: snapshot.data?.docs[index]['pincode']))
                                );

                              },
                              child: ListTile(
                                title: Text(snapshot.data!.docs[index]['fullname'],
                                  style: TextStyle(fontSize:20,),
                                ),
                                subtitle: Text(snapshot.data!.docs[index]['place'],) ,
                                leading: snapshot.data!.docs[index]['status']==1?Icon(Icons.check_circle,color: Color(0xff01579b)):SizedBox.shrink(),


                              ),
                            ),

                          ),
                        );
                      }
                  );
                }
              ),
            ),



          ],

        ),

      ),
    );
  }
}
