import 'package:flutter/material.dart';
import 'package:trashcan/common/colors.dart';
import 'package:trashcan/user/payment.dart';
class ProductDetail extends StatefulWidget {
  var img;
  var pname;
  var price;
  var desc;
  var pid;
  var uid;
  var fullname;
  var address;
  var place;
  var pincode;
  var phone_no;
   ProductDetail({Key? key,this.pid,this.img,this.pname,this.price,this.desc,this.uid,this.fullname,this.address,this.place,this.pincode,this.phone_no}) : super(key: key);

  @override
  _ProductDetailState createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  @override
  Widget build(BuildContext context) {
    final Size size=MediaQuery.of(context).size;
    print(size.height);
    print(size.width);

    return Scaffold(
      backgroundColor: bgcolor,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Products Details",
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
              padding: const EdgeInsets.only(top:20.0,left: 90,right: 100),
              child: Container(
                child: Image.network(widget.img,),
              ),


            ),
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.only(),
              child: Text(widget.pname,style: TextStyle(fontSize:20,),),
            ),
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.only(),
              child: Text(widget.price,style: TextStyle(fontSize:20,),),
            ),
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.only(),
              child: Text(widget.desc,style: TextStyle(fontSize:20,),),
            ),
            SizedBox(height: 20,),
            Center(
              child: Container(
                  width: 200,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PayPage(price: widget.price,uid:widget.uid,fullname:widget.fullname,address:widget.address,pid:widget.pid,pname:widget.pname,desc: widget.desc,pincode:widget.pincode)));
                    },
                    child: Text(
                      "Buy Now",
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.white,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                        primary: Color(0xff1565c0),
                        side: BorderSide(
                          color: Color(0xff64dd17),
                          width: 2,
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12))),
                  )),
            ),

          ],
        ),

      ),
    );
  }
}
