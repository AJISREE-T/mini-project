import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:trashcan/admin/quotedetails.dart';
import 'package:trashcan/common/colors.dart';

class AdminQuote extends StatefulWidget {
  var agentname;
  var username;
  var wastetype;
  var wasteprice;
  var colldate;
  AdminQuote({Key? key}) : super(key: key);

  @override
  _AdminQuoteState createState() => _AdminQuoteState();
}

class _AdminQuoteState extends State<AdminQuote> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgcolor,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "View Quotes",
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
                          child: Card(
                            elevation: 6,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder:(context)=>QuoteDetl(
                                      agentname:snapshot.data?.docs[index]['agentname'] ,
                                      username: snapshot.data?.docs[index]['username'],
                                      wastetype: snapshot.data?.docs[index]['wastetype'],
                                      wasteprice: snapshot.data?.docs[index]['price'],
                                      colldate: snapshot.data?.docs[index]['collectiondate'],
                                    ))
                                );
                              },
                              child: Column(
                                children: [
                                  ListTile(
                                    title: Text(
                                      'Agent: ' + snapshot.data?.docs[index]['agentname'],
                                      style: TextStyle(
                                        fontSize: 20,
                                      ),
                                    ),
                                    subtitle: Text('User: ' + snapshot.data?.docs[index]['username']),
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
