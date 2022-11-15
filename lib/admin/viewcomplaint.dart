import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:trashcan/admin/orderdetail.dart';
import 'package:trashcan/admin/replycomplaint.dart';
import 'package:trashcan/collectingagent/wastedetails.dart';
import 'package:trashcan/common/colors.dart';

class ComPage extends StatefulWidget {
  var cid;
  ComPage({Key? key,this.cid}) : super(key: key);

  @override
  _ComPageState createState() => _ComPageState();
}

class _ComPageState extends State<ComPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgcolor,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Complaints",
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
                      .where('status', isEqualTo: 1)
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
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Card(
                            elevation: 6,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ReplyComplaint(
                                          cid:  snapshot.data?.docs[index]
                                          ['cid'],
                                        )));
                              },
                              child: Column(
                                children: [
                                  Text(
                                    'User Name:  ' + snapshot.data?.docs[index]['uname'],
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    'Subject:  ' + snapshot.data?.docs[index]['compdescription'],style: TextStyle(
                                    fontSize: 18,
                                  ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      });
                }
              ),
            ),
          ],
        ),
      ),
    );
  }
}
