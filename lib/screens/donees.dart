import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

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