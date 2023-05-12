import 'dart:ffi' hide Size;
import 'dart:ui';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maily/screens/dashboard.dart';

import 'package:maily/screens/login.dart';
import 'package:maily/screens/statistiques.dart';
class homeStat extends StatefulWidget {
  late int slect11;
  homeStat({super.key, required this.slect11});

  @override
  State<homeStat> createState() => _homeStatState();
}

class _homeStatState extends State<homeStat> {
  int _selectedIndex = 1;
  @override
  Widget build(BuildContext context) {
    return getBody(widget.slect11);
  }

  Widget getBody(int slect) {
    switch (slect) {
      case 0:
        {
          return Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Color(0xffB4B4B4),
                  borderRadius: BorderRadius.circular(10),
                ),
                width: 350,
                height: 55,
                margin: EdgeInsets.only(top: 20, left: 15, right: 15),
                child: Row(children: [
                  Container(
                      margin: EdgeInsets.only(
                        left: 15.0,
                      ),
                      child: Text(
                        "Statistics",
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
                      )),
                  SizedBox(
                    width: 200,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10),
                    child: PopupMenu(
                      icon: Container(
                          margin: EdgeInsets.only(right: 20),
                          child: Icon(Icons.menu,
                              color: Color.fromARGB(255, 0, 0, 0), size: 35.0)),
                      menuList: [
                        PopupMenuItem(
                          onTap: () {
                            setState(() {
                          widget.slect11 = 5;
                        });
                          },
                            child: item(
                          txt: "All statistics",
                        )),
                        PopupMenuItem(
                          onTap: (){
                            setState(() {
                          widget.slect11 = 4;
                        });
                          },
                          child: item(
                            txt: "Yearly statistics",
                          ),
                        ),
                        PopupMenuItem(
                           onTap: (){
                            setState(() {
                          widget.slect11 = 3;
                        });
                          },
                          child: item(
                            txt: "Monthly statistics",
                          ),
                        ),
                        PopupMenuItem(
                           onTap: (){
                            setState(() {
                          widget.slect11 = 2;
                        });
                          },
                          child: item(
                            txt: "Weekly statistics",
                          ),
                        ),
                        PopupMenuItem(
                           onTap: (){
                            setState(() {
                          widget.slect11 = 1;
                        });
                          },
                          child: item(
                            txt: "Daily statistics",
                          ),
                        ),
                      ],
                    ),
                  )
                ]),
              ),
              SizedBox(
                height: 60,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xffe26127),
                        fixedSize: const Size(100, 100),
                        elevation: 24,
                        shadowColor: Color(0xffe26127),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                            side: const BorderSide(
                                color: Color(0xffe26127), width: 2)),
                      ),
                      onPressed: () {
                        setState(() {
                          widget.slect11 = 1;
                        });
                      },
                      child: Text(
                        "Daily",
                        style: const TextStyle(fontSize: 18),
                      )),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xffe26127),
                        fixedSize: const Size(100, 100),
                        elevation: 24,
                        shadowColor: Color(0xffe26127),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                            side: const BorderSide(
                                color: Color(0xffe26127), width: 2)),
                      ),
                      onPressed: () {
                        setState(() {
                          widget.slect11 = 2;
                        });
                      },
                      child: Text(
                        "Weekly",
                        style: const TextStyle(fontSize: 18),
                      )),
                ],
              ),
              SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xffe26127),
                        fixedSize: const Size(100, 100),
                        elevation: 24,
                        shadowColor: Color(0xffe26127),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                            side: const BorderSide(
                                color: Color(0xffe26127), width: 2)),
                      ),
                      onPressed: () {
                        setState(() {
                          widget.slect11 = 3;
                        });
                      },
                      child: Text(
                        "Monthly",
                        style: const TextStyle(fontSize: 18),
                      )),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xffe26127),
                        fixedSize: const Size(100, 100),
                        elevation: 24,
                        shadowColor: Color(0xffe26127),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                            side: const BorderSide(
                                color: Color(0xffe26127), width: 2)),
                      ),
                      onPressed: () {
                        setState(() {
                          widget.slect11 = 4;
                        });
                      },
                      child: Text(
                        "Yearly",
                        style: const TextStyle(fontSize: 18),
                      )),
                ],
              ),
              SizedBox(
                height: 60,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    fixedSize: const Size(280, 60),
                    elevation: 24,
                    shadowColor: Colors.grey,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: const BorderSide(color: Colors.white, width: 2)),
                  ),
                  onPressed: () {
                    setState(() {
                      widget.slect11 = 5;
                    });
                  },
                  child: Text(
                    'All statistics',
                    style:
                        const TextStyle(fontSize: 18, color: Color(0xffe26127)),
                  ))
            ],
          );
        }
      case 1:
        {
          return Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Color(0xffB4B4B4),
                  borderRadius: BorderRadius.circular(10),
                ),
                width: 350,
                height: 55,
                margin: EdgeInsets.only(top: 20, left: 15, right: 15),
                child: Row(children: [
                   Container(
                  
                  child: IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios_outlined,
                      size: 25,
                    ),
                    onPressed: () {
                      setState(() {
                         widget.slect11 = 0;
                      });
                    },
                  )),
                  Container(
                     
                      child: Text(
                        "Daily Statistics",
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
                      )),
                  SizedBox(
                    width: 120,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10),
                    child: PopupMenu(
                      icon: Container(
                          margin: EdgeInsets.only(right: 20),
                          child: Icon(Icons.menu,
                              color: Color.fromARGB(255, 0, 0, 0), size: 35.0)),
                      menuList: [
                        PopupMenuItem(
                           onTap: (){
                            setState(() {
                          widget.slect11 = 5;
                        });
                          },

                            child: item(
                          txt: "All statistics",
                        )),
                        PopupMenuItem(
                           onTap: (){
                            setState(() {
                          widget.slect11 = 4;
                          
                        });
                          },
                          child: item(
                            txt: "Yearly statistics",
                          ),
                        ),
                        PopupMenuItem(
                           onTap: (){
                            setState(() {
                          widget.slect11 = 3;
                        });
                          },
                          child: item(
                            txt: "Monthly statistics",
                          ),
                        ),
                        PopupMenuItem(
                           onTap: (){
                            setState(() {
                          widget.slect11 = 2;
                        });
                          },
                          child: item(
                            txt: "Weekly statistics",
                          ),
                        ),
                        PopupMenuItem(
                           onTap: (){
                            setState(() {
                          widget.slect11 = 1;
                        });
                          },
                          child: item(
                            txt: "Daily statistics",
                          ),
                        ),
                      ],
                    ),
                  )
                ]),
              ),
              SizedBox(
               height: 60,
              ),
              Statistiques(
                slc: 1,
              ),
            ],
          );
        }
      case 2:
        {
          return Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Color(0xffB4B4B4),
                  borderRadius: BorderRadius.circular(10),
                ),
                width: 350,
                height: 55,
                margin: EdgeInsets.only(top: 20, left: 15, right: 15),
                child: Row(children: [
                  Container(
                  
                  child: IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios_outlined,
                      size: 25,
                    ),
                    onPressed: () {
                      setState(() {
                         widget.slect11 = 0;
                      });
                    },
                  )),
                  Container(
                      
                      child: Text(
                        "Weekly Statistics",
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
                      )),
                  SizedBox(
                    width: 110,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10),
                    child: PopupMenu(
                      icon: Container(
                          margin: EdgeInsets.only(right: 20),
                          child: Icon(Icons.menu,
                              color: Color.fromARGB(255, 0, 0, 0), size: 35.0)),
                      menuList: [
                        PopupMenuItem(
                           onTap: (){
                            setState(() {
                          widget.slect11 = 5;
                        });
                          },

                            child: item(
                          txt: "All statistics",
                        )),
                        PopupMenuItem(
                           onTap: (){
                            setState(() {
                          widget.slect11 = 4;
                        });
                          },
                          child: item(
                            txt: "Yearly statistics",
                          ),
                        ),
                        PopupMenuItem(
                           onTap: (){
                            setState(() {
                          widget.slect11 = 3;
                        });
                          },
                          child: item(
                            txt: "Monthly statistics",
                          ),
                        ),
                        PopupMenuItem(
                           onTap: (){
                            setState(() {
                          widget.slect11 = 2;
                        });
                          },
                          child: item(
                            txt: "Weekly statistics",
                          ),
                        ),
                        PopupMenuItem(
                           onTap: (){
                            setState(() {
                          widget.slect11 = 1;
                        });
                          },
                          child: item(
                            txt: "Daily statistics",
                          ),
                        ),
                      ],
                    ),
                  )
                ]),
              ),
              SizedBox(
               height: 60,
              ),
              Statistiques(
                slc: 2,
              ),
            ],
          );
        }
      case 3:
        {
          return Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Color(0xffB4B4B4),
                  borderRadius: BorderRadius.circular(10),
                ),
                width: 350,
                height: 55,
                margin: EdgeInsets.only(top: 20, left: 15, right: 15),
                child: Row(children: [
                  Container(
                  
                  child: IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios_outlined,
                      size: 25,
                    ),
                    onPressed: () {
                      setState(() {
                         widget.slect11 = 0;
                      });
                    },
                  )),
                  Container(
                      
                      child: Text(
                        "Monthly Statistics",
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
                      )),
                  SizedBox(
                    width: 102,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10),
                    child: PopupMenu(
                      icon: Container(
                          margin: EdgeInsets.only(right: 20),
                          child: Icon(Icons.menu,
                              color: Color.fromARGB(255, 0, 0, 0), size: 35.0)),
                      menuList: [
                        PopupMenuItem(
                           onTap: (){
                            setState(() {
                          widget.slect11 = 5;
                        });
                          },

                            child: item(
                          txt: "All statistics",
                        )),
                        PopupMenuItem(
                           onTap: (){
                            setState(() {
                          widget.slect11 = 4;
                        });
                          },
                          child: item(
                            txt: "Yearly statistics",
                          ),
                        ),
                        PopupMenuItem(
                           onTap: (){
                            setState(() {
                          widget.slect11 = 3;
                        });
                          },
                          child: item(
                            txt: "Monthly statistics",
                          ),
                        ),
                        PopupMenuItem(
                           onTap: (){
                            setState(() {
                          widget.slect11 = 2;
                        });
                          },
                          child: item(
                            txt: "Weekly statistics",
                          ),
                        ),
                        PopupMenuItem(
                           onTap: (){
                            setState(() {
                          widget.slect11 = 1;
                        });
                          },
                          child: item(
                            txt: "Daily statistics",
                          ),
                        ),
                      ],
                    ),
                  )
                ]),
              ),
              SizedBox(
               height: 60,
              ),
              Statistiques(
                slc: 3,
              ),
            ],
          );
        }
      case 4:
        {
          return Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Color(0xffB4B4B4),
                  borderRadius: BorderRadius.circular(10),
                ),
                width: 350,
                height: 55,
                margin: EdgeInsets.only(top: 20, left: 15, right: 15),
                child: Row(children: [
                  Container(
                  
                  child: IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios_outlined,
                      size: 25,
                    ),
                    onPressed: () {
                      setState(() {
                         widget.slect11 = 0;
                      });
                    },
                  )),
                  Container(
                      
                      child: Text(
                        "Yearly Statistics",
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
                      )),
                  SizedBox(
                    width: 117,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10),
                    child: PopupMenu(
                      icon: Container(
                          margin: EdgeInsets.only(right: 20),
                          child: Icon(Icons.menu,
                              color: Color.fromARGB(255, 0, 0, 0), size: 35.0)),
                      menuList: [
                        PopupMenuItem(
                           onTap: (){
                            setState(() {
                          widget.slect11 = 5;
                        });
                          },

                            child: item(
                          txt: "All statistics",
                        )),
                        PopupMenuItem(
                           onTap: (){
                            setState(() {
                          widget.slect11 = 4;
                        });
                          },
                          child: item(
                            txt: "Yearly statistics",
                          ),
                        ),
                        PopupMenuItem(
                           onTap: (){
                            setState(() {
                          widget.slect11 = 3;
                        });
                          },
                          child: item(
                            txt: "Monthly statistics",
                          ),
                        ),
                        PopupMenuItem(
                           onTap: (){
                            setState(() {
                          widget.slect11 = 2;
                        });
                          },
                          child: item(
                            txt: "Weekly statistics",
                          ),
                        ),
                        PopupMenuItem(
                           onTap: (){
                            setState(() {
                          widget.slect11 = 1;
                        });
                          },
                          child: item(
                            txt: "Daily statistics",
                          ),
                        ),
                      ],
                    ),
                  )
                ]),
              ),
              SizedBox(
               height: 60,
              ),
              Statistiques(
                slc: 4,
              ),
            ],
          );
        }
      case 5:
        {
          return Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Color(0xffB4B4B4),
                  borderRadius: BorderRadius.circular(10),
                ),
                width: 350,
                height: 55,
                margin: EdgeInsets.only(top: 20, left: 15, right: 15),
                child: Row(children: [
                  Container(
                  
                  child: IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios_outlined,
                      size: 25,
                    ),
                    onPressed: () {
                      setState(() {
                         widget.slect11 = 0;
                      });
                    },
                  )),
                  Container(
                     
                      child: Text(
                        "Statistics",
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
                      )),
                  SizedBox(
                    width: 165,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10),
                    child: PopupMenu(
                      icon: Container(
                          margin: EdgeInsets.only(right: 20),
                          child: Icon(Icons.menu,
                              color: Color.fromARGB(255, 0, 0, 0), size: 35.0)),
                      menuList: [
                        PopupMenuItem(
                           onTap: (){
                            setState(() {
                          widget.slect11 = 5;
                        });
                          },

                            child: item(
                          txt: "All statistics",
                        )),
                        PopupMenuItem(
                           onTap: (){
                            setState(() {
                          widget.slect11 = 4;
                        });
                          },
                          child: item(
                            txt: "Yearly statistics",
                          ),
                        ),
                        PopupMenuItem(
                           onTap: (){
                            setState(() {
                          widget.slect11 = 3;
                        });
                          },
                          child: item(
                            txt: "Monthly statistics",
                          ),
                        ),
                        PopupMenuItem(
                           onTap: (){
                            setState(() {
                          widget.slect11 = 2;
                        });
                          },
                          child: item(
                            txt: "Weekly statistics",
                          ),
                        ),
                        PopupMenuItem(
                           onTap: (){
                            setState(() {
                          widget.slect11 = 1;
                        });
                          },
                          child: item(
                            txt: "Daily statistics",
                          ),
                        ),
                      ],
                    ),
                  )
                ]),
              ),
              SizedBox(
               height: 60,
              ),
              Statistiques(
                slc: 5,
              ),
            ],
          );
        }
      default:
        {
          return Container();
        }
    }
  }
}



class item extends StatelessWidget {
  final String txt;

  const item({Key? key, required this.txt}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: 10,
        bottom: 10,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 20,
          ),
          Text(txt),
        ],
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      height: 50,
      width: 200,
    );
  }
}
