import 'package:demo_flutter/screens/examples/search/search_bar_example.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const MarginBody = EdgeInsets.fromLTRB(10, 20, 10, 10);
const FontDefault = 15.0;

class NavigatorDrawerFilter extends StatefulWidget {
  String keySearch;
  NavigatorDrawerFilter({Key key, this.keySearch}) : super(key: key);

  @override
  _NavigatorDrawerFilterState createState() => _NavigatorDrawerFilterState();
}

class _NavigatorDrawerFilterState extends State<NavigatorDrawerFilter> {
  final FocusNode searchFocusNode = new FocusNode();
  TextEditingController searchController;
  List<FilterItem> data = [];
  final globalKey = GlobalKey<ScaffoldState>();
  List<GroupFilterItem> filters = [
    GroupFilterItem(idGroup: '1', title: 'Thương hiệu', filters: [
      FilterItem(id: '1', title: 'Carina Rina'),
      FilterItem(id: '2', title: 'Bioline'),
      FilterItem(id: '3', title: 'WIINILL')
    ]),
    GroupFilterItem(idGroup: '2', title: 'Ngành hàng', filters: [
      FilterItem(id: '4', title: 'Chăm sóc tóc'),
    ]),
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    searchController = new TextEditingController(text: widget.keySearch);
    searchFocusNode.addListener(onClickSearch);
  }

  void onClickSearch() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => SearchBarExample(),
      ),
    );
  }

  void _clearFilter() {
    setState(() => {data = []});
  }

  void _selectFilter(FilterItem item) {
    if (data.where((x) => x.id == item.id).toList().isEmpty) {
      data.add(item);
    } else {
      data.removeWhere((x) => x.id == item.id);
    }
    setState(() => {});
  }

  Widget _buildItemFilter(FilterItem item) {
    if (data.where((x) => x.id == item.id).toList().isNotEmpty) {
      return Container(
        margin: const EdgeInsets.all(1),
        child: FlatButton(
          onPressed: () {
            _selectFilter(item);
          },
          child: Text(
            item.title,
            style: TextStyle(fontSize: 12, color: Colors.white),
          ),
          color: Colors.purpleAccent,
        ),
      );
    } else {
      return Container(
        margin: const EdgeInsets.all(1),
        child: FlatButton(
          onPressed: () {
            _selectFilter(item);
          },
          child: Text(
            item.title,
            style: TextStyle(fontSize: 12),
          ),
          color: Colors.black12,
        ),
      );
    }
  }

  List<Widget> _buildFilter(BuildContext context) {
    List<Widget> content = [];
    //add header
    content.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[Icon(Icons.close), Text("Đóng")],
                )),
            GestureDetector(
              onTap: () {
                _clearFilter();
              },
              child: Text(
                "Xóa chọn",
                style: TextStyle(color: Colors.blue),
              ),
            )
          ],
        ),
      ),
    );

    filters.forEach((item) {
      List<Widget> child = [];
      item.filters.forEach((filter) {
        child.add(_buildItemFilter(filter));
      });
      content.add(Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              item.title,
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.purple),
              // textAlign: TextAlign.left,
            ),
            Wrap(
              children: child,
            )
          ],
        ),
      ));
    });
    return content;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: globalKey,
      endDrawer: SizedBox(
          width: MediaQuery.of(context).size.width * 0.75,
          child: Drawer(
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 40, horizontal: 5),
              child: Column(
                children: _buildFilter(context),
              ),
            ),
          )),
      body: Column(
        children: <Widget>[
          SizedBox(height: 50),
          Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Colors.purple,
                  border: Border.all(
                    width: 1,
                    color: Colors.black12,
                  )),
              child: Row(
                children: <Widget>[
                  Expanded(
                      child: GestureDetector(
                          child: Container(
                            width: 50,
                            child: Icon(Icons.arrow_back, color: Colors.white),
                          ),
                          onTap: () {
                            Navigator.pop(context);
                          })),
                  Expanded(
                      flex: 6,
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                        child: TextField(
                          focusNode: searchFocusNode,
                          readOnly: true,
                          controller: searchController,
                          style: TextStyle(
                              color: Colors.black, fontSize: FontDefault),
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding: const EdgeInsets.all(15),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4)),
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4)),
                              )),
                        ),
                      )),
                  Expanded(
                      child: GestureDetector(
                          child: Container(
                            width: 50,
                            child:
                                Icon(Icons.card_giftcard, color: Colors.white),
                          ),
                          onTap: () {
                            Navigator.pop(context);
                          }))
                ],
              )),
          Expanded(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              GestureDetector(
                  onTap: () {
                    globalKey.currentState.openEndDrawer();
                  },
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.filter_list),
                      Text(
                        'Lọc (${data.length})',
                        style: TextStyle(color: Colors.blue),
                      )
                    ],
                  ))
            ],
          )),
        ],
      ),
    );
  }
}

class GroupFilterItem {
  GroupFilterItem({this.idGroup, this.index, this.title, this.filters});
  final int index;
  final String idGroup;
  final String title;
  final List<FilterItem> filters;
}

class FilterItem {
  FilterItem({this.id, this.title});
  final String id;
  final String title;
}
