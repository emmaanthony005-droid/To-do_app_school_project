import 'package:daily_planner/model/task.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class TasksPage extends StatefulWidget{
  const TasksPage({Key? key}) : super (key: key);

  @override
  State<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  double? _deviceHeight, _deviceWidth; //"?" is used to indicate that a variable might have a null value sometimes (Null safety)
  String? content; //For the user to return the value of the content
  Box? _box; //A box is an instance of your database and it's part of the core hive_flutter library. The box is used to build our tasks view
  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: _deviceHeight! * 0.1,
          title: const Text("My Daily Planner"),
        ),
        body: _tasksWidget(),
        floatingActionButton: FloatingActionButton(
          onPressed: displayTaskPop,
          child: Icon(Icons.add),
        )
    );
  }

  Widget _todoList(){
    List tasks = _box!.values.toList();
    return ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (BuildContext context, int index){
          var task = Task.fromMap(tasks[index]);
      return ListTile(
        title: Text(task.todo),
        subtitle: Text(task.timestamp.toString()),
        trailing: task.done? Icon(Icons.check_box_outlined, color: Colors.green): Icon(Icons.check_box_outline_blank, color: Colors.red),
        onTap: (){
          task.done= !task.done;
          _box!.putAt(index, task.toMap());
          setState(() {

          });
        },
        onLongPress: (){
          _box!.deleteAt(index);
          setState(() {

          });
        },
      );
    });
  }
  Widget _tasksWidget(){
    return FutureBuilder(
      future: Hive.openBox("tasks"),
        builder: (BuildContext context, AsyncSnapshot snapshot){ //The data gotton from the hive box is stored in the snapshot
      if(snapshot.hasData){ //that is if our snapshot isnt empty
        _box = snapshot.data; // Storing the retrieved data in the box variable
        return _todoList();
      }else{
        return Center(child: const CircularProgressIndicator()); //i.e the loading bar
      }
      });

  }

  void displayTaskPop(){
    showDialog(context: context, builder: (BuildContext _context){
      return AlertDialog(
        title: const Text("Add a ToDo"),
        content: TextField(
          onSubmitted: (value){

            if (content != null){
              var task = Task(
                  todo: content!,
                  timestamp: DateTime.now(),
                  done: false);
              _box!.add(task.toMap());
              setState((){
                print(value); //where value indicates user text
                Navigator.pop(context); //.pop means we're dismissing the showdialogue box
              });
            }

          },
          onChanged: (value){
            setState((){
              content = value; //As user types, changes are added to the content
              print(value);
            });
          },
        )
      );
    });
  }
}