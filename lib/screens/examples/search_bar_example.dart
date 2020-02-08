import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'navigator_drawer_filter/navigator_drawer_filter.dart';

class SearchBarExample extends StatefulWidget {
  SearchBarExample({Key key}) : super(key: key);

  @override
  _SearchBarExampleState createState() => _SearchBarExampleState();
}

class _SearchBarExampleState extends State<SearchBarExample> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _controller = new TextEditingController();
  final FocusNode searchFocusNode = new FocusNode();
  final TextEditingController searchController = new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: const Text('Demo Page Search'),
        ),
        body: SingleChildScrollView(
            child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        width: 1,
                        color: Colors.black12,
                      )),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                          flex: 1,
                          child: GestureDetector(
                              child:
                                  Icon(Icons.arrow_back, color: Colors.black),
                              onTap: () {
                                Navigator.pop(context);
                              })),
                      Expanded(
                          flex: 9,
                          child: TextField(
                            controller: searchController,
                            focusNode: searchFocusNode,
                            decoration: InputDecoration(
                              suffixIcon: (searchFocusNode != null &&
                                      searchFocusNode.hasFocus)
                                  ? Container(
                                      width: 50,
                                      child: FlatButton(
                                          child: Icon(Icons.cancel,
                                              color: Colors.black12),
                                          onPressed: () {
                                            searchFocusNode?.unfocus();
                                            searchController.clear();
                                          }),
                                    )
                                  : null,
                              hintText: "Tìm kiếm",
                              hintStyle: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.normal,
                                color: Color.fromRGBO(117, 117, 117, 1),
                                height: 1.2,
                              ),
                              border: InputBorder.none,
                            ),
                            onSubmitted: (String value) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => NavigatorDrawerFilter(
                                    keySearch: value,
                                  ),
                                ),
                              );
                            },
                          ))
                    ],
                  )),
              Container(
                margin: EdgeInsets.all(5),
                child: Column(
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'TỪ KHÓA HOT',
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.purple),
                            // textAlign: TextAlign.left,
                          ),
                          Wrap(children: _buildTopSearch())
                        ],
                      ),
                    ),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    'Lịch sử tìm kiếm',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                    // textAlign: TextAlign.left,
                                  ),
                                  GestureDetector(
                                    child: Text(
                                      'Xóa',
                                      style:
                                          TextStyle(color: Colors.blueAccent),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(height: 5),

                              // ListView.builder(
                              //     itemCount: 1,
                              //     itemBuilder: (BuildContext context, int i) {
                              //       return Text('asdasdsa');
                              //     }),
                            ] +
                            _buildHistory(),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        )));
  }

  _buildTopSearch() {
    List<Widget> out = [];
    final List<String> _top = <String>[
      'a',
      'b',
      'Chăm sóc tóc',
      'C',
    ];
    _top.forEach((item) {
      out.add(Container(
        margin: const EdgeInsets.all(1),
        child: FlatButton(
          padding: EdgeInsets.all(0),
          onPressed: () {},
          child: Text(
            item,
            style: TextStyle(fontSize: 12, color: Colors.black),
          ),
          color: Colors.black12,
        ),
      ));
    });
    return out;
  }

  _buildHistory() {
    List<Widget> out = [];
    final List<String> _history = <String>[
      'Chăm sóc tóc và da đầu',
      'Chăm sóc tóc',
      'Chăm sóc tóc và da',
      'Dưỡng tóc'
    ];
    _history.forEach((item) {
      out.add(GestureDetector(
        child: Padding(
          padding: EdgeInsets.all(5),
          child: Text(item),
        ),
      ));
    });
    return out;
  }
}
