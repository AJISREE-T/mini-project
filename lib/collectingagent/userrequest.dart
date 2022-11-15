import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:trashcan/collectingagent/wastedetails.dart';
import 'package:trashcan/common/colors.dart';

class UserReq extends StatefulWidget {
  var uid;
  var fullname;
  var address;
  var place;
  var pincode;
  var phone_no;
  var userid;
  var username;
  var uaddress;
  var userplace;
  var userpincode;
  var wasteid;
  var wastetype;
  var wastedesc;
  UserReq(
      {Key? key,
      this.uid,
      this.fullname,
      this.address,
      this.place,
      this.pincode,
      this.phone_no})
      : super(key: key);

  @override
  _UserReqState createState() => _UserReqState();
}

class _UserReqState extends State<UserReq> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgcolor,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "User Requests",
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
                      .collection('Ewaste')
                      .where('status', isEqualTo: 1).where('completestatus',isEqualTo: 0)
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
                                            builder: (context) => UserWaste(
                                                uid: widget.uid,fullname: widget.fullname,address: widget.address,
                                                phone_no: widget.phone_no,place: widget.place,pincode: widget.pincode,
                                              userid:snapshot.data?.docs[index]['userid'],
                                              username:snapshot.data?.docs[index]['uname'],
                                              uaddress:snapshot.data?.docs[index]['uaddress'],
                                              userplace:snapshot.data?.docs[index]['uplace'],
                                              userpincode:snapshot.data?.docs[index]['pincode'],
                                              wasteid:snapshot.data?.docs[index]['wid'],
                                              wastetype:snapshot.data?.docs[index]['wtype'],
                                              wastedesc:snapshot.data?.docs[index]['description'],
                                            )));
                                  },
                                  child: ListTile(
                                    title: Text(
                                      snapshot.data?.docs[index]['wtype'],
                                      style: TextStyle(
                                        fontSize: 20,
                                      ),
                                    ),
                                    subtitle: Text(
                                      snapshot.data?.docs[index]['uplace'],
                                    ),
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

  showalertdialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Alert"),
            content: Text("Are you sure ?"),
            actions: [
              ElevatedButton(onPressed: () {}, child: Text("Ok")),
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
