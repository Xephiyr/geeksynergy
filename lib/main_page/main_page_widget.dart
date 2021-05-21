import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geek/data/datamodel.dart';
import 'package:http/http.dart' as http;
import 'package:loading_animations/loading_animations.dart';

import '../flutter_flow/flutter_flow_theme.dart';

class MainPageWidget extends StatefulWidget {
  MainPageWidget({Key key}) : super(key: key);

  @override
  _MainPageWidgetState createState() => _MainPageWidgetState();
}

class _MainPageWidgetState extends State<MainPageWidget> {
  Future<List<Objects>> _futureObject;

  @override
  void initState() {
    super.initState();
    _futureObject = fetchObjects();
  }

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.primaryColor,
        automaticallyImplyLeading: true,
        actions: [
          IconButton(
            onPressed: () async {
              showModalBottomSheet(
                  context: context,
                  builder: (BuildContext bc) {
                    return Container(
                      child: new Wrap(
                        children: <Widget>[
                          new ListTile(
                            title: new Text(
                                'Company Info: Geeksynergy Technologies Pvt Ltd'),
                            subtitle: new Text(
                                'Address: Sanjayanagar, Bengaluru-56\nPhone: XXXXXXXXX09\nEmail: XXXXXX@gmail.com'),
                            isThreeLine: true,
                          ),
                        ],
                      ),
                    );
                  });
            },
            icon: Icon(
              Icons.info_outline,
              color: Colors.black,
              size: 30,
            ),
            iconSize: 30,
          )
        ],
        centerTitle: true,
        elevation: 4,
      ),
      body: Container(
        width: MediaQuery.of(context).copyWith().size.width,
        height: MediaQuery.of(context).copyWith().size.height,
        child: (_futureObject == null)
            ? LoadingFadingLine.circle(
                size: 50,
                backgroundColor: Colors.blue,
              )
            : FutureBuilder<List<Objects>>(
                future: _futureObject,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Card(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.2,
                                    height: 100.0,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: NetworkImage(
                                              snapshot.data[index].posterUrl,
                                            ),
                                            fit: BoxFit.cover)),
                                  ),
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.8 -
                                          30,
                                  child: ListTile(
                                    title: Text(snapshot.data[index].title),
                                    subtitle: Text("Genre:" +
                                        snapshot.data[index].genre +
                                        "\nDirector:" +
                                        snapshot.data[index].director +
                                        "\nStarring:" +
                                        snapshot.data[index].stars +
                                        "\nLanguage:" +
                                        snapshot.data[index].language +
                                        "\nViews:" +
                                        snapshot.data[index].views.toString()),
                                    isThreeLine: true,
                                  ),
                                ),
                              ],
                            ),
                          );
                        });
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }

                  // By default, show a loading spinner.
                  return LoadingFadingLine.circle(
                    size: 50,
                    backgroundColor: Colors.blue,
                  );
                },
              ),
      ),
    );
  }
}

/*
Future<List<Objects>> _getData() async {}
Widget createListView(BuildContext context, AsyncSnapshot snapshot) {
  List<Objects> values = snapshot.data;

  return new ListView.builder(
      itemCount: values.length,
      itemBuilder: (context, index) {
        return new Column(
          children: <Widget>[
            new ListTile(),
            new Divider(
              height: 2.0,
            ),
          ],
        );
      });
}
*/

Future<List<Objects>> fetchObjects() async {
  print('In the FUTURE1111111111');
  List<Objects> objj = List<Objects>();
  final response = await http.post(
    Uri.https('hoblist.com', 'movieList'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      "category": "movies",
      "language": "kannada",
      "genre": "all",
      "sort": "voting"
    }),
  );
  print('len =' + response.contentLength.toString());
  if (response.statusCode == 200) {
    // If the server did return a 200 response,
    // then parse the JSON.
    print("INSIDE HERE");
    print("RESPONSE");
    //debugPrint("" + response.body);
    for (int i = 0; i < jsonDecode(response.body)['result'].length; i++) {
      var jsonfile = jsonDecode(response.body)['result'][i];
      //print("" + jsonfile.toString());
      print("Adding here");
      objj.add(Objects.fromJson(jsonfile));
    }

    for (int i = 0; i < jsonDecode(response.body)['result'].length; i++) {
      print("parse +" + i.toString());
      objj[i].printer();
    }
    return objj;
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to create objects.');
  }
}
