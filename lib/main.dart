import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(TaskManagerApp());
}

class TaskManagerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My To-Do List',
      theme: ThemeData(
        primarySwatch: Colors.brown,
        scaffoldBackgroundColor: Color(0xFFF5F5DC), // Cream color
        textTheme: TextTheme(
          bodyLarge: GoogleFonts.dancingScript(
              fontSize: 18.0, color: Colors.brown[800]),
          bodyMedium: GoogleFonts.dancingScript(
              fontSize: 16.0, color: Colors.brown[700]),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.brown[300] ?? Colors.brown,
            foregroundColor: Colors.white,
          ),
        ),
      ),
      home: TaskListScreen(),
    );
  }
}

class Task {
  String name;
  bool isCompleted;

  Task({required this.name, this.isCompleted = false});
}

class TaskListScreen extends StatefulWidget {
  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  final List<Task> _tasks = [];
  final TextEditingController _taskController = TextEditingController();

  void _addTask() {
    if (_taskController.text.isNotEmpty) {
      setState(() {
        _tasks.add(Task(name: _taskController.text));
        _taskController.clear();
      });
    }
  }

  void _toggleTaskCompletion(int index) {
    setState(() {
      _tasks[index].isCompleted = !_tasks[index].isCompleted;
    });
  }

  void _deleteTask(int index) {
    setState(() {
      _tasks.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My To-Do List',
            style: GoogleFonts.dancingScript(fontSize: 28.0)),
        backgroundColor: Colors.brown[400] ?? Colors.brown,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _taskController,
                    decoration: InputDecoration(
                      labelText: 'Enter Task',
                      labelStyle:
                          GoogleFonts.dancingScript(color: Colors.brown[700]),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.brown[400] ?? Colors.brown),
                        borderRadius:
                            BorderRadius.circular(8.0), // Less rounded
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.brown[300] ?? Colors.brown),
                        borderRadius:
                            BorderRadius.circular(8.0), // Less rounded
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _addTask,
                  child: Text('Add', style: GoogleFonts.dancingScript()),
                ),
              ],
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _tasks.length,
                itemBuilder: (context, index) {
                  final task = _tasks[index];
                  return Card(
                    color: task.isCompleted
                        ? Colors.brown[100]
                        : Colors.brown[50], // Stick to brown/cream colors
                    elevation: 3,
                    margin: EdgeInsets.symmetric(vertical: 8.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0), // Less rounded
                    ),
                    child: ListTile(
                      leading: Checkbox(
                        value: task.isCompleted,
                        onChanged: (value) => _toggleTaskCompletion(index),
                      ),
                      title: Text(
                        task.name,
                        style: GoogleFonts.dancingScript(
                          decoration: task.isCompleted
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                        ),
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.delete,
                            color: Colors.brown[600]), // Brown trash can icon
                        onPressed: () => _deleteTask(index),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
