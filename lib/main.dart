import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:dio/dio.dart';
import 'package:downloads_path_provider_28/downloads_path_provider_28.dart';
import 'dart:io';
import 'package:open_file/open_file.dart';
import 'package:http/http.dart' as http;
import 'package:file_picker/file_picker.dart';


void main() {
  runApp(Main());
}

class Main extends StatefulWidget {
  Main({Key? key}) : super(key: key);
  @override
  MainState createState() => MainState();
}

class MainState extends State<Main> {
  static final token = 'pdf_live_5smO3vYKPzKmJ1R8Po5kFmmJikjOytdbMLicLftLX8i';
  String url = 'https://api.pspdfkit.com/build';
  String baseurl='https://api.pspdfkit.com';
  var resp;
  var resp_full;
  bool check=false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.green[100],
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text("Selected File: "),
            MaterialButton(
              onPressed: () {
                pickFile();
              },
              child: Text(
                'Pick file',
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.green,
            ),
            SizedBox(
              height: 20,
            ),
            MaterialButton(
              onPressed: () {
setState(() {
  check=true;
});

                print('dowload file');

                downloadFile(resp,check);
              },
              child: Text(
                'Dowload file',
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.green,
            )
          ],
        ),
      ),
    );
  }

   dio_uploadFile(File file) async{
    Dio dio=Dio();
    var headers = {
      'Authorization': 'Bearer pdf_live_5smO3vYKPzKmJ1R8Po5kFmmJikjOytdbMLicLftLX8i',
      'Cookie': 'AWSALB=5lvD+3Q0OOiYytHOYlAsBRurD9MEmQ5noPVgN3pEc8ytnp9GQJmDY6wlVcQBT8+BNNPR4XXoWHOQi3zULN1xNntZIUZizJFaXgPeX+dG030nmN4lraR9Lv0pjIW2; AWSALBCORS=5lvD+3Q0OOiYytHOYlAsBRurD9MEmQ5noPVgN3pEc8ytnp9GQJmDY6wlVcQBT8+BNNPR4XXoWHOQi3zULN1xNntZIUZizJFaXgPeX+dG030nmN4lraR9Lv0pjIW2'
    };

    var params = '{\n  "parts": [\n    {\n      "file": "document"\n    }\n  ]\n}\n';
    FormData formData = new FormData.fromMap({
      'instructions': params,

      'document': await MultipartFile.fromFile(
        file.path,
        filename: file.path.split('/').last),

    });

     resp=await dio.post('https://api.pspdfkit.com/build',data: formData,   options: Options(responseType: ResponseType.bytes,
        headers:headers
    ),);
 //   resp1.data.pipe(fs.createWriteStream("result.pdf"));

    //  print(resp1.data.toString());
   // print(resp1.statusCode.toString());
    print('status :${resp.statusCode}');
    print('resp :${resp.data}');
resp_full=resp.data;
return resp_full;
  }


  void pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        allowedExtensions: ['docx'],
        type: FileType.custom);
    if (result != null) {
      File file = File(result.files.single.path.toString());
      print(file);
      //uploadFile(file);
      resp=dio_uploadFile(file);
      print("received resp success");
    } else {
      return;
    }
  }

}

void downloadFile(resp1,ch) async{
  if (ch==true && resp1 !=null) {
    print("response received");
    final directory = await getApplicationDocumentsDirectory();
    final path = directory.path;

    File file1 = File('$path/Outputnew1.pdf');

    await file1.writeAsBytes(resp1.data, flush: true);

//Open the PDF document in mobile
    OpenFile.open('$path/Outputnew1.pdf');
    print('$path/Outputnew1.pdf');
    File('$path/Outputnew1.pdf').copy('/Documents/Outputnew1.pdf');
    print("Success");
  }else{
    print("check false");
  }
}

/*  void uploadFile(File file) async {
  //imageFile is your image file
    var headers = {
      'Authorization': 'Bearer pdf_live_iB8XVQtXOYUbGpwMj1zTGY4CYAGoW4SRYyrG25NFIYR',
      'Cookie': 'AWSALB=5lvD+3Q0OOiYytHOYlAsBRurD9MEmQ5noPVgN3pEc8ytnp9GQJmDY6wlVcQBT8+BNNPR4XXoWHOQi3zULN1xNntZIUZizJFaXgPeX+dG030nmN4lraR9Lv0pjIW2; AWSALBCORS=5lvD+3Q0OOiYytHOYlAsBRurD9MEmQ5noPVgN3pEc8ytnp9GQJmDY6wlVcQBT8+BNNPR4XXoWHOQi3zULN1xNntZIUZizJFaXgPeX+dG030nmN4lraR9Lv0pjIW2'
    };
    var request = http.MultipartRequest('POST', Uri.parse('https://api.pspdfkit.com/build'));
    request.fields.addAll({
      'instructions': '{\n  "parts": [\n    {\n      "file": "document"\n    }\n  ]\n}\n'
    });
    request.files.add(await http.MultipartFile.fromPath(
    'document', file.path));
        request.headers.addAll(headers);

    print("sendingg");
    final streamedResponse = await request.send();
    final responsedd = await http.Response.fromStream(streamedResponse);

    print('status code:${responsedd.statusCode}');
   */
  /* if (response.statusCode == 200) {

      print(await response.stream.bytesToString());
    }
    else {
      print(response.reasonPhrase);
    }*//*
  }*/

