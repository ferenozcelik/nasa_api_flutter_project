// newsModel --> OpportunityPhotos
import "package:flutter/material.dart";
import 'package:nasa_api_flutter_project/models/opportunityInfo.dart';
import 'package:nasa_api_flutter_project/services/api_manager.dart';

class OpportunityPage extends StatefulWidget {
  @override
  _OpportunityPageState createState() => _OpportunityPageState();
}

class _OpportunityPageState extends State<OpportunityPage> {
  Future<OpportunityPhotos> _opportunityPhotos;

  @override
  void initState() {
    _opportunityPhotos = API_Manager().getOpportunityPhotos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              icon: Icon(Icons.filter_alt, color: Colors.white, size: 35),
              onPressed: () {
                AlertDialog(
                  title: Text("Image Details"),
                  backgroundColor: Colors.red,
                );
              })
        ],
        title: Text("Opportunity Photos"),
        backgroundColor: Colors.green,
        centerTitle: true,
      ),
      body: Container(
        child: GestureDetector(
          child: Hero(
              tag: 'imageHero',
              child: FutureBuilder<OpportunityPhotos>(
                future: _opportunityPhotos,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        itemCount: snapshot.data.photos.length,
                        itemBuilder: (context, index) {
                          var photo = snapshot.data.photos[index];
                          return Container(
                            height: 200,
                            child: Row(
                              children: <Widget>[
                                Card(
                                  clipBehavior: Clip.antiAlias,
                                  shape: ContinuousRectangleBorder(
                                    borderRadius: BorderRadius.circular(24),
                                  ),
                                  child: AspectRatio(
                                      aspectRatio: 2,
                                      child: Image.network(
                                        photo.imgSrc,
                                        fit: BoxFit.cover,
                                      )),
                                ),
                                Flexible(
                                  child: Column(
                                    children: <Widget>[
                                      Text(
                                        photo.camera.name.toString(),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(
                                        photo.rover.name.toString(),
                                        overflow: TextOverflow.ellipsis,
                                      )
                                    ],
                                  ),
                                ),
                                //Image.network(photo.imgSrc),
                              ],
                            ),
                          );
                        });
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                },
              )
              ),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (index){
                  return DetailScreen(opportunityPhotos: _opportunityPhotos,);
                }));
              },
        ),
      ),
    );
  }
}

class DetailScreen extends StatelessWidget {

  final Future opportunityPhotos;
  DetailScreen({Key key, @required this.opportunityPhotos}):super(key: key);

  @override
  Widget build(BuildContext context) {
    var current_index = 0;
    return Scaffold(
      body: GestureDetector(
        child: Center(
          child: Hero(
            tag: 'imageHero',
            
            
            child: FutureBuilder<OpportunityPhotos>(
              future: opportunityPhotos,
              builder: (context, snapshot){
                if(snapshot.hasData){
                  return ListView.builder(
                    itemCount: 1,
                    itemBuilder: (context, index){
                      
                      var photo = snapshot.data.photos[index];
                      return Center(
                        child: Container(
                          height: 300,
                          child: Row(
                            children: <Widget>[
                              Card(
                                clipBehavior: Clip.antiAlias,
                                shape: ContinuousRectangleBorder(
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                child: AspectRatio(
                                  aspectRatio: 2,
                                  child: Image.network(
                                    photo.imgSrc,
                                    fit: BoxFit.cover,
                                  )
                                ),
                              ),
                              Flexible(
                                    child: Column(
                                      children: <Widget>[
                                        Text(
                                          "Cam Name: "+
                                          photo.camera.name.toString(),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Text(
                                          "\nRover Name: "+
                                          photo.rover.name.toString(),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Text(
                                          "\nEarth Date: "+
                                          photo.earthDate.toString(),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Text(
                                          "\nStatus: "+
                                          photo.rover.status.toString(),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Text(
                                          "\nLaunch Date: "+
                                          photo.rover.launchDate.toString(),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Text(
                                          "\nLanding Date: "+
                                          photo.rover.landingDate.toString(),
                                          overflow: TextOverflow.ellipsis,
                                        )
                                      ],
                                    ),
                                  ),
                            ],
                          )
                        ),
                      );
                    },
                  );
                }
              },
            )
          ),
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}