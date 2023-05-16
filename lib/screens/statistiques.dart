import 'dart:ffi' hide Size;
import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';

import 'charts.dart';

class Statistiques extends StatefulWidget {
  int slc;
  Statistiques({super.key, required this.slc});

  @override
  State<Statistiques> createState() => _StatistiquesState();
}

class _StatistiquesState extends State<Statistiques> {
      late Future<List<double>> _futureData,_futureDataMonthly,_getDataMonth,_year;

     Query ref = FirebaseDatabase.instance.ref('mails');
      
      List<double> listHeure = [];
      List<String> listValHeure = [];
      List<String> weekDaysVal = [];
       List<double> weekDays = [];
             List<String> monthsVal = [];
                     List<double> months = [];
                       List<String> yearVal = [];
                     List<double> years = [];



        double eight =0,nine=0,ten=0,eleven=0,twelve=0,thirteen=0;


          @override
          void initState()  {
            super.initState();

              _futureData=StpMarche();
              _futureDataMonthly=StpMarcheMois();
              _getDataMonth=getDataMonth();
              _year=getDataYear();
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
              lesX: ["${listValHeure[5]}:00", "${listValHeure[4]}:00", "${listValHeure[3]}:00", "${listValHeure[2]}:00", "${listValHeure[1]}:00", "${listValHeure[0]}:00","14:00"],
              lesvaleurs: [listHeure[5], listHeure[4], listHeure[3],listHeure[2], listHeure[1], listHeure[0]],
              max: findMax(listHeure)+2,
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
     
     
      //Month statistics
      case 2:
       
        {

      return FutureBuilder<List<double>>(
      future: _futureDataMonthly,
      builder: (context, snapshot) {
          if (snapshot.hasData) {
          return BarChartSample(
              width: 7,
              lesX: [getWeekday(weekDaysVal[0]), getWeekday(weekDaysVal[1]), getWeekday(weekDaysVal[2]), getWeekday(weekDaysVal[3]), getWeekday(weekDaysVal[4]), getWeekday(weekDaysVal[5]), getWeekday(weekDaysVal[6])],
              lesvaleurs: [weekDays[0], weekDays[1], weekDays[2], weekDays[3], weekDays[4], weekDays[5],weekDays[6]],
              max: findMax(weekDays)+2,
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
          
            return FutureBuilder<List<double>>(
      future: _getDataMonth,
      builder: (context, snapshot) {
          if (snapshot.hasData) {
          return BarChartSample(
              width: 6,
              lesX: [extractMonth(monthsVal[5]), extractMonth(monthsVal[4]), extractMonth(monthsVal[3]), extractMonth(monthsVal[2]), extractMonth(monthsVal[1]), extractMonth(monthsVal[0])],
              lesvaleurs: [ months[5], months[4], months[3], months[2], months[1],months[0]],
              max: findMax(months)+2,
              intervalle: "This month");
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
      case 4:
        {
             return FutureBuilder<List<double>>(
      future: _year,
      builder: (context, snapshot) {
          if (snapshot.hasData) {
          return BarChartSample(
              width: 5,
              lesX: [ yearVal[4], yearVal[3], yearVal[2], yearVal[1], yearVal[0]],
              lesvaleurs: [years[4], years[3], years[2], years[1], years[0]],
              max: findMax(years)+2,
              intervalle: "This year");
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

      case 5:
        {
                   return FutureBuilder<List<double>>(
      future: _year,
      builder: (context, snapshot) {
          if (snapshot.hasData) {
          return BarChartSample(
              width: 5,
              lesX: [ yearVal[4], yearVal[3], yearVal[2], yearVal[1], yearVal[0]],
              lesvaleurs: [years[4], years[3], years[2], years[1], years[0]],
              max: findMax(years)+2,
              intervalle: "This year");
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

String getCurrentTime() {
  final now = DateTime.now();
  final formatter = DateFormat('HH');
  return formatter.format(now);
}

String getCurrentDate() {
  final now = DateTime.now();
  final formatter = DateFormat('dd/MM/yyyy');
  return formatter.format(now);
}

List<String> getPreviousYears() {
  final now = DateTime.now();
  final previousYears = <String>[];

  for (int i = 0; i < 5; i++) {
    final year = now.year - i;
    previousYears.add(year.toString());
  }

  return previousYears;
}

List<String> getCurrentAndPreviousHours() {
  final now = DateTime.now();
  final formatter = DateFormat('HH');
  final hours = <String>[];

  for (int i = 0; i < 6; i++) {
    final previousHour = now.subtract(Duration(hours: i));
    final formattedHour = formatter.format(previousHour);
    hours.add(formattedHour);
  }

  return hours;
}

List<String> getPreviousWeekDays() {
  final now = DateTime.now();
  final formatter = DateFormat('dd/MM/yyyy');
  final weekDays = <String>[];

  for (int i = 6; i >= 0; i--) {
    final day = now.subtract(Duration(days: i));
    final formattedDay = formatter.format(day);
    weekDays.add(formattedDay);
  }

  return weekDays;
}
String getWeekday(String dateString) {
  final formatter = DateFormat('dd/MM/yyyy');
  final date = formatter.parse(dateString);
 final weekdayFormatter = DateFormat('EEE');
  final weekday = weekdayFormatter.format(date);
  return weekday;
}

double findMax(List<double> numbers) {
  if (numbers.isEmpty) {
    return 0.0 ;
  }
  
  return numbers.reduce((value, element) => value > element ? value : element);
}

List<String> getPreviousMonths() {
  final now = DateTime.now();
  final formatter = DateFormat('yyyy/MM');
  final previousMonths = <String>[];

  for (int i = 0; i < 6; i++) {
    final month = DateTime(now.year, now.month - i, 1);
    final formattedMonth = formatter.format(month);
    previousMonths.add(formattedMonth);
  }

  return previousMonths;
}

String extractMonth(String date) {
  final List<String> parts = date.split('/');
  
    final String month = parts[1];
    return month;
  
 
}



 Future<List<double>> StpMarche () async {
      List<double> maListe = [];
      listHeure.clear();
      listValHeure.clear();
      listValHeure=getCurrentAndPreviousHours();
      final currentDate = getCurrentDate();
   

  Query ref8 = FirebaseDatabase.instance.ref('mails').orderByChild('Time').startAt("${listValHeure[0]}:00").endAt("${listValHeure[0]}:59");
 
            try{
            final snap8 = await ref8.get();
            if(snap8.value!=null){
            Map<dynamic, dynamic> map8 = snap8.value as dynamic;
            List<dynamic> list8 = [];
            list8.clear();
            list8 = map8.values.toList();
            list8.removeWhere((element) => element["Date"] != currentDate);
            eight = list8.length.toDouble();
            listHeure.add(eight);
}   
            } on FirebaseException catch (e){
              print(e.message);

            }
            if (listHeure.length==0){listHeure.add(0);};


   Query ref9 = FirebaseDatabase.instance.ref('mails').orderByChild('Time').startAt("${listValHeure[1]}:00").endAt("${listValHeure[1]}:59");
            
            try{
            final snap9 = await ref9.get();
            if(snap9.value != null){
            Map<dynamic, dynamic> map = snap9.value as dynamic;
            List<dynamic> list2 = [];
            list2.clear();
            list2 = map.values.toList();
           list2.removeWhere((element) => element["Date"] != currentDate);

            nine = list2.length.toDouble();
            listHeure.add(nine);
            }
            } on FirebaseException catch (e){
              print(e.message);
            }
                        if (listHeure.length==1){listHeure.add(0);};

                        //maListe.add(nine);

   Query ref10 = FirebaseDatabase.instance.ref('mails').orderByChild('Time').startAt("${listValHeure[2]}:00").endAt("${listValHeure[2]}:59");
            
            try{
            final snap10 = await ref10.get();
            if(snap10.value != null){
            Map<dynamic, dynamic> map = snap10.value as dynamic;
            List<dynamic> list2 = [];
            list2.clear();
            list2 = map.values.toList();
            list2.removeWhere((element) => element["Date"] != currentDate);

            ten = list2.length.toDouble();
            listHeure.add(ten);

            }
            } on FirebaseException catch (e){
              print(e.message);
            } 
                       // maListe.add(ten);
                                    if (listHeure.length==2){listHeure.add(0);};


            Query ref11 = FirebaseDatabase.instance.ref('mails').orderByChild('Time').startAt("${listValHeure[3]}:00").endAt("${listValHeure[3]}:59");
            
            try{
            final snap11 = await ref11.get();
            if(snap11.value != null){
            Map<dynamic, dynamic> map = snap11.value as dynamic;
            List<dynamic> list2 = [];
            list2.clear();
            list2 = map.values.toList();
            list2.removeWhere((element) => element["Date"] != currentDate);

            eleven = list2.length.toDouble();
            listHeure.add(eleven);

            }
            } on FirebaseException catch (e){
              print(e.message);
            }
                                //    maListe.add(eleven);

            if (listHeure.length==3){listHeure.add(0);};


             Query ref12 = FirebaseDatabase.instance.ref('mails').orderByChild('Time').startAt("${listValHeure[4]}:00").endAt("${listValHeure[4]}:59");
            
            try{
            final snap12 = await ref12.get();
            if(snap12.value != null){

            Map<dynamic, dynamic> map = snap12.value as dynamic;
            List<dynamic> list2 = [];
            list2.clear();
            list2 = map.values.toList();
            list2.removeWhere((element) => element["Date"] != currentDate);
            twelve = list2.length.toDouble();
            listHeure.add(twelve);
            }
            } on FirebaseException catch (e){
              print(e.message);
            } 
           // maListe.add(twelve);
                                    if (listHeure.length==4){listHeure.add(0);};

             Query ref13 = FirebaseDatabase.instance.ref('mails').orderByChild('Time').startAt("${listValHeure[5]}:00").endAt("${listValHeure[5]}:59");
            
            try{
            final snap13 = await ref13.get();
             if(snap13.value != null){
            Map<dynamic, dynamic> map = snap13.value as dynamic;
            List<dynamic> list2 = [];
            list2.clear();
            list2 = map.values.toList();
            list2.removeWhere((element) => element["Date"] != currentDate);
            thirteen = list2.length.toDouble();
            listHeure.add(thirteen);
            print(list2);
             }
            } on FirebaseException catch (e){
              print(e.message);
            } 
                                         if (listHeure.length==5){listHeure.add(0);};
    
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
       weekDaysVal=getPreviousWeekDays();
       weekDays.clear();
      Query ref8 = FirebaseDatabase.instance.ref('mails').orderByChild('Date').equalTo(weekDaysVal[0]);
            
            try{
            final snap8 = await ref8.get();
            if(snap8.value!=null){
            Map<dynamic, dynamic> map8 = snap8.value as dynamic;
            List<dynamic> list8 = [];
            list8.clear();
            list8 = map8.values.toList();
            weekDays.add(list8.length.toDouble());
}
            } on FirebaseException catch (e){
              print(e.message);
            }
           // maListe.add(eight);
                                                    if (weekDays.length==0){weekDays.add(0);};

   Query ref9 = FirebaseDatabase.instance.ref('mails').orderByChild('Date').equalTo(weekDaysVal[1]);
            
            try{
            final snap9 = await ref9.get();
            if(snap9.value != null){
            Map<dynamic, dynamic> map = snap9.value as dynamic;
            List<dynamic> list2 = [];
            list2.clear();
            list2 = map.values.toList();
            weekDays.add(list2.length.toDouble());
            print(nine);
            }
            } on FirebaseException catch (e){
              print(e.message);
            }
                        //maListe.add(nine);
                        if (weekDays.length==1){weekDays.add(0);};

   Query ref10 = FirebaseDatabase.instance.ref('mails').orderByChild('Date').equalTo(weekDaysVal[2]);
            
            try{
            final snap10 = await ref10.get();
            if(snap10.value != null){
            Map<dynamic, dynamic> map = snap10.value as dynamic;
            List<dynamic> list2 = [];
            list2.clear();
            list2 = map.values.toList();
            weekDays.add(list2.length.toDouble());
            }
            } on FirebaseException catch (e){
              print(e.message);
            } 
                       // maListe.add(ten);
                       if (weekDays.length==2){weekDays.add(0);};


             Query ref11 = FirebaseDatabase.instance.ref('mails').orderByChild('Date').equalTo(weekDaysVal[3]);
            
            try{
            final snap11 = await ref11.get();
            if(snap11.value != null){

            Map<dynamic, dynamic> map = snap11.value as dynamic;
            if(snap11.value != null){
            List<dynamic> list2 = [];
            list2.clear();
            list2 = map.values.toList();
            weekDays.add(list2.length.toDouble());
            }
            }
            } on FirebaseException catch (e){
              print(e.message);
            }
              if (weekDays.length==3){weekDays.add(0);};
               Query ref12 = FirebaseDatabase.instance.ref('mails').orderByChild('Date').equalTo(weekDaysVal[4]);
            
            try{
            final snap11 = await ref12.get();
            if(snap11.value != null){
            Map<dynamic, dynamic> map = snap11.value as dynamic;
            List<dynamic> list2 = [];
            list2.clear();
            list2 = map.values.toList();
            weekDays.add(list2.length.toDouble());
            }
            } on FirebaseException catch (e){
              print(e.message);
            } 

            if (weekDays.length==4){weekDays.add(0);};
               Query ref13 = FirebaseDatabase.instance.ref('mails').orderByChild('Date').equalTo(weekDaysVal[5]);
            
            try{
            final snap11 = await ref13.get();
            if(snap11.value != null){
            Map<dynamic, dynamic> map = snap11.value as dynamic;
            List<dynamic> list2 = [];
            list2.clear();
            list2 = map.values.toList();
            weekDays.add(list2.length.toDouble());
            }
            } on FirebaseException catch (e){
              print(e.message);
            } 
          if (weekDays.length==5){weekDays.add(0);};

            Query ref14 = FirebaseDatabase.instance.ref('mails').orderByChild('Date').equalTo(weekDaysVal[6]);
            
            try{
            final snap11 = await ref14.get();
            if(snap11.value != null){
            Map<dynamic, dynamic> map = snap11.value as dynamic;
            List<dynamic> list2 = [];
            list2.clear();
            list2 = map.values.toList();
            weekDays.add(list2.length.toDouble());
            }
            } on FirebaseException catch (e){
              print(e.message);
            }
            if (weekDays.length==6){weekDays.add(0);};

      return maListe;
 }

 Future<List<double>> getDataMonth () async {
      List<double> maListe = []; 
       monthsVal=getPreviousMonths();
       months.clear();
      Query ref8 = FirebaseDatabase.instance.ref('mails').orderByChild('Date2').startAt("${monthsVal[0]}/01").endAt("${monthsVal[0]}/31");
            
            try{
            final snap8 = await ref8.get();
            if(snap8.value!=null){
            Map<dynamic, dynamic> map8 = snap8.value as dynamic;
            List<dynamic> list8 = [];
            list8.clear();
            list8 = map8.values.toList();
            months.add(list8.length.toDouble());
}
            } on FirebaseException catch (e){
              print(e.message);
            }
           // maListe.add(eight);
                                                    if (months.length==0){months.add(0);};

   Query ref9 = FirebaseDatabase.instance.ref('mails').orderByChild('Date2').startAt("${monthsVal[1]}/01").endAt("${monthsVal[1]}/31");
            
            try{
            final snap9 = await ref9.get();
            if(snap9.value != null){
            Map<dynamic, dynamic> map = snap9.value as dynamic;
            List<dynamic> list2 = [];
            list2.clear();
            list2 = map.values.toList();
            months.add(list2.length.toDouble());
            print(nine);
            }
            } on FirebaseException catch (e){
              print(e.message);
            }
                        //maListe.add(nine);
                        if (months.length==1){months.add(0);};

   Query ref10 = FirebaseDatabase.instance.ref('mails').orderByChild('Date2').startAt("${monthsVal[2]}/01").endAt("${monthsVal[2]}/31");
            
            try{
            final snap10 = await ref10.get();
            if(snap10.value != null){
            Map<dynamic, dynamic> map = snap10.value as dynamic;
            List<dynamic> list2 = [];
            list2.clear();
            list2 = map.values.toList();
            months.add(list2.length.toDouble());
            }
            } on FirebaseException catch (e){
              print(e.message);
            } 
                       // maListe.add(ten);
                       if (months.length==2){months.add(0);};


    Query ref11 = FirebaseDatabase.instance.ref('mails').orderByChild('Date2').startAt("${monthsVal[3]}/01").endAt("${monthsVal[3]}/31");
            
            try{
            final snap11 = await ref11.get();
            if(snap11.value != null){

            Map<dynamic, dynamic> map = snap11.value as dynamic;
            if(snap11.value != null){
            List<dynamic> list2 = [];
            list2.clear();
            list2 = map.values.toList();
            months.add(list2.length.toDouble());
            }
            }
            } on FirebaseException catch (e){
              print(e.message);
            }
              if (months.length==3){months.add(0);};
    
    Query ref12 = FirebaseDatabase.instance.ref('mails').orderByChild('Date2').startAt("${monthsVal[4]}/01").endAt("${monthsVal[4]}/31");
            
            try{
            final snap11 = await ref12.get();
            if(snap11.value != null){
            Map<dynamic, dynamic> map = snap11.value as dynamic;
            List<dynamic> list2 = [];
            list2.clear();
            list2 = map.values.toList();
            months.add(list2.length.toDouble());
            }
            } on FirebaseException catch (e){
              print(e.message);
            } 

            if (months.length==4){months.add(0);};
    Query ref13 = FirebaseDatabase.instance.ref('mails').orderByChild('Date2').startAt("${monthsVal[5]}/01").endAt("${monthsVal[5]}/31");
            
            try{
            final snap11 = await ref13.get();
            if(snap11.value != null){
            Map<dynamic, dynamic> map = snap11.value as dynamic;
            List<dynamic> list2 = [];
            list2.clear();
            list2 = map.values.toList();
            months.add(list2.length.toDouble());
            }
            } on FirebaseException catch (e){
              print(e.message);
            } 
          if (months.length==5){months.add(0);};

         

      return maListe;
 }


Future<List<double>> getDataYear () async {
      List<double> maListe = []; 
       yearVal=getPreviousYears();
       years.clear();
      Query ref8 = FirebaseDatabase.instance.ref('mails').orderByChild('Date2').startAt("${yearVal[0]}/01/01").endAt("${yearVal[0]}/12/31");
            
            try{
            final snap8 = await ref8.get();
            if(snap8.value!=null){
            Map<dynamic, dynamic> map8 = snap8.value as dynamic;
            List<dynamic> list8 = [];
            list8.clear();
            list8 = map8.values.toList();
            years.add(list8.length.toDouble());
}
            } on FirebaseException catch (e){
              print(e.message);
            }
           // maListe.add(eight);
                                                    if (years.length==0){years.add(0);};

   Query ref9 = FirebaseDatabase.instance.ref('mails').orderByChild('Date2').startAt("${yearVal[1]}/01/01").endAt("${yearVal[1]}/12/31");
            
            try{
            final snap9 = await ref9.get();
            if(snap9.value != null){
            Map<dynamic, dynamic> map = snap9.value as dynamic;
            List<dynamic> list2 = [];
            list2.clear();
            list2 = map.values.toList();
            years.add(list2.length.toDouble());
            print(nine);
            }
            } on FirebaseException catch (e){
              print(e.message);
            }
                        //maListe.add(nine);
                        if (years.length==1){years.add(0);};

   Query ref10 = FirebaseDatabase.instance.ref('mails').orderByChild('Date2').startAt("${yearVal[2]}/01/01").endAt("${yearVal[2]}/12/31");
            
            try{
            final snap10 = await ref10.get();
            if(snap10.value != null){
            Map<dynamic, dynamic> map = snap10.value as dynamic;
            List<dynamic> list2 = [];
            list2.clear();
            list2 = map.values.toList();
            years.add(list2.length.toDouble());
            }
            } on FirebaseException catch (e){
              print(e.message);
            } 
                       // maListe.add(ten);
                       if (years.length==2){years.add(0);};


    Query ref11 = FirebaseDatabase.instance.ref('mails').orderByChild('Date2').startAt("${yearVal[3]}/01/01").endAt("${yearVal[3]}/12/31");
            
            try{
            final snap11 = await ref11.get();
            if(snap11.value != null){

            Map<dynamic, dynamic> map = snap11.value as dynamic;
            if(snap11.value != null){
            List<dynamic> list2 = [];
            list2.clear();
            list2 = map.values.toList();
            years.add(list2.length.toDouble());
            }
            }
            } on FirebaseException catch (e){
              print(e.message);
            }
              if (years.length==3){years.add(0);};
    
    Query ref12 = FirebaseDatabase.instance.ref('mails').orderByChild('Date2').startAt("${yearVal[4]}/01/01").endAt("${yearVal[4]}/12/31");
            
            try{
            final snap11 = await ref12.get();
            if(snap11.value != null){
            Map<dynamic, dynamic> map = snap11.value as dynamic;
            List<dynamic> list2 = [];
            list2.clear();
            list2 = map.values.toList();
            years.add(list2.length.toDouble());
            }
            } on FirebaseException catch (e){
              print(e.message);
            } 

            if (years.length==4){years.add(0);};
    
         

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

