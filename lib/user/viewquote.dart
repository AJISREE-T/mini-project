import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:trashcan/common/colors.dart';
import 'package:trashcan/user/quote_edit.dart';
class ViewQuote extends StatefulWidget {
  var uid;
  var fullname;
  var address;
  var place;
  var pincode;
  var phone_no;
  var agentname;
  var username;
  var wastetype;
  var wasteprice;
  var colldate;
  ViewQuote({Key? key,this.uid,this.fullname,this.address,this.place,this.pincode
    ,this.phone_no,this.agentname,this.username,this.wastetype,this.wasteprice,this.colldate}) : super(key: key);

  @override
  _ViewQuoteState createState() => _ViewQuoteState();
}

class _ViewQuoteState extends State<ViewQuote> {
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
                               //  Navigator.push(context,
                               //      MaterialPageRoute(builder:(context)=>QuoteEdit(
                               //        wasteprice: widget.wasteprice,
                               // colldate: widget.colldate,
                               //      ))
                               //  );



                              },
                              child: Column(
                                children: [
                                  ListTile(
                                    title: Text('Agent: '+snapshot.data?.docs[index]['agentname']+' \nType: '+snapshot.data?.docs[index]['wastetype'],
                                      style: TextStyle(fontSize:20,),
                                    ),
                                    subtitle: Text('RS: '+snapshot.data?.docs[index]['price']+'\n'+"Date: "+snapshot.data?.docs[index]['collectiondate']) ,
                                    trailing: snapshot.data!.docs[index]['useracceptstatus']==0?Container(
                                        width: 80,
                                        height: 40,
                                        child: ElevatedButton(
                                          onPressed: () {
                                            showalertdialog(context,snapshot.data?.docs[index]['qid'],snapshot.data?.docs[index]['collectiondate']);

                                          },
                                          child: Text(
                                            "Accept",
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
  showalertdialog(BuildContext context,var qid,var date,)
  {


    TextEditingController category=TextEditingController();


    setState(() {
      category.text=date;

    });



    return showDialog(context: context,
        builder: (context){
          return AlertDialog(
            title: Text("Alert"),
            content:  Container(
          height: 150,
              width: double.infinity,

              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,

                children: [
Text("Edit Pick up Date "),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: "Select Pickup Date"
                    ),

                    controller: category,

                  ),

                ],
              ),

            ),
            actions: [
              ElevatedButton(onPressed: (){
                FirebaseFirestore.instance.collection('Quote').doc(qid).update(
                    {
                      'useracceptstatus':1,
                      'collectiondate':category.text,
                    }).then((value) {


                  FirebaseFirestore.instance.collection('Ewaste').doc(qid).update({
                    'agentacceptstatus':1,
                    'useracceptstatus':1

                  });
                }).then((value)

                {
                  showsnackbar("Quote Accepted");
                  Navigator.pop(context);

                });
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
  showsnackbar(String msg)
  {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(msg),
          backgroundColor: Colors.black12,

        )
    );
  }
}
