import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;

void main() {
  runApp(const UnStore());
}

class UnStore extends StatefulWidget {
  const UnStore({super.key});

  @override
  State<UnStore> createState() => _UnStoreState();
}

class _UnStoreState extends State<UnStore> {
  File ? _selectedImage;
  var url = Uri.https('your_domain', '/upload'); // TODO:Change to your domain
  var _imagePath = [];

  @override
  void initState() {
    getData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          color: Colors.amber,
        )
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('UnStore'),
        ),
        body: ListView(
          children: <Widget>[
            Row(
              children: <Widget>[
                Card(
                  child: SizedBox(
                    height: 400,
                      width: 200,
                      child: _selectedImage == null ?const Text("Upload Image") : Image.file(_selectedImage!)),
                )
              ],
            ),
            for(var i in _imagePath) returnContainer(i)
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _picImageFromGallery,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  Future _picImageFromGallery() async {
    final returnedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState((){
      _selectedImage = File(returnedImage!.path);
    });
    var request = http.MultipartRequest('POST', url);
    request.files.add(
      await http.MultipartFile.fromPath('file', returnedImage!.path)
    );
    var response = await request.send();
    print(response.statusCode);
  }
  getData() async{
    var getUrl = Uri.https('your_domain', '/data'); // TODO:Change to your domain
    var response = await http.get(getUrl);
    var data = jsonDecode(response.body);
    data = data['path'];
    setState(() {
      _imagePath = data;
    });
  }
}


Widget returnContainer(String path){
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10.0),
    ),
    // TODO:Change to your domain
    child: Image.network('https://your_domain/images/$path'),
  );
}



