import 'dart:ffi' hide Size;
import 'dart:io';
import 'dart:ui';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:maily/screens/login.dart';
import 'package:maily/screens/utils.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String data1 = "Mail";
  String? data;
  final _emailController = TextEditingController();
  firebase_storage.FirebaseStorage storage =firebase_storage.FirebaseStorage.instance;
  String imageURL="";

  final _phoneController = TextEditingController();
  final _usernameController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  /*UPDATE PROFILE PICTURE*/
  final picker = ImagePicker();
  XFile? _image;
  XFile? get image => _image ;



  /// ******
   final ref = FirebaseDatabase.instance.ref('Users');
   final ref2 = FirebaseDatabase.instance.ref('Users');
    final user= FirebaseAuth.instance.currentUser!;

     

  int _selctedIndex = 0;
  @override
  Widget build(BuildContext context) {

  /* ref2.child(user.uid.toString()).get().then((snap) {
                   Map<dynamic, dynamic> map2 = snap.value as dynamic;
                    List<dynamic> list2 = [];
                  list2.clear();
                  list2 = map2.values.toList();
                  print(Text(list2[3]['Time']));
                  } 
                  );*/
    switch (_selctedIndex) {
      case 0:
        return StreamBuilder(

        stream: ref.child(user.uid.toString()).onValue,
        builder: (context,AsyncSnapshot snapshot){
        if(snapshot.hasData){
      if(snapshot.data!.snapshot.value != null){       
   Map<dynamic,dynamic> map = snapshot.data.snapshot.value;
        return Container(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Color.fromARGB(255, 233, 233, 233), 
          ),
          width: double.maxFinite,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 100,
                  width: 100,
                  margin: EdgeInsets.only(top: 20),
                  child: CircleAvatar(
                      backgroundColor: Color.fromARGB(255, 233, 233, 233),
                     // child: Image.asset(
                         child: ClipRRect(
                       
                    borderRadius: BorderRadius.circular(20),
                        child:(image==null && map['profilPicture'].toString() == "") ? const Icon(Icons.person,size:35,) :
                        Image(
                          fit: BoxFit.cover,

                          image: NetworkImage(map['profilPicture'].toString()),
                          loadingBuilder: (context, child, loadingProgress) {
                            if(loadingProgress==null) return child;
                            return Center(child: CircularProgressIndicator());
                          },
                          errorBuilder: (context, error, stack) {
                            return Container(
                              child: Icon(Icons.error_outline,color: Colors.redAccent,),
                            );
                          },
                          
                          ) 
                                              
                       
                      ),
                      ),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [ 

                      /*  */    
                      
                      ListTile(
                        leading: Image.asset("assets/Telicon.png"),
                        title: Text('+213 '+map['phone']),
                        trailing: InkWell(
                            onTap: () {
                              setState(() {
                                _selctedIndex = 1;
                              });
                            },
                            child: Image.asset("assets/modifyicon.png")),
                      ),
                      //),
                      Container(
                        width: 200,
                        child: Divider(
                          thickness: 0.7,
                          color: Colors.black,
                        ),
                      ),
                      ListTile(
                        leading: Image.asset("assets/mailicon.png"),
                        title: Text(map['email']),
                        trailing: InkWell(
                            onTap: () {
                              setState(() {
                                _selctedIndex = 2;
                              });
                            },
                            child: Image.asset("assets/modifyicon.png")),
                      ),
                      Container(
                        width: 200,
                        child: Divider(
                          thickness: 0.7,
                          color: Colors.black,
                        ),
                      ),
                      ListTile(
                        leading: Image.asset("assets/photoicon.png"),
                        title: Text("Edit picture"),
                        trailing: InkWell(
                            onTap: () {
                              setState(() {
                                _selctedIndex = 3;
                              });
                            },
                            child: Image.asset("assets/modifyicon.png")),
                      ),
                      Container(
                        width: 200,
                        child: Divider(
                          thickness: 0.7,
                          color: Colors.black,
                        ),
                      ),
                      ListTile(
                        leading: Image.asset("assets/@icon.png"),
                        title: Text("Set username"),
                        trailing: InkWell(
                            onTap: () {
                              setState(() {
                                _selctedIndex = 4;
                              });
                            },
                            child: Image.asset("assets/modifyicon.png")),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            _selctedIndex = 5;
                          });
                        },
                        child: ListTile(
                          leading: Image.asset("assets/savedicon.png"),
                          title: Text("Saved Mails"),
                        ),
                      ),
                      Container(
                        width: 200,
                        child: Divider(
                          thickness: 0.7,
                          color: Colors.black,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            _selctedIndex = 6;
                          });
                        },
                        child: ListTile(
                          leading: Image.asset(
                            "assets/premium.png",
                          ),
                          title: Text("Maily Premium"),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 20.0),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        fixedSize: const Size(150, 50),
                        elevation: 24,
                        shadowColor: Colors.red,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                            side:
                                const BorderSide(color: Colors.red, width: 2)),
                      ),
                      onPressed: () {
                        Get.to(() => const Login(),
                            transition: Transition.noTransition,
                            duration: const Duration(seconds: 1));
                        FirebaseAuth.instance.signOut();
                      },
                      child: const Text('Log out')),
                ),
              ],
            ),
          ),
        );
        }else {
          return Center(child: CircularProgressIndicator());
        }
        
        }else {
          return Center(child: CircularProgressIndicator());
        }
        }
        );
      case 1:
        return Column(
          children: [
          Row(
            children: [
              Container(
                  margin: EdgeInsets.only(top: 20.0, left: 20),
                  child: IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios_outlined,
                      size: 25,
                    ),
                    onPressed: () {
                      setState(() {
                        _selctedIndex = 0;
                      });
                    },
                  )),
              Container(
                  margin: EdgeInsets.only(top: 20.0, left: 10),
                  child: const Text("Phone number",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)))
            ],
          ),
          Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: IntlPhoneField(
                  initialCountryCode: AutofillHints.countryCode,
                  controller:_phoneController ,
                  cursorColor: const Color.fromARGB(255, 226, 98, 39),
                  decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      borderSide: BorderSide(width: 1, color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      borderSide: BorderSide(width: 1, color: Colors.white),
                    ),
                    hintText: 'Phone number...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      borderSide: BorderSide(width: 1, color: Colors.white),
                    ),
                  ),
                ),
              )),
          SizedBox(
            height: 40,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFFE26127),
              fixedSize: const Size(165, 40),
              elevation: 24,
              shadowColor: Colors.grey,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                  side: const BorderSide(color: Color(0xFFE26127))),
            ),
            onPressed: () {
             //modifier num
              ref.child(user.uid.toString()).update(
              {
                'phone':_phoneController.text.trim(),
              }
           ).then((value) {
             _phoneController.clear();
           });

              setState(() {
                _selctedIndex = 0;
              });
            },
            child: const Text(
              'Save',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ]);
      case 2:
        
        return Form (
         key: formKey,
          child:Column(


          children: [
          Row(

            children: [
              Container(
                  margin: EdgeInsets.only(top: 20.0, left: 20),
                  child: IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios_outlined,
                      size: 25,
                    ),
                    onPressed: () {
                      setState(() {
                        _selctedIndex = 0;
                      });
                    },
                  )),
              Container(
                  margin: EdgeInsets.only(top: 20.0, left: 10),
                  child: const Text("Mail address",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)))
            ],
          ),
          Container(

            

            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: TextFormField(
              controller: _emailController,
              cursorColor: const Color.fromARGB(255, 226, 98, 39),
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
              decoration: const InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  borderSide: BorderSide(width: 1, color: Colors.white),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  borderSide: BorderSide(width: 1, color: Colors.white),
                ),
                hintText: 'Mail address',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  borderSide: BorderSide(width: 1, color: Colors.white),
                ),
              ),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (email) =>
                  email != null && !EmailValidator.validate(email)
                      ? 'Enter a valid email'
                      : null,
            ),
          ),
          SizedBox(
            height: 40,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFFE26127),
              fixedSize: const Size(165, 40),
              elevation: 24,
              shadowColor: Colors.grey,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                  side: const BorderSide(color: Color(0xFFE26127))),
            ),
            onPressed: () {
              setState(() {
                //save email
              savEmail();
              
                _selctedIndex = 0;

              });
            },
            child: const Text(
              'Save',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ]),
        );
      case 3:
        return Container(
          color: Color.fromARGB(255, 233, 233, 233),
          width: double.maxFinite,
          height: double.maxFinite,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Container(
                        margin: EdgeInsets.only(top: 20.0, left: 20),
                        child: IconButton(
                          icon: Icon(
                            Icons.arrow_back_ios_outlined,
                            size: 25,
                          ),
                          onPressed: () {
                            setState(() {
                              _selctedIndex = 0;
                            });
                          },
                        )),
                    Container(
                        margin: EdgeInsets.only(top: 20.0, left: 10),
                        child: const Text("Picture",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)))
                  ],
                ),
               /* Container(
                  height: 100,
                  width: 100,
                  margin: EdgeInsets.only(top: 40),
                ),*/

                SizedBox(
                  height: 20,
                ),
                Container(
                  margin: EdgeInsets.only(top: 80),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      fixedSize: const Size(300, 60),
                      elevation: 24,
                      shadowColor: Colors.grey,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                          side: const BorderSide(color: Colors.white)),
                    ),
                    onPressed: () {
                        pickGalleryImage(context);
                    },
                    child: Row(
                      children: [
                        Icon(Icons.image,
                            color: Color.fromARGB(255, 0, 0, 0), size: 35.0),
                        SizedBox(
                          width: 10,
                        ),
                        const Text(
                          'Choose from library',
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      fixedSize: const Size(300, 60),
                      elevation: 24,
                      shadowColor: Colors.grey,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                          side: const BorderSide(color: Colors.white)),
                    ),
                    onPressed: () {
                      pickCameraImage(context);

                    },
                    child: Row(
                      children: [
                        Icon(Icons.camera_alt, color: Colors.black, size: 35.0),
                        SizedBox(
                          width: 10,
                        ),
                        const Text(
                          'Take a photo',
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      fixedSize: const Size(300, 60),
                      elevation: 24,
                      shadowColor: Colors.grey,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                          side: const BorderSide(color: Colors.white)),
                    ),
                    onPressed: () {
                        ref.child(user.uid.toString()).update({
                          'profilPicture':""
                        }).then((value){
                          Utils.showSnackBargray('Profile picture removed');
                          _image=null;
                        }).onError((error, stackTrace){
                          Utils.showSnackBar(error.toString());
                        });
                    },
                    child: Row(
                      children: [
                        Icon(Icons.delete, color: Colors.red, size: 35.0),
                        SizedBox(
                          width: 10,
                        ),
                        const Text(
                          'Remove current picture',
                          style: TextStyle(color: Colors.red),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFE26127),
                    fixedSize: const Size(165, 40),
                    elevation: 24,
                    shadowColor: Colors.grey,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                        side: const BorderSide(color: Color(0xFFE26127))),
                  ),
                  onPressed: () {
                    setState(() {
                      //save picture
                      _selctedIndex = 0;
                    });
                  },
                  child: const Text(
                    'Edit picture',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        );
      case 4:
        return Column(children: [
          Row(
            children: [
              Container(
                  margin: EdgeInsets.only(top: 20.0, left: 20),
                  child: IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios_outlined,
                      size: 25,
                    ),
                    onPressed: () {
                      setState(() {
                        _selctedIndex = 0;
                      });
                    },
                  )),
              Container(
                  margin: EdgeInsets.only(top: 20.0, left: 10),
                  child: const Text("Username",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)))
            ],
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
            child: Container(
              child: TextFormField(
                controller: _usernameController,
                cursorColor: const Color.fromARGB(255, 226, 98, 39),
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                decoration: const InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    borderSide: BorderSide(width: 1, color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    borderSide: BorderSide(width: 1, color: Colors.white),
                  ),
                  hintText: 'Username',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    borderSide: BorderSide(width: 1, color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 40,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Color.fromARGB(255, 226, 98, 39),
              fixedSize: const Size(165, 40),
              elevation: 24,
              shadowColor: Colors.grey,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                  side: const BorderSide(
                      color: Color.fromARGB(255, 226, 98, 39))),
            ),
            onPressed: () {
              //modifier username
              ref.child(user.uid.toString()).update(
              {
                'userName':_usernameController.text.trim(),
              }
              ).then((value) {
                _usernameController.clear();
              });              
           setState(() {
                _selctedIndex = 0;
              });
            },
            child: const Text(
              'Save',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ]);
      case 5:
        return Container(
          margin: EdgeInsets.only(left: 20),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Row(
              children: [
                Container(
                    margin: EdgeInsets.only(top: 20.0),
                    child: IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios_outlined,
                        size: 25,
                      ),
                      onPressed: () {
                        setState(() {
                          _selctedIndex = 0;
                        });
                      },
                    )),
                Container(
                    margin: EdgeInsets.only(top: 20.0, left: 10),
                    child: const Text("Saved mails",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)))
              ],
            ),
            SizedBox(
              height: 40,
            ),
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 3,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.only(left: 0, right: 20, bottom: 10),
                  child: Container(
                    margin: EdgeInsets.only(right: 0, left: 0),
                    width: 350,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: Row(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(top: 12, left: 16),
                                    child: Icon(Icons.circle,
                                        color: Colors.white, size: 20),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 12, left: 5),
                                    child: Text(
                                      data1,
                                      style: TextStyle(
                                          color: Color.fromARGB(255, 0, 0, 0),
                                          fontSize: 17),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 12, left: 40),
                              child: Text(
                                //list[index]['Date'],
                                "On: 03/05/2023",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 0, 0, 0),
                                    fontSize: 17),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(right: 170, left: 40),
                              child: Text(
                                //list[index]['Time'],
                                "At: 05:16",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 0, 0, 0),
                                    fontSize: 17),
                              ),
                            )
                          ],
                        ),
                        /**** */

                        Container(
                            width: 28, child: Image.asset("assets/save.png")),
                      ],
                    ),
                  ),
                );
              },
            )
          ]),
        );
      case 6:
        return Column(children: [
          Row(
            children: [
              Container(
                  margin: EdgeInsets.only(top: 20.0, left: 20),
                  child: IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios_outlined,
                      size: 25,
                    ),
                    onPressed: () {
                      setState(() {
                        _selctedIndex = 0;
                      });
                    },
                  )),
              Container(
                margin: EdgeInsets.only(top: 30.0),
                child: Container(child: Image.asset("assets/MailyPremium.png")),
              )
            ],
          ),
          Container(
            margin: EdgeInsets.only(left: 20, right: 20, top: 30),
            child: Container(
              margin: EdgeInsets.only(right: 0, left: 0),
              width: 350,
              height: 400,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 12, left: 16),
                          child:
                              Icon(Icons.circle, color: Colors.white, size: 20),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 12, left: 0),
                          child: Text(
                            "Get your Boxes here",
                            style: TextStyle(
                                color: Color.fromARGB(255, 0, 0, 0),
                                fontSize: 27),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 12, left: 20),
                    child: Text(
                      "       Maily Premium is a version of Maily which the user can get all the mails and boxes here on this application .",
                      overflow: TextOverflow.visible,
                      style: TextStyle(
                          height: 1.5,
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontSize: 17),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 40, left: 40),
                    child: Text(
                      //list[index]['Time'],
                      "Feachers : \n      -\n      -\n      -\n",
                      style: TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0), fontSize: 17),
                    ),
                  ),
                  Container(
                      alignment: Alignment.center,
                      child: Image.asset("assets/boxPremium.png")),
                ],
              ),
            ),
          )
        ]);
      default:
        return Container();
    }
  }

        void savEmail () async{
              final isValid = formKey.currentState!.validate();
               if (!isValid) return;
                try {
                  await user.updateEmail(_emailController.text.trim());
                   ref.child(user.uid.toString()).update(
                   {
                    'email':_emailController.text.trim(),
                   }
                ).then((value) {
                  _phoneController.clear();
                });
                  Utils.showSnackBargray('Email updated!');
                } on FirebaseAuthException catch (e) {
                     Utils.showSnackBar(e.message);
                }            
}

Future pickGalleryImage(BuildContext context) async {
  final pickedFile = await picker.pickImage(source: ImageSource.gallery, imageQuality: 100);
  if(pickedFile != null){
    _image=XFile(pickedFile.path);
        uploadImage(context);

  }
}

Future pickCameraImage(BuildContext context) async {
  final pickedFile = await picker.pickImage(source: ImageSource.camera, imageQuality: 100);
  if(pickedFile != null){
    _image=XFile(pickedFile.path);
    uploadImage(context);
  }
}

void uploadImage (BuildContext context) async {
  firebase_storage.Reference storageRef = firebase_storage.FirebaseStorage.instance.ref('/profileImage'+user.uid.toString());
  firebase_storage.UploadTask uploadTask = storageRef.putFile(File(image!.path));
  await Future.value(uploadTask);
  final newUrl = await storageRef.getDownloadURL();
  ref.child(user.uid.toString()).update({
    'profilPicture':newUrl.toString()
  }).then((value){
    Utils.showSnackBargray('Profile picture updated');
    _image=null;
  }).onError((error, stackTrace){
    Utils.showSnackBar(error.toString());
  });
}

}
