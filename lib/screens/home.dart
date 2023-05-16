import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:maily/screens/sqflitetest.dart';

import 'login.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final ref = FirebaseDatabase.instance.ref('mails');
  final _textcontroller = TextEditingController();
  String data = "New mails";
  String data1 = " New mail";
  bool saved = false;
  bool read = false;
  int _selectedIndex = 0;
  List<Mail> _mails = [];
  String? date;
  String? heure;
  String? selectedJ="01";
    String? selected="2019";
     String? selectedM="01";
     String? selectedJ2="01";
       String? selected2="2023";
     String? selectedM2="01";
  @override
  void initState() {
   
    super.initState();
    selected="2019";
    selectedM="01";
    selected2="2023";
    selectedM2="01";
    selectedJ2="01";
    selectedJ="01";
     BDDLocale.init().then((_) {
      BDDLocale.getMails().then((mails) {
        setState(() {
          _mails = mails;
        });
      });
    }); 
  }

  @override
  Widget build(BuildContext context) {
List<String> listItems=["2019","2020","2022","2023"];
List<String> listItemsM=["01","02","03","04","05","06","07","08","09","10","11","12"];
List<String> listItemsJ=["01","02","03","04","05","06","07","08","09","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31"];


    switch (_selectedIndex) {
      case 0:
                return Container(
          margin: EdgeInsets.only(left: 17.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 20,
              ),
              Container(
                
                width: 350,
                height: 55,
                margin: EdgeInsets.only(right: 15),

                child: Row(children: [
                  Container(
                      margin: EdgeInsets.only(
                        left: 15.0,
                      ),
                      child: Text(
                        data,
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
                      )),
                  SizedBox(
                    width: 180,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10),
                    child: PopupMenuButton(
                      padding: EdgeInsets.only(right: 20),
                      icon: Container(
                          margin: EdgeInsets.only(right: 20),
                          child: Icon(Icons.menu,
                              color: Color.fromARGB(255, 0, 0, 0), size: 35.0)),
                      color: Color(0xffB4B4B4),
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          onTap: (){
                            setState(() {
                              _selectedIndex=2;
                            });
                          },
                          child: item(
                            icon: Icons.search,
                            txt: "search For mail",
                          ),
                        ),
                        PopupMenuItem(
                          onTap: (){
                            setState(() {
                              read = true;
                            });
                          },
                          child: item(
                            icon: Icons.mark_email_read,
                            txt: "Make mails as read",
                          ),
                        ),
                        PopupMenuItem(
                          child: item(
                            icon: Icons.cleaning_services_sharp,
                            txt: "Clear all mails",
                          ),
                        ),
                      ],
                    ),
                  )
                ]),

                decoration: BoxDecoration(
                  color: Color(0xffB4B4B4),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              StreamBuilder(
                  stream: ref.onValue,
                  builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
                    if (snapshot.hasData) {
                      Map<dynamic, dynamic> map =
                          snapshot.data!.snapshot.value as dynamic;
                      List<dynamic> list = [];
                      list.clear();
                      list = map.values.toList();

                      return ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: snapshot.data!.snapshot.children.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              setState(() {
                                read = true;
                                _selectedIndex = 1;
                                date = list[index]['Date'];
                                heure = list[index]['Time'];
                              });
                            },
                            child: Container(
                              margin: EdgeInsets.only(
                                  left: 0, right: 20, bottom: 10),
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          child: Row(
                                            children: [
                                              Container(
                                                margin: EdgeInsets.only(
                                                    top: 12, left: 16),
                                                child: Icon(Icons.circle,
                                                    color:read ? Color.fromARGB(255, 255, 255, 255) : Color(0xFFE26127),
                                                    size: 20),
                                              ),
                                              Container(
                                                margin: EdgeInsets.only(
                                                    top: 12, left: 5),
                                                child: read ?Text(
                                                  "Mail",
                                                  style: TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 0, 0, 0),
                                                      fontSize: 17),
                                                ) :Text(
                                                  data1,
                                                  style: TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 0, 0, 0),
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
                                          margin: EdgeInsets.only(
                                              top: 12, left: 40),
                                          child: Text(
                                            list[index]['Date'],
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 0, 0, 0),
                                                fontSize: 17),
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(
                                              right: 170, left: 40),
                                          child: Text(
                                            list[index]['Time'],
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 0, 0, 0),
                                                fontSize: 17),
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    InkWell(
                                        onTap: () {
                                          setState(() {
                                            saved = !saved;
                                          });
                                        },
                                        child: Container(
                                            width: 28,
                                            child: saved
                                                ? Image.asset("assets/save.png")
                                                : Image.asset(
                                                    "assets/nosave.png"))),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    } else {
                      //Doit retourner un widget
                      return Center(
                        child: CircularProgressIndicator(
                          color: Color(0xffe26127),
                        ),
                      );
                    }
                  })
            ],
          ),
        );
        
      case 1:
        return Column(children: [
          SizedBox(height: 60,),
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
                                _selectedIndex = 0;
                              });
                            },
                          )),
                      Container(
                        margin: EdgeInsets.only(top: 30.0),
                        child: Container(
                            child: Image.asset("assets/mail_details.png")),
                      )
                    ],
                  ),
                  Container(
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 12, left: 16),
                          child:
                              Icon(Icons.circle, color: Colors.white, size: 20),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 20),
                          child: Text(
                            "\nHello,",
                            style: TextStyle(
                                color: Color.fromARGB(255, 0, 0, 0),
                                fontSize: 20),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 0, left: 40),
                    child: Text(
                      "\n\n     You’ve recived a new mail in Your mail box. \nTime: at " +
                          heure! +
                          " \n           on " +
                          date!,
                      overflow: TextOverflow.visible,
                      style: TextStyle(
                          height: 1.5,
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontSize: 17),
                    ),
                  ),
                ],
              ),
            ),
          )
        ]);
      
      case 2:{
         return Container(
          margin: EdgeInsets.only(left: 17.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              
              SizedBox(
                height: 20,
              ),
              Container(
                
                width: 350,
                height: 55,
                margin: EdgeInsets.only(right: 15),

                child: Row(children: [
                  Container(
                  
                  child: IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios_outlined,
                      size: 25,
                    ),
                    onPressed: () {
                      setState(() {
                         _selectedIndex= 0;
                      });
                    },
                  )),

                  Container(
                      margin: EdgeInsets.only(
                        left: 2.0,
                      ),
                      child: Text(
                        "Search For mail",
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
                      )),
                  SizedBox(
                    width: 110,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10),
                    child: PopupMenuButton(
                      padding: EdgeInsets.only(right: 20),
                      icon: Container(
                          margin: EdgeInsets.only(right: 20),
                          child: Icon(Icons.menu,
                              color: Color.fromARGB(255, 0, 0, 0), size: 35.0)),
                      color: Color(0xffB4B4B4),
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          onTap: (){
                            setState(() {
                              _selectedIndex=2;
                            });
                          },
                          child: item(
                            icon: Icons.search,
                            txt: "search For mail",
                          ),
                        ),
                        PopupMenuItem(
                          onTap: (){
                            setState(() {
                              read = true;
                            });
                          },
                          child: item(
                            icon: Icons.mark_email_read,
                            txt: "Make mails as read",
                          ),
                        ),
                        PopupMenuItem(
                          child: item(
                            icon: Icons.cleaning_services_sharp,
                            txt: "Clear all mails",
                          ),
                        ),
                      ],
                    ),
                  )
                ]),

                decoration: BoxDecoration(
                  color: Color(0xffB4B4B4),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Text("From : ",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 24),),

                   Container(
                    padding: EdgeInsets.only(left:5 ,right: 5),
                    height: 40,
                    width: 60,
                     decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                    margin: EdgeInsets.only(left:5),
                    child: DropdownButton<String>(
                      value:selectedJ ,
                     dropdownColor:Colors.white,
                     focusColor:Colors.white,
                      items:listItemsJ
                      .map((item)=>DropdownMenuItem(
                        
                        value: item,
                        child: Text(item))
                        ).toList() ,

                       onChanged:((item)=>setState(() =>selectedJ=item)),
                      ),
                  ),

                  Container(
                    padding: EdgeInsets.only(left:5 ,right: 5),
                    height: 40,
                    width: 120,
                     decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                    margin: EdgeInsets.only(left:5),
                    child: DropdownButton<String>(
                      value:selectedM ,
                     dropdownColor:Colors.white,
                     focusColor:Colors.white,
                      items:listItemsM
                      .map((item1)=>DropdownMenuItem(
                        
                        value: item1,
                        child: Text(item1))
                        ).toList() ,

                       onChanged:((item1)=>setState(() =>selectedM=item1)),
                      ),
                  ),

                  Container(
                    padding: EdgeInsets.only(left:5 ,right: 5),
                    height: 40,
                    width: 80,
                     decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                    margin: EdgeInsets.only(left:5),
                    child: DropdownButton<String>(
                      value:selected ,
                     dropdownColor:Colors.white,
                     focusColor:Colors.white,
                      items:listItems
                      .map((item)=>DropdownMenuItem(
                        
                        value: item,
                        child: Text(item))
                        ).toList() ,

                       onChanged:((item)=>setState(() =>selected=item)),
                      ),
                  ),
                  
                  

                ],
              ),
              SizedBox(height: 10,),
              Row(
                children: [
                 Text("To : ",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 24),),
                 SizedBox(width: 26,),
                  Container(
                    padding: EdgeInsets.only(left:5 ,right: 5),
                    height: 40,
                    width: 60,
                     decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                    margin: EdgeInsets.only(left:5),
                    child: DropdownButton<String>(
                      value:selectedJ2 ,
                     dropdownColor:Colors.white,
                     focusColor:Colors.white,
                      items:listItemsJ
                      .map((item1)=>DropdownMenuItem(
                        
                        value: item1,
                        child: Text(item1))
                        ).toList() ,

                       onChanged:((item1)=>setState(() =>selectedJ2=item1)),
                      ),
                  ),

                  Container(
                    padding: EdgeInsets.only(left:5 ,right: 5),
                    height: 40,
                    width: 120,
                     decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                    margin: EdgeInsets.only(left:5),
                    child: DropdownButton<String>(
                      value:selectedM2 ,
                     dropdownColor:Colors.white,
                     focusColor:Colors.white,
                      items:listItemsM
                      .map((item1)=>DropdownMenuItem(
                        
                        value: item1,
                        child: Text(item1))
                        ).toList() ,

                       onChanged:((item1)=>setState(() =>selectedM2=item1)),
                      ),
                  ),

                  Container(
                    padding: EdgeInsets.only(left:5 ,right: 5),
                    height: 40,
                    width: 80,
                     decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                    margin: EdgeInsets.only(left:5),
                    child: DropdownButton<String>(
                      value:selected2 ,
                     dropdownColor:Colors.white,
                     focusColor:Colors.white,
                      items:listItems
                      .map((item)=>DropdownMenuItem(
                        
                        value: item,
                        child: Text(item))
                        ).toList() ,

                       onChanged:((item)=>setState(() =>selected2=item)),
                      ),
                  ),
                ],
              ),
              SizedBox(
                height:10 ,
              ),
              Container(
                width: 300,
                child: Divider(
              thickness: 1,
              color:  Colors.black,
                ),
              ),
              SizedBox(
                height:10 ,
              ),

              SingleChildScrollView(
                
            
                child: StreamBuilder(
                    stream: (FirebaseDatabase.instance.ref('mails').orderByChild('Date2').startAt('$selected/$selectedM/$selectedJ').endAt('$selected2/$selectedM2/$selectedJ2')).onValue,
                    builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
                      if (snapshot.hasData  )  {
                        
                        if(snapshot.data!.snapshot.value != null){
                         Map<dynamic, dynamic>? map = snapshot.data!.snapshot.value as dynamic;
                          List<dynamic> list = [];
                          list.clear();
                          list = map!.values.toList();
                    

                        
              
                        return ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: snapshot.data!.snapshot.children.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                setState(() {
                                  _selectedIndex = 1;
                                  date = list[index]['Date'];
                                  heure = list[index]['Time'];
                                });
                              },
                              child: Container(
                                margin: EdgeInsets.only(
                                    left: 0, right: 20, bottom: 10),
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            child: Row(
                                              children: [
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      top: 12, left: 16),
                                                  child: Icon(Icons.circle,
                                                      color: Color.fromARGB(255, 255, 255, 255),
                                                      size: 20),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      top: 12, left: 5),
                                                  child: Text(
                                                    "Mail",
                                                    style: TextStyle(
                                                        color: Color.fromARGB(
                                                            255, 0, 0, 0),
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
                                            margin: EdgeInsets.only(
                                                top: 12, left: 40),
                                            child: Text(
                                              list[index]['Date'],
                                              style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 0, 0, 0),
                                                  fontSize: 17),
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(
                                                right: 170, left: 40),
                                            child: Text(
                                              list[index]['Time'],
                                              style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 0, 0, 0),
                                                  fontSize: 17),
                                            ),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                        }else{
                           return ListTile(
                        title: Text('  no data is available within this date range'),
                      );
                        }
                      } else {
                        //Doit retourner un widget
                        return Center(
                          child: CircularProgressIndicator(
                            color: Color(0xffe26127),
                          ),
                        );
                      }
                    }),
              )




            ],
          ),


        );
      }
      default:
        return Container();
    }
  }
}

