import 'dart:ffi' hide Size;
import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'charts.dart';

class Statistiques extends StatefulWidget {
  int slc;
  Statistiques({super.key, required this.slc});

  @override
  State<Statistiques> createState() => _StatistiquesState();
}

class _StatistiquesState extends State<Statistiques> {
      late Future<List<double>> _futureData,_futureDataMonthly;

     Query ref = FirebaseDatabase.instance.ref('mails');
    double eight =0,nine=0,ten=0,eleven=0,twelve=0,thirteen=0;
        double sat=0,sun=0,mon=0,tus=0,wed=0,thu=0,fri=0; 


          @override
          void initState()  {
            super.initState();

              _futureData=StpMarche();
              _futureDataMonthly=StpMarcheMois();
            
          }
 
 
 
  @override
  Widget build(BuildContext context) {

 return  _getBody(widget.slc);
 }
      

      

  Widget _getBody(int selct)  {


    //Valeurs des stats journalières
   
 


    
    switch (selct) {
      case 1:
        {
         
      return FutureBuilder<List<double>>(
      future: _futureData,
      builder: (context, snapshot) {
          if (snapshot.hasData) {
            /*ref = FirebaseDatabase.instance.ref('mails').orderByChild('Time').startAt('09:00').endAt('09:59');
            double eight=getDataJour(ref,snapshot); */
            /*ref =FirebaseDatabase.instance.ref('mails').orderByChild('Time').startAt('08:00').endAt('08:59');
            double nine=getDataJour(ref,snapshot);*/
            
             return BarChartSample(
              width: 6,
              lesX: ["08:00", "09:00", "10:00", "11:00", "12:00", "13:00","14:00"],
              lesvaleurs: [eight, nine, ten,eleven, twelve, thirteen],
              max: 10,
              intervalle: "This day",
            );

   } else {
      return Center(
                        child: CircularProgressIndicator(
                          color: Color(0xffe26127),
                        ),
                      );
   }
  },
);
        }
      case 2:
       
        {

      return FutureBuilder<List<double>>(
      future: _futureDataMonthly,
      builder: (context, snapshot) {
          if (snapshot.hasData) {
          return BarChartSample(
              width: 6,
              lesX: ["Sat", "Sun", "Mon", "Tus", "Wed", "Thu", "Fri"],
              lesvaleurs: [sat, sun, mon, tus, wed, thu,fri],
              max: 60,
              intervalle: "This week");
        }  else {
      return Center(
                        child: CircularProgressIndicator(
                          color: Color(0xffe26127),
                        ),
                      );
        }
   },
);
   
   }
  
       
      case 3:
        {
          return BarChartSample(
              width: 6,
              lesX: ["01", "02", "03", "04", "05", "06", "07"],
              lesvaleurs: [0, 0, 0, 0, 50, 0],
              max: 100,
              intervalle: "This month");
        }
      case 4:
        {
          return BarChartSample(
              width: 5,
              lesX: [ "2019", "2020", "2021", "2022", "2023","2024"],
              lesvaleurs: [0, 0, 0, 0, 0, 0, 54],
              max: 300,
              intervalle: "This year");
        }

      case 5:
        {
          return BarChartSample(
              width: 5,
              lesX: ['2018', "2019", "2020", "2021", "2022", "2023"],
              lesvaleurs: [150, 200, 50, 80, 120, 2, 54],
              max: 300,
              intervalle: "All mails");
        }
      default:
        return Container();
        
    }
    
  }
  
   double getDataJour (Query reference,AsyncSnapshot<DatabaseEvent> snapshot){
      Map<dynamic, dynamic> map = snapshot.data!.snapshot.value as dynamic;
            List list = [];
            list.clear();
            list = map.values.toList();
            //list.removeWhere((element) => element["Date"] != "09/05/2023");
            return list.length.toDouble() ;
  }



