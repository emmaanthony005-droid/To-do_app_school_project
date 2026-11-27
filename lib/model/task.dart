class Task {
  String todo;
  DateTime timestamp;
  bool done;

  Task({required this.todo, required this.timestamp, required this.done});

  Map toMap(){
    return{
      'todo':todo,
      'timestamp':timestamp,
      'done':done,
    };
  }

  factory Task.fromMap(Map task){
    return Task(
        todo: task['todo'], timestamp: task['timestamp'], done: task['done']);
  }
}