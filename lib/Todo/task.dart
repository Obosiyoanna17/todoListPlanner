class Task {
  String todo;
  DateTime timeStamp;
  bool done;

  Task({required this.todo, required this.timeStamp, required this.done});
// The hive database is map based which means it takes a key value pair. That is a map is a key value pair.

  // convert Task object to Map
  Map toMap(){
    return{
      'todo':todo,
      'timeStamp':timeStamp,
      'done':done,
};
  }

  // convert Map back to Task object
  factory Task.fromMap(Map task){
    return Task(
      todo: task['todo'], timeStamp: task['timeStamp'], done: task['done'],
    );
  }
}

