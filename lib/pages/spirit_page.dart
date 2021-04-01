// newsModel --> OpportunityPhotos
import "package:flutter/material.dart";
import 'package:nasa_api_flutter_project/models/spiritInfo.dart';
import 'package:nasa_api_flutter_project/services/api_manager.dart';

class SpiritPage extends StatefulWidget {
  @override
  _SpiritPageState createState() => _SpiritPageState();
}

class _SpiritPageState extends State<SpiritPage> {
  Future<SpiritPhotos> _spiritPhotos;

  @override
  void initState() {
    _spiritPhotos = API_Manager().getSpiritPhotos();
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
        title: Text("Spirit Photos"),
        backgroundColor: Colors.green,
        centerTitle: true,
      ),
      body: Container(
        child: GestureDetector(
          child: Hero(
              tag: 'imageHero',
              child: FutureBuilder<SpiritPhotos>(
                future: _spiritPhotos,
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
                  return DetailScreen(spiritPhotos: _spiritPhotos,);
                }));
              },
        ),
      ),
    );
  }
}




class DetailScreen extends StatelessWidget {

  final Future spiritPhotos;
  DetailScreen({Key key, @required this.spiritPhotos}):super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        child: Center(
          child: Hero(
            tag: 'imageHero',
            
            
            child: FutureBuilder<SpiritPhotos>(
              future: spiritPhotos,
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