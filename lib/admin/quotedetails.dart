import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:trashcan/collectingagent/quote.dart';
import 'package:trashcan/common/colors.dart';
class QuoteDetl extends StatefulWidget {
  var agentname;
  var username;
  var wastetype;
  var wasteprice;
  var colldate;
  QuoteDetl({Key? key,this.agentname,this.username,this.wastetype,this.wasteprice,this.colldate}) : super(key: key);

  @override
  _QuoteDetlState createState() => _QuoteDetlState();
}

class _QuoteDetlState extends State<QuoteDetl> {
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
            Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: GestureDetector(
                          onTap: () {


                          },
                          child: Container(
                            height: 350,
                            child: Card(
                              elevation: 3,
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(

                                          child: Text('Agent Name: ',
                                            style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),


                                          ),
                                        ),
                                        Expanded(

                                          child: Text(widget.agentname,
                                            style:  TextStyle(fontSize: 18) ,


                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height:10,),
                                    Row(
                                      children: [
                                        Expanded(

                                          child: Text('User Name: ',
                                            style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),


                                          ),
                                        ),
                                        Expanded(

                                          child: Text(widget.username,
                                            style:  TextStyle(fontSize: 18) ,


                                          ),
                                        ),
                                      ],
                                    ),

                                    SizedBox(height:10,),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text('Category: ',
                                            style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),


                                          ),
                                        ),
                                        Expanded(
                                          child: Text(widget.wastetype,
                                            style: TextStyle(fontSize: 18,),),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height:10,),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text('Price: ',
                                            style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),


                                          ),
                                        ),
                                        Expanded(
                                          child: Text(widget.wasteprice,
                                            style: TextStyle(fontSize: 18,),),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height:10,),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text('Date: ',
                                            style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),


                                          ),
                                        ),
                                        Expanded(
                                          child: Text(widget.colldate,
                                            style: TextStyle(fontSize: 18,),),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height:25,),
                                  ],
                                ),
                              ),
                            ),
                          ),

                        ),

                      ),



          ],


        ),

      ),
    );
  }
}
