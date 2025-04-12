import 'package:flutter/material.dart';
import 'package:list_data_api/api_services.dart';
import 'package:list_data_api/post_model.dart';
import 'package:list_data_api/screen_without_model.dart';

class ScreenWithModel extends StatefulWidget {
  const ScreenWithModel({super.key});

  @override
  State<ScreenWithModel> createState() => _ScreenWithModelState();
}

class _ScreenWithModelState extends State<ScreenWithModel> {
  List<PostModel> postModelList = [];

  bool isReady = false;
  _getPost() {
    ApiServices().getPostWithModel().then((value) {
      setState(() {
        postModelList = value!;
      });
    });
  }

  @override
  void initState() {
    _getPost();
    super.initState();
  }

  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: Colors.amber,
        selectedIndex: currentPageIndex,
        destinations: [
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'WithModel',
          ),
          NavigationDestination(
            icon: Badge(child: Icon(Icons.notifications_sharp)),
            label: 'WithoutModel',
          ),
        ],
      ),
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: currentPageIndex == 0? Text('List Data Api With Model') : Text('List Data Api Without Model') ,
        centerTitle: true,
      ),
      body:
          <Widget>[
            isReady == true
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
                  
                  itemCount: postModelList.length,
                  itemBuilder: (context, index) {
                    return Card(
                      margin: EdgeInsets.all(12),
                      child: ListTile(
                        leading: Text(postModelList[index].id.toString()),
                        title: Text(postModelList[index].title.toString()),
                        subtitle: Text(postModelList[index].body.toString()),
                      ),
                    );
                  },
                ),
            ScreenWithoutModel(),
          ][currentPageIndex],
    );
  }
}
