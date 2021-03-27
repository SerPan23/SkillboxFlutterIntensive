import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:skillboxdemoapp/PersonDetails/loader.dart';

class LocationDetails {
  int id;
  String name;
  String type;

  List<PersonDetails> persons;
}

Future<PersonDetails> loadPerson(String url) async {
  var response = await http.get(Uri.parse(url));
  PersonDetails person;
  if (response.statusCode == 200) {
    var item = convert.jsonDecode(response.body);
    person = PersonDetails();
    person.id = item["id"];
    person.name = item["name"];
    person.avatar = item["image"];
    person.locationName = item["location"]["name"];
    person.locationUrl = item["location"]["url"];
    person.status = item["status"];
    person.created = item["created"];

    person.gender = item["gender"];
    person.originName = item["origin"]["name"];
    person.originUrl = item["origin"]["url"];
    person.species = item["species"];
    //  person.episodes = item["episode"];
  }
  return person;
}

Future<LocationDetails> loadLocation(String url) async {
  if (url != "") {
    var response = await http.get(Uri.parse(url));
    LocationDetails location;
    if (response.statusCode == 200) {
      var item = convert.jsonDecode(response.body);
      location = LocationDetails();
      location.id = item["id"];
      location.name = item["name"];
      location.type = item["type"];
      List<dynamic> personsUrl = item["residents"];
      List<PersonDetails> persons = [];
      if (personsUrl != null)
        for (String personUrl in personsUrl) {
          PersonDetails person;
          person = PersonDetails();
          person = await loadPerson(personUrl);
          if (person != null) persons.add(person);
        }
      location.persons = persons;
    }
    return location;
  }
}
