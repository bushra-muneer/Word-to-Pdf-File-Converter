import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:dio/dio.dart';
import 'package:downloads_path_provider_28/downloads_path_provider_28.dart';
import 'dart:io';
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

                print('dowload file');
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
  void dio_uploadFile(File file) async{
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

    var resp1=await dio.post('https://api.pspdfkit.com/build',data: formData,   options: Options(
        headers:headers
    ),);
 //   resp1.data.pipe(fs.createWriteStream("result.pdf"));

    //  print(resp1.data.toString());
   // print(resp1.statusCode.toString());
    print('status :${resp1.statusCode}');
    /*;
    final responsedd = await http.Response.fromStream(streamedResponse);
    print(responsedd);
    print(responsedd.body);
    print(responsedd.statusCode);
  */
   // downloadFile(file);
  }

  //Map<String, DownloadProgress> downloadProgress = {};

  void downloadFile(File file) async{
    Dio dio=Dio();
    var headers = {
      'Authorization': 'Bearer pdf_live_5smO3vYKPzKmJ1R8Po5kFmmJikjOytdbMLicLftLX8i',
      'Cookie': 'AWSALB=5lvD+3Q0OOiYytHOYlAsBRurD9MEmQ5noPVgN3pEc8ytnp9GQJmDY6wlVcQBT8+BNNPR4XXoWHOQi3zULN1xNntZIUZizJFaXgPeX+dG030nmN4lraR9Lv0pjIW2; AWSALBCORS=5lvD+3Q0OOiYytHOYlAsBRurD9MEmQ5noPVgN3pEc8ytnp9GQJmDY6wlVcQBT8+BNNPR4XXoWHOQi3zULN1xNntZIUZizJFaXgPeX+dG030nmN4lraR9Lv0pjIW2'
    };
    if (file == null) return;
    Directory? downloadsDirectory = Platform.isIOS
        ? await getApplicationDocumentsDirectory()
        : await DownloadsPathProvider.downloadsDirectory;
    bool hasExisted = downloadsDirectory!.existsSync();
    print(downloadsDirectory.existsSync());
    if (!hasExisted) {
      await downloadsDirectory.create();
    }
    print("before save path");
    print(downloadsDirectory.existsSync());
    print(downloadsDirectory.toString());
    String savePath = '${downloadsDirectory.path}/${file}';
    try {
      print("inside try ");

      //failed from here-- download should not contain file
      Response response = await dio.get(
        url,
        options: Options(
          responseType: ResponseType.bytes,
          followRedirects: false,
          headers: headers,
          validateStatus: (status) {
            return status! < 500;
          },
        ),
      );
      print("after response");
      print(response.headers);
      print("status: ${response.statusCode}");
     File file = File(savePath);
     print("saved path");
     var raf = file.openSync(mode: FileMode.write);

      raf.writeFromSync(response.data);
      await raf.close();
      print("Success");
    } on DioError catch (e) {
       print(e.response);
    }
  }
  void uploadFile(File file) async {
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
   /* if (response.statusCode == 200) {

      print(await response.stream.bytesToString());
    }
    else {
      print(response.reasonPhrase);
    }*/
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
    dio_uploadFile(file);
    } else {
      return;
    }
  }
}
