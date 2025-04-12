import 'package:flutter/material.dart';
import 'package:list_data_api/api_services.dart';

class ScreenWithoutModel extends StatefulWidget {
  const ScreenWithoutModel({super.key});

  @override
  State<ScreenWithoutModel> createState() => _ScreenWithoutModelState();
}

class _ScreenWithoutModelState extends State<ScreenWithoutModel> {
  dynamic postModelList = [];

  bool isReady = false;

  _getPost() {
    isReady = true;
    ApiServices()
        .getPostWithoutModel()
        .then((value) {
          setState(() {
            postModelList = value;
            isReady = false;
          });
        })
        .onError((error, stackTrace) {
          print(error.toString());
        });
  }

  @override
  void initState() {
    _getPost();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return isReady == true
        ? Center(child: CircularProgressIndicator())
        : ListView.builder(
          itemCount: postModelList.length,
          itemBuilder: (context, index) {
            return Card(
              margin: EdgeInsets.all(12),
              child: ListTile(
                leading: Text(postModelList[index]['id'].toString()),
                title: Text(postModelList[index]['title'].toString()),
                subtitle: Text(postModelList[index]['body'].toString()),
              ),
            );
          },
        );
  }
}
