import 'package:flutter/material.dart';
import 'package:skillboxdemoapp/Persondetails/widget.dart';
import 'package:skillboxdemoapp/Personlist/loader.dart';

class FadeRoute extends PageRouteBuilder {
  final Widget page;
  FadeRoute({this.page})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Person> persons = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    var loadedPersons = await loadPersons();
    setState(() {
      this.persons = loadedPersons;
    });
  }

  void navigateToDetails(int personId) {
    Navigator.push(context, FadeRoute(page: PersonDetailsPage(id: personId)));
  }

  @override
  Widget build(BuildContext context) {
    if (persons.length <= 0)
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
    else
      return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: ListView.builder(
            itemCount: persons.length,
            itemBuilder: (context, index) => GestureDetector(
              onTap: () => navigateToDetails(persons[index].id),
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
                          persons[index].avatar,
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
                            persons[index].name,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            persons[index].status,
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
          // child: ListView.builder(
          //   itemCount: persons.length,
          //   itemBuilder: (context, index) => Row(
          //     children: [
          //       Text(persons[index].id.toString()),
          //       IconButton(
          //         icon: Icon(Icons.info),
          //         onPressed: () => navigateToDetails(persons[index].id),
          //       ),
          //       Padding(
          //         padding: EdgeInsets.all(8),
          //         child: Text(
          //           persons[index].name,
          //           style: TextStyle(
          //             fontSize: 25,
          //           ),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
        ),
      );
  }
}
