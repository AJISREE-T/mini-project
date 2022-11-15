import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:trashcan/common/colors.dart';
import 'package:intl/intl.dart';
class ViewOrder extends StatefulWidget {
  var uid;
  var fullname;
  var address;
  var place;
  var pincode;
  var phone_no;
  ViewOrder({Key? key,this.uid,this.fullname,this.address,this.place,this.pincode,this.phone_no}) : super(key: key);

  @override
  _ViewOrderState createState() => _ViewOrderState();
}

class _ViewOrderState extends State<ViewOrder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgcolor,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "View Orders",
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
                      .collection('Order')
                      .where('status', isEqualTo: 1)
                      .where('userid', isEqualTo: widget.uid)
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


                              },
                              child: Column(
                                children: [
                                  ListTile(
                                    title: Text('Product Name: '+snapshot.data?.docs[index]['pname'],
                                      style: TextStyle(fontSize:18,),
                                    ),
                                    subtitle:snapshot.data?.docs[index]['ostatus']==2? Text('Status: Shipped'+'\n'+"Date: "+DateFormat('dd-MM-yy').format( snapshot.data?.docs[index]['date'].toDate()),):
                                    snapshot.data?.docs[index]['ostatus']==1?Text('Status: Packed'+'\n'+"Date: "+DateFormat('dd-MM-yy').format( snapshot.data?.docs[index]['date'].toDate()),):
                                    snapshot.data?.docs[index]['ostatus']==3?Text('Status: Delivered'+'\n'+"Date: "+DateFormat('dd-MM-yy').format( snapshot.data?.docs[index]['date'].toDate()),):Text('Status: Placed'+'\n'+"Date: "+DateFormat('dd-MM-yy').format( snapshot.data?.docs[index]['date'].toDate()),),
                                    trailing:snapshot.data?.docs[index]['ostatus']==0 || snapshot.data?.docs[index]['ostatus']==1? Container(
                                        width: 80,
                                        height: 40,
                                        child: ElevatedButton(
                                          onPressed: () {
                                            showalertdialog(context,snapshot.data?.docs[index]['pay_id']);

                                          },
                                          child: Text(
                                            "Cancel",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.white,
                                            ),
                                          ),
                                          style: ElevatedButton.styleFrom(
                                              primary: Color(0xff01579b),
                                              side: BorderSide(
                                                color: Color(0xff64dd17),
                                                width: 2,
                                              ),
                                              shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(12))),
                                        )):SizedBox.shrink(),


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
  showalertdialog(BuildContext context,var oid)
  {
    return showDialog(context: context,
        builder: (context){
          return AlertDialog(
            title: Text("Alert"),
            content: Text("Are you sure ?"),
            actions: [
              ElevatedButton(onPressed: (){
                FirebaseFirestore.instance.collection('Order').doc(oid).delete().then((value) => Navigator.pop(context));
              },
                  child: Text("Ok")),
              ElevatedButton(onPressed: (){
                Navigator.pop(context);
              },
                  child: Text("Cancel")),
            ],
          );

        }
    );
  }
}