  Future<List<double>> StpMarche () async {
      List<double> maListe = [];

  Query ref8 = FirebaseDatabase.instance.ref('mails').orderByChild('Time').startAt('08:00').endAt('08:59');
            
            try{
            final snap8 = await ref8.get();
            if(snap8.value!=null){
            Map<dynamic, dynamic> map8 = snap8.value as dynamic;
            List<dynamic> list8 = [];
            list8.clear();
            list8 = map8.values.toList();
            list8.removeWhere((element) => element["Date"] != "09/05/2023");
            eight = list8.length.toDouble();
}
            } on FirebaseException catch (e){
              print(e.message);
            }
           // maListe.add(eight);
   Query ref9 = FirebaseDatabase.instance.ref('mails').orderByChild('Time').startAt('09:00').endAt('09:59');
            
            try{
            final snap9 = await ref9.get();
            if(snap9.value != null){
            Map<dynamic, dynamic> map = snap9.value as dynamic;
            List<dynamic> list2 = [];
            list2.clear();
            list2 = map.values.toList();
           list2.removeWhere((element) => element["Date"] != "09/05/2023");

            nine = list2.length.toDouble();
            print(nine);
            }
            } on FirebaseException catch (e){
              print(e.message);
            }
                        //maListe.add(nine);

   Query ref10 = FirebaseDatabase.instance.ref('mails').orderByChild('Time').startAt('10:00').endAt('10:59');
            
            try{
            final snap10 = await ref10.get();
            Map<dynamic, dynamic> map = snap10.value as dynamic;
            List<dynamic> list2 = [];
            list2.clear();
            list2 = map.values.toList();
                        list2.removeWhere((element) => element["Date"] != "09/05/2023");

            ten = list2.length.toDouble();

            } on FirebaseException catch (e){
              print(e.message);
            } 
                       // maListe.add(ten);


             Query ref11 = FirebaseDatabase.instance.ref('mails').orderByChild('Time').startAt('11:00').endAt('11:59');
            
            try{
            final snap11 = await ref11.get();
            Map<dynamic, dynamic> map = snap11.value as dynamic;
            List<dynamic> list2 = [];
            list2.clear();
            list2 = map.values.toList();
            list2.removeWhere((element) => element["Date"] != "09/05/2023");

            eleven = list2.length.toDouble();

            } on FirebaseException catch (e){
              print(e.message);
            }
                                //    maListe.add(eleven);



             Query ref12 = FirebaseDatabase.instance.ref('mails').orderByChild('Time').startAt('12:00').endAt('12:59');
            
            try{
            final snap12 = await ref12.get();
            Map<dynamic, dynamic> map = snap12.value as dynamic;
            List<dynamic> list2 = [];
            list2.clear();
            list2 = map.values.toList();
            list2.removeWhere((element) => element["Date"] != "09/05/2023");

            twelve = list2.length.toDouble();

            } on FirebaseException catch (e){
              print(e.message);
            } 
           // maListe.add(twelve);

             Query ref13 = FirebaseDatabase.instance.ref('mails').orderByChild('Time').startAt('13:00').endAt('13:59');
            
            try{
            final snap13 = await ref13.get();
            Map<dynamic, dynamic> map = snap13.value as dynamic;
            List<dynamic> list2 = [];
            list2.clear();
            list2 = map.values.toList();
            list2.removeWhere((element) => element["Date"] != "09/05/2023");
            thirteen = list2.length.toDouble();
            print(list2);

            } on FirebaseException catch (e){
              print(e.message);
            }
                          //maListe.add(thirteen);

              maListe.add(eight);
              maListe.add(nine);
              maListe.add(ten);
              maListe.add(eleven);
              maListe.add(twelve);
              maListe.add(thirteen);
              return maListe;

            
}


 Future<List<double>> StpMarcheMois () async {
      List<double> maListe = []; 
    
      Query ref8 = FirebaseDatabase.instance.ref('mails').orderByChild('Date').equalTo('06/05/2023');
            
            try{
            final snap8 = await ref8.get();
            if(snap8.value!=null){
            Map<dynamic, dynamic> map8 = snap8.value as dynamic;
            List<dynamic> list8 = [];
            list8.clear();
            list8 = map8.values.toList();
            list8.removeWhere((element) => element["Date"] != "09/05/2023");
            sat = list8.length.toDouble();
}
            } on FirebaseException catch (e){
              print(e.message);
            }
           // maListe.add(eight);
   Query ref9 = FirebaseDatabase.instance.ref('mails').orderByChild('Date').equalTo('07/05/2023');
            
            try{
            final snap9 = await ref9.get();
            if(snap9.value != null){
            Map<dynamic, dynamic> map = snap9.value as dynamic;
            List<dynamic> list2 = [];
            list2.clear();
            list2 = map.values.toList();
            sun = list2.length.toDouble();
            print(nine);
            }
            } on FirebaseException catch (e){
              print(e.message);
            }
                        //maListe.add(nine);

   Query ref10 = FirebaseDatabase.instance.ref('mails').orderByChild('Date').equalTo('08/05/2023');
            
            try{
            final snap10 = await ref10.get();
            Map<dynamic, dynamic> map = snap10.value as dynamic;
            List<dynamic> list2 = [];
            list2.clear();
            list2 = map.values.toList();
            mon = list2.length.toDouble();

            } on FirebaseException catch (e){
              print(e.message);
            } 
                       // maListe.add(ten);


             Query ref11 = FirebaseDatabase.instance.ref('mails').orderByChild('Date').equalTo('09/05/2023');
            
            try{
            final snap11 = await ref11.get();
            Map<dynamic, dynamic> map = snap11.value as dynamic;
            List<dynamic> list2 = [];
            list2.clear();
            list2 = map.values.toList();
            tus = list2.length.toDouble();

            } on FirebaseException catch (e){
              print(e.message);
            }


      return maListe;
 }

  
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

