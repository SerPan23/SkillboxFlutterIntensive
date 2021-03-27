import 'package:flutter/material.dart';
import 'package:skillboxdemoapp/LocationDetails/widget.dart';
import 'package:skillboxdemoapp/PersonList/widget.dart';
import 'package:skillboxdemoapp/PersonDetails/loader.dart';

class PersonDetailsPage extends StatefulWidget {
  PersonDetailsPage({Key key, this.id}) : super(key: key);

  final int id;

  @override
  _State createState() => _State(id: id);
}

class _State extends State<PersonDetailsPage> {
  _State({this.id}) : super();

  int id;
  PersonDetails person;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    var personInfo = await loadPerson(id);
    setState(() {
      person = personInfo;
    });
  }

  void navigateToDetails(String url) {
    Navigator.push(context, FadeRoute(page: LocationDetailsPage(url: url)));
  }

  void navigateToHome() {
    Navigator.of(context).pushReplacement(
        new MaterialPageRoute(builder: (BuildContext context) => MyHomePage()));
  }

  @override
  Widget build(BuildContext context) {
    if (person == null)
      return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Center(
              child: Text(
            "Please, wait...",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          )),
        ),
      );
    else {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            person.name + " (" + person.status + ")",
            style: TextStyle(color: Colors.black, fontSize: 16),
          ),
          elevation: 0,
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
          actions: [
            IconButton(
              icon: Icon(Icons.home),
              onPressed: () => navigateToHome(),
            ),
          ],
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Image.network(
                  person.avatar,
                  width: double.infinity,
                ),
                Container(
                  margin: EdgeInsets.all(5),
                  width: double.infinity,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Color(0xFFfafafa),
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 6,
                        color: Color.fromRGBO(46, 46, 46, 0.5),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text("Gender: " + person.gender),
                      Text("Species: " + person.species),
                    ],
                  ),
                ),
                SizedBox(width: double.infinity, height: 10),
                Container(
                  margin: EdgeInsets.all(5),
                  padding: EdgeInsets.all(8),
                  width: double.infinity,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Color(0xFFfafafa),
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 6,
                        color: Color.fromRGBO(46, 46, 46, 0.5),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Origin:",
                          style: TextStyle(fontWeight: FontWeight.w500)),
                      if (person.originName != "unknown")
                        ElevatedButton(
                          onPressed: () => navigateToDetails(person.originUrl),
                          child: Text(person.originName),
                          style: ButtonStyle(),
                        ),
                      if (person.originName == "unknown")
                        Text(person.originName)
                    ],
                  ),
                ),
                SizedBox(width: double.infinity, height: 10),
                Container(
                  margin: EdgeInsets.all(5),
                  padding: EdgeInsets.all(8),
                  width: double.infinity,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Color(0xFFfafafa),
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 6,
                        color: Color.fromRGBO(46, 46, 46, 0.5),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Location:",
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      if (person.locationName != "unknown")
                        ElevatedButton(
                          onPressed: () =>
                              navigateToDetails(person.locationUrl),
                          child: Text(person.locationName),
                          style: ButtonStyle(),
                        ),
                      if (person.locationName == "unknown")
                        Text(person.originName)
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
  }
}
