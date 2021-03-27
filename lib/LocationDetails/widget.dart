import 'package:flutter/material.dart';
import 'package:skillboxdemoapp/LocationDetails/loader.dart';
import 'package:skillboxdemoapp/PersonDetails/widget.dart';
import 'package:skillboxdemoapp/PersonList/widget.dart';

class LocationDetailsPage extends StatefulWidget {
  LocationDetailsPage({Key key, this.url}) : super(key: key);

  final String url;

  @override
  _State createState() => _State(url: url);
}

class _State extends State<LocationDetailsPage> {
  _State({this.url}) : super();

  String url;
  LocationDetails location;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    var locationInfo = await loadLocation(url);
    setState(() {
      location = locationInfo;
    });
  }

  void navigateToDetails(int personId) {
    Navigator.push(context, FadeRoute(page: PersonDetailsPage(id: personId)));
  }

  void navigateToHome() {
    Navigator.of(context).pushReplacement(
        new MaterialPageRoute(builder: (BuildContext context) => MyHomePage()));
  }

  @override
  Widget build(BuildContext context) {
    if (location == null)
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
            location.name + " - " + location.type,
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
          child: ListView.builder(
            itemCount: location.persons.length,
            itemBuilder: (context, index) => GestureDetector(
              onTap: () => navigateToDetails(location.persons[index].id),
              child: Container(
                width: double.infinity,
                height: 70,
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
                margin: EdgeInsets.all(8),
                child: Row(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      margin: EdgeInsets.all(5),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.network(
                          location.persons[index].avatar,
                          width: double.infinity,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            location.persons[index].name,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            location.persons[index].status,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    }
  }
}
