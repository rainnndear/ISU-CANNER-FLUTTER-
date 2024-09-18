import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:open_file/open_file.dart';
import '../../variables/ip_address.dart';

class DownloadAndViewPdfPage extends StatefulWidget {
  final String filename;
  const DownloadAndViewPdfPage({Key? key, required this.filename}) : super(key: key);
  @override
  _DownloadAndViewPdfPageState createState() => _DownloadAndViewPdfPageState();
}

Future<void> _requestPermissions() async {
  if (await Permission.storage.isDenied) {
    await Permission.storage.request();
  }
}


class _DownloadAndViewPdfPageState extends State<DownloadAndViewPdfPage> {
  String? localFilePath;
  bool isDownloading = false;

  @override
  void initState() {
    super.initState();
    _downloadAndViewPdf();
  }

  Future<void> _downloadAndViewPdf() async {
    await _requestPermissions();

    String url = '$ipaddress/pdf/${widget.filename}';
    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var bytes = response.bodyBytes;

      // Get the external storage directory (for Android 14+)
      Directory? dir = await getExternalStorageDirectory();
      dir ??= await getApplicationDocumentsDirectory();

      String filePath = '${dir.path}/${widget.filename}';
      File file = File(filePath);

      // Write the downloaded PDF to file
      await file.writeAsBytes(bytes, flush: true);

      setState(() {
        localFilePath = filePath;
        isDownloading = false;
      });

      // Open the PDF file
      OpenFile.open(localFilePath!);
    } else {
      setState(() {
        isDownloading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to download PDF: ${response.statusCode}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Download and View PDF'),
      ),
      body: Center(
        child: isDownloading
            ? const CircularProgressIndicator()
            : localFilePath != null
                ? Text('PDF downloaded to $localFilePath')
                : const Text('Failed to download PDF'),
      ),
    );
  }
}
