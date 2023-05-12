import 'package:firebase_database/firebase_database.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:flutter/widgets.dart';

class Mail {
   String id;
   String Date;
   String Time;

   Mail ({
    required this.id,
    required this.Date,
    required this.Time,
  });


  //Convert the date to a map
    Map<String, dynamic> toMap() {
    return {
      'id': id,
      'Date': Date,
      'Time': Time,
    };
}

@override
  String toString() {
    return 'Mail{id: $id, Date: $Date, Time: $Time}';
  }

}
  


class BDDLocale {
static late  Future <Database> database;
static bool initial = false;


static Future<List<Mail>> getMails() async {
  final db = await database;
  final List<Map<String, dynamic>> maps = await db.query('mails');
  return List.generate(maps.length, (i) {
    return Mail(
      id: maps[i]['id'],
      Date: maps[i]['Date'],
      Time: maps[i]['Time'],
    );
  });
}

  static Future<void> init() async {
    database = openDatabase(
      join(await getDatabasesPath(), 'mails.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE mails(id TEXT PRIMARY KEY, Date TEXT, Time TEXT)',
        );
      },
      version: 1,
    );

    // Attendre que la base de données soit prête avant de continuer
    await database;
   // Ajouter des mails pour tester
    var fido =  Mail(
      id: 'DNFKFCbcjOEDCxxx',
      Date: '04/05/2023',
      Time: '08:04',
    );

    var fido2 =  Mail(
      id: 'DNFKFCbcjOEDCxbx',
      Date: '04/05/2023',
      Time: '08:05',
    );
    initial =true;
    await insertMail(fido);
    await insertMail(fido2);

    //deleteAllMails();
  }

  


  //FONCTION QUI INSERE DES MAILS 
  static Future<void> insertMail (Mail mail) async {
  final db = await database;

  await db.insert(
    'mails',
    mail.toMap(),
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
}





var fido =  Mail(
  id: 'DNFKFCbcjOEDCxxx',
  Date: '04/05/2023',
  Time: '08:04',
);


/*
await insertMail(fido);
print(await getMails());*/

static Future<void> deleteAllMails() async {
  final db = await database;
  await db.delete('mails');
}

static Future<void> insertMails(List<Mail> mails) async {
  final db = await database;
  final batch = db.batch();
  mails.forEach((mail) {
    batch.insert(
      'mails',
      mail.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  });
  await batch.commit();
}


static Future<bool> mailExists(String id) async {
  final db = await database;
  final List<Map<String, dynamic>> maps = await db.query('mails', where: 'id = ?', whereArgs: [id]);
  return maps.isNotEmpty;
}






}