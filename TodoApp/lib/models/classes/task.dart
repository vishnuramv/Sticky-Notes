// import 'dart:convert';

class Task {
  List<Task> tasks;
  String note;
  DateTime timeToComplete;
  bool completed;
  String repeats;
  DateTime deadline;
  List<DateTime> reminders;
  int taskId;
  String title;
  
  Task(this.title, this.taskId, this.note);

  factory Task.fromJson(Map<String, dynamic> parsedJson) {
    return Task(
      parsedJson['title'],
      parsedJson['id'],
      parsedJson['note'],
      // parsedJson['deadline'],
      );
  }
} 