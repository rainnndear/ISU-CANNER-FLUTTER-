import 'package:flutter/material.dart';
import '../services/task/tasks.dart';
import '../variables/ip_address.dart';
import 'package:qr_flutter/qr_flutter.dart';
class TaskListWidget extends StatefulWidget {
  const TaskListWidget({super.key});

  @override
  _TaskListWidgetState createState() => _TaskListWidgetState();
}

class _TaskListWidgetState extends State<TaskListWidget> {
  List<dynamic> tasks = [];
  bool isLoading = true;
  final TaskService taskService = TaskService(ipaddress);

  @override
  void initState() {
    super.initState();
    fetchTasks();
  }

  Future<void> fetchTasks() async {
    try {
      final fetchedTasks = await taskService.fetchTasks();
      setState(() {
        tasks = fetchedTasks;
        isLoading = false;
      });
    } 
    catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : tasks.isEmpty
            ? const Center(child: Text('No tasks available'))
            : Column(
                children: tasks.map((task) {
                  return ListTile(
                    title: Text(task['name']),
                    onTap: () {
                      final taskId = task['task_id']; 
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TaskDetailScreen(taskId: taskId),
                        ),
                      );
                    },
                  );
                }).toList(),
              );
  }
}




// Example TaskDetailScreen to handle task details
class TaskDetailScreen extends StatelessWidget {
  final int taskId;

  const TaskDetailScreen({super.key, required this.taskId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Details'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20), 

            QrImageView(
              data: taskId.toString(), 
              version: QrVersions.auto,
              size: 200.0, 
            ),
          ],
        ),
      ),
    );
  }
}
