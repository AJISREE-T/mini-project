import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:trashcan/common/colors.dart';
import 'package:intl/intl.dart';

class ViewWaste extends StatefulWidget {
  var uid;
  var fullname;
  var address;
  var place;
  var pincode;
  var phone_no;
  ViewWaste(
      {Key? key,
      this.uid,
      this.fullname,
      this.address,
      this.place,
      this.pincode,
      this.phone_no})
      : super(key: key);

  @override
  _ViewWasteState createState() => _ViewWasteState();
}

class _ViewWasteState extends State<ViewWaste> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgcolor,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "View Requestes",
          style: TextStyle(
            fontSize: 22,
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
                      .collection('Ewaste')
                      .where('status', isEqualTo: 1)
                      .snapshots(),
                  builder: (context, snapshot) {  if (!snapshot.hasData)
                    return Center(child: CircularProgressIndicator());

                    else if (snapshot.hasData &&
                        snapshot.data?.docs.length == 0)
                      return Center(child: Text("No data found"));
                    else
                      return ListView.builder(
                          itemCount: snapshot.data?.docs.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Card(
                                elevation: 6,
                                child: GestureDetector(
                                  onTap: () {
                                    // Navigator.pushReplacement(context,
                                    //     MaterialPageRoute(builder:(context)=>StudentProfile())
                                    // );
                                  },
                                  child: ListTile(
                                    title: Text(
                                      snapshot.data?.docs[index]['wtype'],
                                      style: TextStyle(
                                        fontSize: 20,
                                      ),
                                    ),
                                    subtitle: Text(
                                      DateFormat('dd-MM-yy').format(snapshot
                                          .data?.docs[index]['date']
                                          .toDate()),
                                    ),
                                    trailing: (snapshot.data!.docs[index]
                                    ['agentacceptstatus'] ==
                                        0 &&  snapshot.data!.docs[index]
                                    ['completestatus'] ==
                                        0)
                                        ? Container(
                                      width: 200,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                             IconButton(onPressed: (){

                                               showalertdialog(
                                                   context,
                                                   snapshot.data?.docs[index]
                                                   ['wid']);
                                             }, icon: Icon(Icons.delete)
                                             ),
                                             IconButton(onPressed: (){

                                               showeditalertdialog(
                                                   context,
                                                   snapshot.data?.docs[index]
                                                   ['wid'],
                                                   snapshot.data?.docs[index]
                                                   ['description'],
                                                 snapshot.data?.docs[index]
                                                 ['wtype'],


                                               );
                                             }, icon: Icon(Icons.edit)
                                             ),

                                            ],
                                          ),
                                        )
                                        : (snapshot.data!.docs[index]
                                    ['completestatus'] ==
                                        1 && snapshot.data!.docs[index]
                                    ['agentacceptstatus'] ==
                                        1)
                                            ? Text("Order Completed")
                                            : snapshot.data!.docs[index]
                                                        ['agentacceptstatus'] ==
                                                    1
                                                ? Text("Agent Accepted")
                                                : Text("Pending"),
                                  ),
                                ),
                              ),
                            );
                          });
                  }),
            ),
          ],
        ),
      ),
    );
  }

  showalertdialog(BuildContext context, var uid) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Alert"),
            content: Text("Are you sure ?"),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    FirebaseFirestore.instance
                        .collection('Ewaste')
                        .doc(uid)
                        .update({
                      'status': 0,
                    }).then((value) {
                      Navigator.pop(context);
                    });
                  },
                  child: Text("Ok")),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Cancel")),
            ],
          );
        });
  }

  showeditalertdialog(BuildContext context, var uid,var price, var data) {
    TextEditingController category=TextEditingController();
    TextEditingController desc=TextEditingController();

    setState(() {
      category.text=data;
      desc.text=price;

    });

    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Edit Details"),
            content: Container(
              height: 250,

              child: Column(

                children: [

                  TextFormField(
                    readOnly: true,
                    controller: category,

                  ),
                  TextFormField(
                    controller: desc,
                  ),
                ],
              ),

            ),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    FirebaseFirestore.instance
                        .collection('Ewaste')
                        .doc(uid)
                        .update({
                      'description': desc.text,
                    }).then((value) {
                      Navigator.pop(context);
                    });
                  },
                  child: Text("Ok")),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Cancel")),
            ],
          );
        });
  }
}
