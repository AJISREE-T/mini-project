import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:trashcan/common/colors.dart';
import 'package:intl/intl.dart';
class ViewAction extends StatefulWidget {
  var uid;
  var fullname;
  var address;
  var place;
  var pincode;
  var phone_no;
  ViewAction({Key? key,this.uid,this.fullname,this.address,this.place,this.pincode,this.phone_no}) : super(key: key);

  @override
  _ViewActionState createState() => _ViewActionState();
}

class _ViewActionState extends State<ViewAction> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgcolor,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Action",
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
                  stream: FirebaseFirestore.instance
                      .collection('Complaint')
                      .where('status', isEqualTo: 1).where('userid',isEqualTo: widget.uid)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData)
                      return Center(child: CircularProgressIndicator());
                    else if (snapshot.hasData &&
                        snapshot.data?.docs.length == 0)
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
                              child: Column(
                                children: [
                                  ListTile(
                                    title:Text('Complaint: '+snapshot.data?.docs[index]['compdescription']) ,
                                    leading: Text('Date: '+DateFormat('dd-MM-yy').format( snapshot.data?.docs[index]['date'].toDate()),
                                      style: TextStyle(fontSize:18,),
                                    ),
                                    subtitle:snapshot.data?.docs[index]['solution']!=null? Text('Action: '+snapshot.data?.docs[index]['solution']): Text('Action: No Actions'),



                                  ),


                                ],
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