class EssaiRealTime extends StatefulWidget {
  const EssaiRealTime({super.key});

  @override
  State<EssaiRealTime> createState() => _EssaiRealTimeState();
}

class _EssaiRealTimeState extends State<EssaiRealTime> {
  final ref = FirebaseDatabase.instance.ref('mails');
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('aa'),
        ),
        body: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                  stream: ref.onValue,
                  builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
                    if (snapshot.hasData) {
                      Map<dynamic, dynamic> map =
                          snapshot.data!.snapshot.value as dynamic;
                      List<dynamic> list = [];
                      list.clear();
                      list = map.values.toList();

                      return ListView.builder(
                          itemCount: snapshot.data!.snapshot.children.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(list[index]['Date']),
                              subtitle: Text(list[index]['Time']),
                            );
                          });
                    } else {
                      //Doit retourner un widget
                      return ListTile(
                        title: Text('rien'),
                      );
                    }
                  }),
            ),
            /* Expanded(child: FirebaseAnimatedList(

        query: ref, 
        itemBuilder: ( (context, snapshot, animation, index)  {
        return  ListTile (
        title: Text(snapshot.child('Date').value.toString()),
        subtitle: Text(snapshot.child('Time').value.toString()),
        );

        }
        )
      )
      )*/
          ],
        ),
      );
}

class PopupMenu extends StatelessWidget {
  final List<PopupMenuEntry> menuList;
  final Widget icon;

  const PopupMenu({Key? key, required this.menuList, required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      padding: EdgeInsets.only(right: 20),
      itemBuilder: (context) => menuList,
      icon: icon,
      color: Color(0xffB4B4B4),
    );
  }
}

class item extends StatelessWidget {
  final IconData icon;
  final String txt;

  const item({Key? key, required this.icon, required this.txt})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          SizedBox(
            width: 10,
          ),
          Icon(
            icon,
          ),
          SizedBox(
            width: 10,
          ),
          Text(txt),
        ],
      ),
      margin: EdgeInsets.only(top: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      height: 50,
      width: 200,
    );
  }
}
