import 'package:flutter/material.dart';
import 'package:cyprus_mobdev_course/src/task.dart';
import 'package:cyprus_mobdev_course/src/api.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TaskList extends StatefulWidget {
  const TaskList({Key? key}) : super(key: key);

  @override
  State<TaskList> createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  List<Task> tasks = [];
  List<int> indexes = [];
  SharedPreferences? ioModule;

  Task giveTaskByIndex(int id){
    if(tasks.isEmpty){
      Task task = loadTask(id: id, ioModule: ioModule!);
      tasks.add(task);
      return task;
    }
    for (Task task in tasks){
      if(task.id == id){
        return task;
      }
    }
    Task task = loadTask(id: id, ioModule: ioModule!);
    tasks.add(task);
    return task;
  }

  int findMaxIndex() {
    if(indexes.isEmpty){
      return 1;
    }
    var max = indexes[0];
    for (var element in indexes) {
      if (element > max) {
        max = element;
      }
    }
    return max;
  }

  addNewTask(String date, String text) {
    var newIndex = findMaxIndex() + 1;
    var task = Task(DateTime.parse(date), text, newIndex);
    saveTask(task: task, ioModule: ioModule!);
    setState(() {
      indexes.add(newIndex);
    });
    saveIndexes(indexes: indexes, ioModule: ioModule!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Amazing list app by Ilia Nechaev"),
          actions: [
            IconButton(
                onPressed: () {
                  _makingNewTaskDialogBuilder(context);
                },
                icon: Icon(Icons.add))
          ],
        ),
        body: dataBuilder());
  }

  FutureBuilder<SharedPreferences> dataBuilder() {
    return FutureBuilder(
        future: getIOModule(),
        builder:
            (BuildContext context, AsyncSnapshot<SharedPreferences> snapshot) {
          if (snapshot.hasData) {
            ioModule = snapshot.data!;
            if (isThereData(ioModule!)) {
              indexes = loadTasksIndexes(ioModule!);
              return listViewBuilder();
            } else {
              return Center(
                  child: const Text(
                "Add task",
                style: TextStyle(fontSize: 30),
              ));
            }
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }

  ListView listViewBuilder() {
    return ListView.builder(
      itemBuilder: (context, index) {
        return buildTask(index);
      },
      itemCount: indexes.length,
    );
  }

  buildTask(int index) {
    var task = giveTaskByIndex(indexes[index]);
    Text status;
    if (task.getStatus()){
      status = Text("OK", style: TextStyle(color: Colors.green),);
    } else {
      status = Text("LATE", style: TextStyle(color: Colors.red),);
    }
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          status,
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [Text(task.text, style: TextStyle(fontWeight: FontWeight.bold),), Text(task.getStatusString())],
          ),
          Checkbox(
            value: task.isDone,
            onChanged: (bool? value) {
              setState(() {
                //task.changeStatus();
                task.isDone = value!;
              });
            },
            checkColor: Colors.white,
            fillColor: MaterialStateProperty.resolveWith((states) => Colors.blue),
          )
        ],
      ),
    );
  }

  Future<void> _makingNewTaskDialogBuilder(BuildContext context) {
    TextEditingController dateController = TextEditingController();
    dateController.text = "";
    TextEditingController taskTextController = TextEditingController();
    taskTextController.text = "";
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Specify task'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextField(
                controller: taskTextController,
                decoration:
                    const InputDecoration(labelText: "Enter task description"),
              ),
              TextField(
                controller: dateController,
                //editing controller of this TextField
                decoration: const InputDecoration(
                    icon: Icon(Icons.calendar_today), //icon of text field
                    labelText: "Enter Date" //label text of field
                    ),
                readOnly: true,
                // when true user cannot edit text
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      //get today's date
                      firstDate: DateTime(2000),
                      //DateTime.now() - not to allow to choose before today.
                      lastDate: DateTime(2101));

                  if (pickedDate != null) {
                    String formattedDate = DateFormat('yyyy-MM-dd').format(
                        pickedDate); // format date in required form here we use yyyy-MM-dd that means time is removed
                    dateController.text =
                        formattedDate; //set foratted date to TextField value.
                  }
                },
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Cansel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Add task'),
              onPressed: () {
                if (dateController.text == "") {
                  showToast("Enter date please");
                  return;
                }
                if (taskTextController.text == "") {
                  showToast("Enter task description please");
                  return;
                }
                Navigator.of(context).pop();
                addNewTask(dateController.text, taskTextController.text);
              },
            ),
          ],
        );
      },
    );
  }

  showToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.blueGrey,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
