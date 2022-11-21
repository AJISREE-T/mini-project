import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:trashcan/collectingagent/quote.dart';
import 'package:trashcan/common/colors.dart';

class MyQuote extends StatefulWidget {
  var uid;
  var fullname;
  var address;
  var place;
  var pincode;
  var phone_no;
  MyQuote(
      {Key? key,
      this.uid,
      this.fullname,
      this.address,
      this.place,
      this.pincode,
      this.phone_no})
      : super(key: key);

  @override
  _MyQuoteState createState() => _MyQuoteState();
}

class _MyQuoteState extends State<MyQuote> {
  var qid;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgcolor,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "My Quotes",
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
                      .collection('Quote')
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
                              child: GestureDetector(
                                onTap: () {},
                                child: Container(
                                  height: 390,
                                  child: Card(
                                    elevation: 3,
                                    child: Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  'User Name: ',
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              Expanded(
                                                child: Text(
                                                  snapshot.data?.docs[index]
                                                      ['username'],
                                                  style:
                                                      TextStyle(fontSize: 18),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  'Category: ',
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              Expanded(
                                                child: Text(
                                                  snapshot.data?.docs[index]
                                                      ['wastetype'],
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  'Price: ',
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              Expanded(
                                                child: Text(
                                                  snapshot.data?.docs[index]
                                                      ['price'],
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  'Pin Code: ',
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              Expanded(
                                                child: Text(
                                                  snapshot.data?.docs[index]
                                                      ['userpincode'],
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  'Date: ',
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              Expanded(
                                                child: Text(
                                                  snapshot.data?.docs[index]
                                                      ['collectiondate'],
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  'status: ',
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              Expanded(
                                                child: (snapshot.data?.docs[index]['useracceptstatus'] == 1 &&
                                                        snapshot.data?.docs[index]['completestatus'] ==
                                                            0 &&
                                                        snapshot.data!.docs[index]
                                                                [
                                                                'datechangestatus'] ==
                                                            0)
                                                    ? Text(
                                                        'User Accepted',
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            color:
                                                                Colors.yellow),
                                                      )
                                                    : (snapshot.data?.docs[index]['useracceptstatus'] == 1 &&
                                                            snapshot.data?.docs[index]['completestatus'] ==
                                                                0 &&
                                                            snapshot.data!.docs[index]['datechangestatus'] ==
                                                                1)
                                                        ? Text(
                                                            'Accepted. Date Changed',
                                                            style: TextStyle(
                                                                fontSize: 18,
                                                                color: Colors
                                                                    .green),
                                                          )
                                                        : (snapshot.data?.docs[index]['useracceptstatus'] == 1 &&
                                                                snapshot.data?.docs[index]['completestatus'] ==
                                                                    1)
                                                            ? Text(
                                                                'Order Complete',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        18,
                                                                    color: Colors
                                                                        .green),
                                                              )
                                                            : Text("Pending",
                                                                style: TextStyle(
                                                                    fontSize: 18,
                                                                    color: Colors.red)),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 25,
                                          ),

                                          (snapshot.data?.docs[index]['useracceptstatus'] ==
                                              1&&
                                              snapshot.data?.docs[index]
                                              ['completestatus'] ==
                                                  0 &&
                                              snapshot.data!.docs[index]['datechangestatus'] == 1 && snapshot.data!.docs[index]['cstatus']==0)
                                              ? Container(
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: InkWell(
                                                    onTap: () {
                                                      FirebaseFirestore
                                                          .instance
                                                          .collection(
                                                          'Quote')
                                                          .doc(snapshot
                                                          .data
                                                          ?.docs[index]['qid'])
                                                          .update({
                                                        'cstatus':
                                                        2,
                                                      }).then((value) {
                                                        showsnackbar(
                                                            "Change Accepted");
                                                        Navigator.pop(
                                                            context);
                                                      });
                                                    },
                                                    child:
                                                    Container(
                                                      height: 45,
                                                      child: Text(
                                                          "Accept Date Change",
                                                          style: TextStyle(
                                                              fontSize:
                                                              18,
                                                              color:
                                                              Colors.green)),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                InkWell(
                                                  onTap: () {

                                                    FirebaseFirestore
                                                        .instance
                                                        .collection(
                                                        'Quote')
                                                        .doc(snapshot
                                                        .data
                                                        ?.docs[index]['qid'])
                                                        .update({
                                                      'cstatus':
                                                      1,
                                                    }).


                                                    then((value) {
                                                      print(snapshot
                                                          .data?.docs[
                                                      index]['qid']);

                                                      FirebaseFirestore
                                                          .instance
                                                          .collection(
                                                          'Ewaste')
                                                          .doc(snapshot
                                                          .data
                                                          ?.docs[
                                                      index]
                                                      ['wasteid'])
                                                          .update({
                                                        'agentacceptstatus':0

                                                      });
                                                    }).
                                                    then((value) {
                                                      showsnackbar(
                                                          "Change Rejected");
                                                      Navigator.pop(
                                                          context);
                                                    });
                                                  },
                                                  child: Expanded(
                                                    child:
                                                    Container(
                                                      height: 45,
                                                      child: Text(
                                                          "Reject and Cancel ",
                                                          style: TextStyle(
                                                              fontSize:
                                                              18,
                                                              color:
                                                              Colors.green)),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ):SizedBox.shrink(),
                                          (snapshot.data?.docs[index]['useracceptstatus'] == 0 &&
                                                  snapshot.data?.docs[index]
                                                          ['completestatus'] ==
                                                      0 &&
                                                  snapshot.data!.docs[index][
                                                          'datechangestatus'] ==
                                                      0)
                                              ? Container(
                                                  width: 150,
                                                  height: 50,
                                                  child: ElevatedButton(
                                                    onPressed: () {
                                                      FirebaseFirestore.instance
                                                          .collection('Quote')
                                                          .doc(snapshot.data
                                                                  ?.docs[index]
                                                              ['qid'])
                                                          .update({
                                                        'status': 0,
                                                      }).then((value) {
                                                        showsnackbar(
                                                            "Quote Cancelled");
                                                        Navigator.pop(context);
                                                      });
                                                    },
                                                    child: Text(
                                                      "Cancel",
                                                      style: TextStyle(
                                                        fontSize: 18,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                            primary: Color(
                                                                0xff01579b),
                                                            side: BorderSide(
                                                              color: Color(
                                                                  0xff64dd17),
                                                              width: 2,
                                                            ),
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            12))),
                                                  ))
                                              : (snapshot.data?.docs[index]['useracceptstatus'] ==
                                              1 &&
                                              snapshot.data?.docs[index][
                                              'completestatus'] ==
                                                  0   )
                                                  ? Container(
                                                      width: 250,
                                                      height: 50,
                                                      child: ElevatedButton(
                                                        onPressed: () {
                                                          FirebaseFirestore
                                                              .instance
                                                              .collection(
                                                                  'Quote')
                                                              .doc(snapshot.data
                                                                      ?.docs[
                                                                  index]['qid'])
                                                              .update({
                                                            'completestatus': 1,
                                                          }).then((value) {
                                                            print(snapshot
                                                                    .data?.docs[
                                                                index]['qid']);

                                                            FirebaseFirestore
                                                                .instance
                                                                .collection(
                                                                    'Ewaste')
                                                                .doc(snapshot
                                                                            .data
                                                                            ?.docs[
                                                                        index]
                                                                    ['wasteid'])
                                                                .update({
                                                              'completestatus':
                                                                  1,
                                                            });
                                                          }).then((value) {
                                                            showsnackbar(
                                                                "Completed");
                                                            Navigator.pop(
                                                                context);
                                                          });
                                                        },
                                                        child: Text(
                                                          "Mark as Complete",
                                                          style: TextStyle(
                                                            fontSize: 18,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                                primary: Color(
                                                                    0xff01579b),
                                                                side:
                                                                    BorderSide(
                                                                  color: Color(
                                                                      0xff64dd17),
                                                                  width: 2,
                                                                ),
                                                                shape: RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            12))),
                                                      ))

                                                      : Text("Order Complete"),




                                        ],
                                      ),
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

  showsnackbar(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg),
      backgroundColor: Colors.black12,
    ));
  }
}
