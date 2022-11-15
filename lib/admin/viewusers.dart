import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:trashcan/common/colors.dart';
class ViewUser extends StatefulWidget {
  const ViewUser({Key? key}) : super(key: key);

  @override
  _ViewUserState createState() => _ViewUserState();
}

class _ViewUserState extends State<ViewUser> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgcolor,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Users",
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
                stream: FirebaseFirestore.instance.collection('User').where('status',isEqualTo: 1).snapshots(),
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
                                // Navigator.pushReplacement(context,
                                //     MaterialPageRoute(builder:(context)=>StudentProfile())
                                // );

                              },
                              child: ListTile(
                                title: Text(snapshot.data?.docs[index]['fullname'],
                                  style: TextStyle(fontSize:20,),
                                ),
                                subtitle: Text(snapshot.data?.docs[index]['place'],) ,
                                trailing: Icon(Icons.check_circle,color: Color(0xff01579b)),

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
