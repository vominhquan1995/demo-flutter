import 'dart:developer';

import 'package:demo_flutter/screens/examples/navigator_drawer_filter/navigator_drawer_filter.dart';
import 'package:demo_flutter/screens/examples/search/service/service_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

import 'bloc/search_bloc_bloc.dart';
import 'model/search_model.dart';

const String KEY_SEARCH = 'history_seach';
const MarginBody = EdgeInsets.fromLTRB(10, 20, 10, 10);
const FontDefault = 15.0;

class SearchBarExample extends StatefulWidget {
  SearchBarExample({Key key}) : super(key: key);

  @override
  _SearchBarExampleState createState() => _SearchBarExampleState();
}

class _SearchBarExampleState extends State<SearchBarExample> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final FocusNode searchFocusNode = new FocusNode();
  final TextEditingController searchController = new TextEditingController();
  SharedPreferences prefs;
  List<String> history;
  final SearchService service = SearchService();
  final SearchBloc bloc = SearchBloc(service: SearchService());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bloc.add(InitData());
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  redirectPageResult(String key) {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    // _updateHistory(key);
    Future.delayed(const Duration(milliseconds: 500), () {
      Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                NavigatorDrawerFilter(
              keySearch: key,
            ),
            transitionsBuilder: (BuildContext context,
                Animation<double> animation,
                Animation<double> secondaryAnimation,
                Widget child) {
              return new SlideTransition(
                position: new Tween<Offset>(
                  begin: const Offset(1.0, 0.0),
                  end: Offset.zero,
                ).animate(animation),
                child: child,
              );
            },
          ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: CustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: SizedBox(height: 50),
          ),
          SliverToBoxAdapter(
            child: Container(
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
                            child: Icon(Icons.arrow_back, color: Colors.black),
                            onTap: () {
                              Navigator.pop(context);
                            })),
                    Expanded(
                        flex: 9,
                        child: TextField(
                          autofocus: true,
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
                                          FocusScope.of(context).unfocus();
                                          //if use searchController.clear() will error
                                          WidgetsBinding.instance
                                              .addPostFrameCallback((_) =>
                                                  searchController.clear());
                                        }),
                                  )
                                : null,
                            hintText: "Tìm kiếm",
                            hintStyle: TextStyle(
                              fontSize: FontDefault,
                              fontWeight: FontWeight.normal,
                              color: Color.fromRGBO(117, 117, 117, 1),
                              height: 1.2,
                            ),
                            border: InputBorder.none,
                          ),
                          onSubmitted: (String key) => redirectPageResult(key),
                        ))
                  ],
                )),
          ),
          BlocBuilder(
              bloc: bloc,
              builder: (BuildContext context, SearchBlocState state) {
                print(state);
                if (state is LoadedData) {
                  return SliverToBoxAdapter(
                      child: Column(
                    children: <Widget>[
                      Container(
                        margin: MarginBody,
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            HeaderHotKey(),
                            Wrap(children: _buildTopSearch(state.topKey))
                          ],
                        ),
                      ),
                      _buildHistory(state.history),
                    ],
                  ));
                }
                //loading
                return SliverToBoxAdapter(
                    child: Column(
                  children: <Widget>[
                    Container(
                      margin: MarginBody,
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          HeaderHotKey(),
                          Wrap(children: [KeyHotShimmer()])
                        ],
                      ),
                    ),
                    Container(
                      margin: MarginBody,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          HeaderHistory(),
                          ItemShimerHistory(
                            numberLine: 4,
                          )
                        ],
                      ),
                    )
                  ],
                ));
              })
        ],
      ),
    );

    ;
  }

  _buildTopSearch(List<KeyHot> topKey) {
    List<Widget> out = [];
    topKey.forEach((item) {
      out.add(Container(
        margin: const EdgeInsets.only(right: 5),
        child: FlatButton(
          onPressed: () {
            redirectPageResult(item.name);
          },
          child: Text(
            item.name,
            style: TextStyle(fontSize: FontDefault * 0.8, color: Colors.black),
          ),
          color: Colors.black12,
        ),
      ));
    });
    return out;
  }

  _buildHistory(List<String> _history) {
    List<Widget> list = [];
    //header
    list.add(HeaderHistory(onClick: _clearHistory));
    _history.forEach((item) {
      list.add(GestureDetector(
        onTap: () {
          redirectPageResult(item);
        },
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 5),
          child: Text(
            item,
            style: TextStyle(fontSize: FontDefault),
          ),
        ),
      ));
    });
    return _history.isEmpty
        ? SizedBox()
        : Container(
            margin: MarginBody,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: list,
            ),
          );
  }

  Future<bool> _updateHistory(String item) {
    service.updateHistory(item);
    bloc.add(InitData());
  }

  Future<bool> _clearHistory() {
    service.clearHistory();
    bloc.add(InitData());
  }
}

class HeaderHotKey extends StatelessWidget {
  const HeaderHotKey({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Text(
      'TỪ KHÓA HOT',
      style: TextStyle(
          fontSize: FontDefault,
          fontWeight: FontWeight.bold,
          color: Colors.purple),
    );
  }
}

class HeaderHistory extends StatelessWidget {
  const HeaderHistory({Key key, this.onClick}) : super(key: key);
  final Function onClick;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          'Lịch sử tìm kiếm',
          style: TextStyle(
              fontSize: FontDefault,
              fontWeight: FontWeight.bold,
              color: Colors.black),
          // textAlign: TextAlign.left,
        ),
        GestureDetector(
            onTap: onClick,
            child: Container(
              width: 50,
              child: Text(
                'Xóa',
                style: TextStyle(
                    fontSize: FontDefault * 1.1, color: Colors.blueAccent),
                textAlign: TextAlign.right,
              ),
            ))
      ],
    );
  }
}

class KeyHotShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
        Container(
          margin: const EdgeInsets.only(right: 5),
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300],
            highlightColor: Colors.grey[100],
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 40,
              color: Colors.white,
            ),
          ),
        )
      ]),
    );
  }
}

class ItemShimerHistory extends StatelessWidget {
  const ItemShimerHistory({Key key, this.numberLine}) : super(key: key);
  final int numberLine;
  @override
  Widget build(BuildContext context) {
    List<Widget> items = [];
    for (var i = 0; i < numberLine; i++) {
      items.add(Padding(
        padding: EdgeInsets.symmetric(vertical: 5),
        child: Shimmer.fromColors(
          baseColor: Colors.grey[300],
          highlightColor: Colors.grey[100],
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 13,
            color: Colors.white,
          ),
        ),
      ));
    }
    return Column(children: items);
  }
}
