import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Listmails extends StatefulWidget {
  const Listmails({super.key});

  @override
  State<Listmails> createState() => _ListmailsState();
}

class _ListmailsState extends State<Listmails> {
  final ref = FirebaseDatabase.instance.ref('mails');
  final _textcontroller = TextEditingController();
  String data = "+4 new mails";
  String data1 = " New mail";

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 17.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 20,
          ),
          Container(
            // Row()
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
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  )),
              SizedBox(
                width: 150,
              ),
              Container(
                child: Icon(Icons.menu,
                    color: Color.fromARGB(255, 0, 0, 0), size: 35.0),
                padding: EdgeInsets.all(10.0),
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
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child: Row(
                                  children: [
                                    Container(
                                      margin:
                                          EdgeInsets.only(top: 12, left: 16),
                                      child: Icon(Icons.circle,
                                          color: Color(0xFFE26127), size: 20),
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
                                  list[index]['Date'],
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      fontSize: 17),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(right: 170, left: 40),
                                child: Text(
                                  list[index]['Time'],
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      fontSize: 17),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  //Doit retourner un widget
                  return ListTile(
                    title: Text('rien'),
                  );
                }
              })
        ],
      ),
    );
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
