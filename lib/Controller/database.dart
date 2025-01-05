import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:task_app/Model/taskmodel.dart';


dynamic database;

Future<void> insertTaskData(ModalTaskCard taskCard) async {
  final localDB = await database;
  localDB.insert(
    'Task',
    taskCard.taskMap(),
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
}

//
Future<List<ModalTaskCard>> getTaskData() async {
  final localDB = await database;
  List<Map<String, dynamic>> cardList = await localDB.query("Task");
  return List.generate(cardList.length, (i) {

    print(cardList[i]["taskId"]);
    print(cardList[i]["title"]);
    print(cardList[i]["description"]);
    print(cardList[i]["date"]);
    print(cardList[i]["isfinished"]);
    print(cardList[i]['priority']);

    return ModalTaskCard(
      taskId: cardList[i]["taskId"],
      title: cardList[i]["title"],
      description: cardList[i]["description"],
      date: cardList[i]["date"],
      isfinished: cardList[i]["isfinished"],
      priority: cardList[i]["priority"], 
    );
  });
}

Future<void> deleteTaskData(ModalTaskCard taskCard) async {
  final localDB = await database;
  await localDB.delete(
    'Task',
    where: "title = ?",
    whereArgs: [taskCard.title],
  );
}

Future<void> updateCardlist(ModalTaskCard obj) async {
  final localDB = await database;
  await localDB.update(
    "Task",
     obj.taskMap(),
     where: "title =?",
     whereArgs: [obj.title]);
}

Future<void> createDatabase() async {
  database = await openDatabase(
    join(await getDatabasesPath(), "Tasks.db"),
    version: 1,
    onCreate: (db, version) async {
      await db.execute('''CREATE TABLE Task(
        taskId INT PRIMARY KEY,
        isfinished TEXT,
        title Text ,
        description Text,
        date Text,
        priority TEXT
        )''');
    },
  );
}
