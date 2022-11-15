import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:trashcan/common/colors.dart';
import 'package:trashcan/user/productdetails.dart';

class BuyProduct extends StatefulWidget {
  var uid;
  var fullname;
  var address;
  var place;
  var pincode;
  var phone_no;
  BuyProduct({Key? key,this.uid,this.fullname,this.address,this.place,this.pincode,this.phone_no}) : super(key: key);

  @override
  _BuyProductState createState() => _BuyProductState();
}

class _BuyProductState extends State<BuyProduct> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgcolor,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Products",
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
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance.collection('Eproduct').where('status', isEqualTo: 1 ).snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData)
                          return Center(child: CircularProgressIndicator());
                        else if (snapshot.hasData &&
                            snapshot.data?.docs.length == 0)
                          return Center(child: Text("No data found"));
                        else
                      return GridView.builder(
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 20,
                          ),
                          itemCount:  snapshot.data?.docs.length,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ProductDetail(
                                              img:  snapshot.data?.docs[index]
                                              ['imageurl'],
                                              pname:  snapshot.data?.docs[index]
                                              ['pname'],
                                              price:snapshot.data?.docs[index]
                                              ['price'],
                                              desc: snapshot.data?.docs[index]
                                              ['descrptn'],
                                            pid: snapshot.data?.docs[index]
                                            ['pid'],
                                            uid:widget.uid,fullname:widget.fullname,address:widget.address,pincode:widget.pincode
                                            )));
                              },
                              child: Container(
                                height: 220,
                                width: 170,
                                color: Colors.white,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Image.network(
                                        snapshot.data?.docs[index]
                                        ['imageurl'],
                                        height: 75,
                                        width: 50,
                                      ),
                                      Text(
                                        snapshot.data?.docs[index]
                                        ['pname'],
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 15),
                                      ),
                                      Text(
                                        snapshot.data?.docs[index]
                                        ['price'],
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 12),
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
        ),
      ),
    );
  }
}
