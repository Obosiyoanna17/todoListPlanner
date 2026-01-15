import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:my_todo_app/Todo/Task.dart';
class TasksPage extends StatefulWidget {
  const TasksPage({Key? key}) : super(key: key);

@override
State<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  double? _deviceHeight, _deviceWidth;
  String? content;

  // Box is like an instance of your database. It is part of Core Hive Library
  Box? _box;
  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: _deviceHeight! * 0.1,
        title: const Text("Daily Planner"),
      ),
      body: _tasksWidget(),
      floatingActionButton: FloatingActionButton(
          onPressed: displayTaskPop,
          child: const Icon(Icons.add),
            // print("Add new todo");
      ),
    );
  }

  Widget _todoList() {
    List tasks = _box!.values.toList();
    return ListView.builder(
      itemCount: tasks.length,
        itemBuilder: (BuildContext context , int index){
         var task = Task.fromMap(tasks[index]);
          return ListTile(
            title: Text(task.todo),
            subtitle: Text(task.timeStamp.toString()),
            trailing: task.done ? const Icon(Icons.check_box_outlined, color: Colors.blue): const Icon(Icons.check_box_outline_blank),
            onTap: (){
              task.done = !task.done;
              _box!.putAt(index, task.toMap());
              setState(() {

              });
            },
              onLongPress: (){
              _box!.deleteAt(index);
              setState(() {
              });
              }
          );
        });

  }
  Widget _tasksWidget() {
    // FutureBuilder is a widget that returns a future
    return FutureBuilder(
      future: Hive.openBox("tasks"),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        //   If data is not empty in the snapshot(stores our data),
        if (snapshot.hasData) {
          _box = snapshot.data;
          return _todoList();
        } else {
          return Center(child: const CircularProgressIndicator());
        }
      });
  }

  void displayTaskPop() {
    //   to create a pop-up dialog for people to ask or to respond e.g to cancel or confirm a particular action you use another widget called
    showDialog(
      context: context,
      builder: (BuildContext _context) {
        return AlertDialog(
          title: const Text("Add a new ToDo"),
          content: TextField(
            onSubmitted: (value ) {
              if (content != null) {
                var task = Task(todo: content!, timeStamp: DateTime.now(), done: false);
                
            _box!.add(task.toMap());
              }
              setState(() {
                // pop means we are dismissing the showDialog box
                print(value);
                Navigator.pop(context);
              });
          },
            onChanged: (value){
          // whenever the user value changes we have to manage state
              setState(() {
                content = value;
                print(value);
              });
          },
          ),
        );
        });
      }
}
// Stateful Widget - whenever a piece of data changes you have to notify the widget that rely on that piece of data so that it can redraw them or inform their view
//READ ABOUT : Map, futures and future builder