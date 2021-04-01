import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:nasa_api_flutter_project/Constants/Strings.dart';
import 'package:nasa_api_flutter_project/models/curiosityInfo.dart';
import 'package:nasa_api_flutter_project/models/opportunityInfo.dart';
import 'package:nasa_api_flutter_project/models/spiritInfo.dart';

class API_Manager {

  // Curiosity
  Future<CuriosityPhotos> getCuriosityPhotos() async {
    var client = http.Client();
    var curiosityPhotos = null;

    try {
      var response = await client.get(Uri.parse(Strings.curiosity_url));
      if (response.statusCode == 200) {
        var jsonString = response.body;
        var jsonMap = json.decode(jsonString);

        curiosityPhotos = CuriosityPhotos.fromJson(jsonMap);
      }
    } catch (Exception) {
      return curiosityPhotos;
    }

    return curiosityPhotos;
  }


  // Opportunity
  Future<OpportunityPhotos> getOpportunityPhotos() async {
    var client = http.Client();
    var opportunityPhotos = null;

    try {
      var response = await client.get(Uri.parse(Strings.opportunity_url));
      if (response.statusCode == 200) {
        var jsonString = response.body;
        var jsonMap = json.decode(jsonString);

        opportunityPhotos = OpportunityPhotos.fromJson(jsonMap);
      }
    } catch (Exception) {
      return opportunityPhotos;
    }

    return opportunityPhotos;
  }


  // Spirit
  Future<SpiritPhotos> getSpiritPhotos() async {
    var client = http.Client();
    var spiritPhotos = null;

    try {
      var response = await client.get(Uri.parse(Strings.spirit_url));
      if (response.statusCode == 200) {
        var jsonString = response.body;
        var jsonMap = json.decode(jsonString);

        spiritPhotos = SpiritPhotos.fromJson(jsonMap);
      }
    } catch (Exception) {
      return spiritPhotos;
    }

    return spiritPhotos;
  }
}
