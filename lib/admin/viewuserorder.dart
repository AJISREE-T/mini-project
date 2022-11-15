import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:trashcan/admin/orderdetail.dart';
import 'package:trashcan/collectingagent/wastedetails.dart';
import 'package:trashcan/common/colors.dart';

class UserOrder extends StatefulWidget {
  var price;
  var pname;
  var pid;
  var uid;
  var fullname;
  var address;
  var place;
  var pincode;
  var phone_no;
  UserOrder({Key? key,this.pname,this.pid,this.price,this.uid,this.fullname,this.address,this.place,this.pincode,this.phone_no}) : super(key: key);

  @override
  _UserOrderState createState() => _UserOrderState();
}

class _UserOrderState extends State<UserOrder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgcolor,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "User Orders",
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
                                            builder: (context) => OrderDet(


                                              orderStats: snapshot.data?.docs[index]['ostatus'],
                                              pname:  snapshot.data?.docs[index]
                                            ['pname'],
                                              price:snapshot.data?.docs[index]
                                              ['price'],
                                              pid: snapshot.data?.docs[index]
                                              ['pid'],
                                              uid: snapshot.data?.docs[index]
                                              ['userid'],
                                              fullname: snapshot.data?.docs[index]
                                              ['uname'],
                                              address: snapshot.data?.docs[index]
                                              ['uaddress'],
                                              pincode: snapshot.data?.docs[index]
                                              ['upin'],
                                              tid: snapshot.data?.docs[index]
                                              ['pay_id'],

                                            )));
                                  },
                                  child: Column(
                                    children: [
                                      Text(
                                        'User Name:  ' +
                                            snapshot.data?.docs[index]['uname'],
                                        style: TextStyle(
                                          fontSize: 18,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        'Product Name:  ' +
                                            snapshot.data?.docs[index]['pname'],
                                        style: TextStyle(
                                          fontSize: 18,
                                        ),
                                      ),
                                    ],
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
}
