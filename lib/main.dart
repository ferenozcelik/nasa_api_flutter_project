import 'package:flutter/material.dart';
import 'package:nasa_api_flutter_project/pages/curiosity_page.dart';
import 'package:nasa_api_flutter_project/pages/spirit_page.dart';
import 'package:nasa_api_flutter_project/pages/opportunity_page.dart';

// çalıştırmak için terminal'e aşağıdaki komut yazılacak
// flutter run -d chrome --web-renderer html 

void main() {
  runApp(MyFlutterApp());
}

class MyFlutterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
     home: DefaultTabController(  
        length: 3,  
        child: Scaffold(  
          appBar: AppBar(  
            title: Text('Nasa API'),
            centerTitle: true,  
            bottom: TabBar(  
              tabs: [  
                Tab(icon: Icon(Icons.camera_alt), text: "Curiosity",),  
                Tab(icon: Icon(Icons.camera_alt_outlined), text: "Opportunity") ,
                Tab(icon: Icon(Icons.camera_enhance), text: "Spirit"),   
              ],  
            ),  
          ),  
          body: TabBarView(  
            children: [  
              CuriosityPage(),  
              OpportunityPage(),
              SpiritPage()  
            ],  
          ),  
        ),  
      ), 
    );
  }
}
