import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:isu_canner/services/filepdf.dart' as filepdf;
import 'package:shared_preferences/shared_preferences.dart';
import '../../model/api_response.dart';
import 'FileContentScreen.dart';

class File extends StatefulWidget {
  const File({super.key});

  @override
  State<File> createState() => _UserState();
}

class _UserState extends State<File> {
  String token = '';
  List<dynamic> file = [];
  bool isLoading = true; // Add a loading state

  @override
  void initState() {
    super.initState();
    loadData();
  }

  // Modify getToken to return a String value (the token)
  Future<String> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token') ?? '';
  }

  Future<void> loadData() async {
    setState(() {
      isLoading = true; // Show loading indicator
    });

    token = await getToken();  // Now it returns the token, and we can await it.

    if (token.isNotEmpty) {
      await getFiles();  // Call the API to get files after loading the token.
    } else {
      print("Token is empty or invalid.");
    }

    setState(() {
      isLoading = false; // Hide loading indicator after data is loaded
    });
  }

  Future<void> getFiles() async {
    ApiResponse response = await filepdf.getFiles(token);

    if (response.error == null) {
      setState(() {
        file = response.data as List<dynamic>;
      });
    } else {
      if (kDebugMode) {
        print('Error fetching files: ${response.error}');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent,
        title: const Text(
          'PDF List',
          style: TextStyle(
            color: Colors.white,
            fontSize: 40.0,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator()) // Show loading indicator
          : Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Task', style: TextStyle(fontWeight: FontWeight.bold)),
                  Text('Template', style: TextStyle(fontWeight: FontWeight.bold)),
                  Text('Template Name', style: TextStyle(fontWeight: FontWeight.bold)),
                  Text('Type', style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
              const Divider(),
              ListView.builder(
                shrinkWrap: true,
                itemCount: file.length,
                itemBuilder: (context, index) {
                  Map files = file[index] as Map;

                  return Column(
                    children: [
                      ListTile(
                        leading: const Icon(Icons.insert_drive_file),
                        title: Text('${files['filename']}'),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FileContentScreen(
                                filePath: files['pdfUrl'],
                                fileType: files['type'],
                              ),
                            ),
                          );
                        },
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text('${files['size']}'),
                              ],
                            ),
                            const SizedBox(width: 10),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text('${files['type']}'),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const Divider(),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
