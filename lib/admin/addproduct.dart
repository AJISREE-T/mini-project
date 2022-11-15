import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:trashcan/common/colors.dart';
import 'package:trashcan/validate/validate.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({Key? key}) : super(key: key);

  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  var _registerkey = new GlobalKey<FormState>();
  TextEditingController ptypeInputcontroller = new TextEditingController();
  TextEditingController descriptnInputcontroller = new TextEditingController();
  TextEditingController pnameInputcontroller = new TextEditingController();
  TextEditingController priceInputcontroller = new TextEditingController();
  var uuid = Uuid();
  var product_id;
  var filename;
  XFile? image;
  var url;
  final ImagePicker _picker=ImagePicker();
  initState() {
    product_id=uuid.v1();
    filename=uuid.v4();
    super.initState();
    // Add listeners to this class


  }
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
        child: Form(
          key: _registerkey,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    TextFormField(
                      controller: ptypeInputcontroller,
                      //controller: passwordInputcontroller,
                      //keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: "Product Type", //label
                        //hintText: "abc@gmail.com",//hint for how to type
                        border: OutlineInputBorder(
                          borderRadius:
                          BorderRadius.circular(20), //for rounded border
                        ),
                        //prefixIcon: Icon(Icons.email,color: Colors.blue,),
                      ),
                      validator: (value) {
                        return validate.txtvalidator(value!);
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: pnameInputcontroller,
                      //controller: passwordInputcontroller,
                      //keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: "Product Name", //label
                        //hintText: "abc@gmail.com",//hint for how to type
                        border: OutlineInputBorder(
                          borderRadius:
                          BorderRadius.circular(20), //for rounded border
                        ),
                        //prefixIcon: Icon(Icons.email,color: Colors.blue,),
                      ),
                      validator: (value) {
                        return validate.txtvalidator(value!);
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: descriptnInputcontroller,
                      maxLines: 4,
                      //controller: passwordInputcontroller,
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                        labelText: "Description", //label

                        //hintText: "abc@gmail.com",//hint for how to type
                        border: OutlineInputBorder(
                          borderRadius:
                          BorderRadius.circular(20), //for rounded border
                        ),
                        //prefixIcon: Icon(Icons.email,color: Colors.blue,),
                      ),
                      validator: (value) {
                        return validate.txtvalidator(value!);
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller:  priceInputcontroller,
                      //controller: passwordInputcontroller,
                      //keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: "Price", //label
                        //hintText: "abc@gmail.com",//hint for how to type
                        border: OutlineInputBorder(
                          borderRadius:
                          BorderRadius.circular(20), //for rounded border
                        ),
                        //prefixIcon: Icon(Icons.email,color: Colors.blue,),
                      ),
                      validator: (value) {
                        return validate.txtvalidator(value!);
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap:(){
                        showimagepicker();

                      },
                      child: Container(
                          height:200,
                          width:200,
                          color: Colors.blueAccent,
                          child:image!=null? Image.file(File(image!.path)):
                          Container(
                            color:  Colors.white12,
                            child: Icon(Icons.camera_alt,size:100,color:Colors.grey,),
                          )

                      ),
                    ),
                    SizedBox(
                      height: 35,
                    ),
                    Container(
                        width: 150,
                        height: 55,
                        child: ElevatedButton(
                          onPressed: () {
                            //important
                            if (_registerkey.currentState!.validate()) {
                              var ref=FirebaseStorage.instance.ref().child('products/$filename');
                              UploadTask utask=ref.putFile(File(image!.path));
                              utask.then((res)async{
                                url=(await ref.getDownloadURL()).toString();
                              }).then((value){
                                FirebaseFirestore.instance.collection('Eproduct').doc(product_id).set({
                                  'pid': product_id,
                                  'ptype': ptypeInputcontroller.text,
                                  'pname': pnameInputcontroller.text,
                                  'descrptn': descriptnInputcontroller.text,
                                  'price': priceInputcontroller.text,
                                  'imageurl': url,
                                  'status': 1,
                                  'date': DateTime.now()


                                }).then((value){
                                  showsnackbar("Successfully Added!");
                                  Navigator.pop(context);
                                });// common code for data saving,updating

                              } );

                            }
                            // Navigator.pop(context);
                          },
                          child: Text(
                            "Done",
                            style: TextStyle(
                              fontSize: 22,
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
                        )),
                    SizedBox(
                      width: 18,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),

      ),
    );
  }
  imageFromgallery()async{
    final XFile? _image = await _picker.pickImage(source: ImageSource.gallery);
    setState((){
      image=_image;
    }

    );

  }
  imageFromcamera()async{
    final XFile? _image = await _picker.pickImage(source: ImageSource.camera);
    setState((){
      image=_image;
    }

    );

  }
  showimagepicker(){
    showModalBottomSheet(context: context,
        builder: (context){
          return Wrap(
            children: [
              ListTile(
                title: Text("Camera"),
                onTap: (){
                  imageFromcamera();
                },

              ),
              ListTile(
                title: Text("Gallery"),
                onTap: (){
                  imageFromgallery();
                },

              ),
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
