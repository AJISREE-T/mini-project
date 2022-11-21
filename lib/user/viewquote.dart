import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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


  TextEditingController pickupdateController=TextEditingController();

  String?datepickup;
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
                                    trailing: snapshot.data!.docs[index]['useracceptstatus']==0 && snapshot.data!.docs[index]['cstatus']==0?Container(
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
                                        )):snapshot.data!.docs[index]['useracceptstatus']==1 && snapshot.data!.docs[index]['cstatus']==2?Text("Date Change Accepted"):snapshot.data!.docs[index]['useracceptstatus']==1 && snapshot.data!.docs[index]['cstatus']==1?Text("Order Cancelled by Agent"):Text("Waiting"),

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





    setState(() {
      pickupdateController.text=date;
      datepickup=date;


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


                  TextField(
                      controller:pickupdateController, //editing controller of this TextField
                      decoration: const InputDecoration(
                          icon: Icon(Icons.calendar_today), //icon of text field
                  hintText: "Select Pickup Date"
                      ),
                      readOnly: true,  // when true user cannot edit text
                      onTap: () async {
                      _showPicker();
                      }
                  )


                ],
              ),

            ),
            actions: [
              ElevatedButton(onPressed: (){

                if(date==pickupdateController.text){
                  FirebaseFirestore.instance.collection('Quote').doc(qid).update(
                      {
                        'useracceptstatus':1,

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


                }else{


                  FirebaseFirestore.instance.collection('Quote').doc(qid).update(
                      {
                        'useracceptstatus':1,
                        'collectiondate':pickupdateController.text,
                        'datechangestatus':1

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
                }



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

  _showPicker()async{
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(), //get today's date
        firstDate:DateTime(2000), //DateTime.now() - not to allow to choose before today.
        lastDate: DateTime(2101)
    );

    if(pickedDate != null ){
      print(pickedDate);  //get the picked date in the format => 2022-07-04 00:00:00.000
      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate); // format date in required form here we use yyyy-MM-dd that means time is removed
      print(formattedDate); //formatted date output using intl package =>  2022-07-04
      //You can format date as per your need

      setState(() {
        pickupdateController.text = formattedDate; //set foratted date to TextField value.
      });
    }else{
      print("Date is not selected");
    }
  }
}
