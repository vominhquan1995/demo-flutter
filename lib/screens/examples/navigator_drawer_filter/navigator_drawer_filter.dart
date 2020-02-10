import 'package:demo_flutter/screens/examples/search/search_bar_example.dart';
import 'package:demo_flutter/screens/examples/search/widget/search_box_static.dart';
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
      body: CustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(child: SizedBox(height: 25)),
          SliverToBoxAdapter(
              child:
                  SearchBoxStatic(value: widget.keySearch, isPageResult: true)),
          SliverToBoxAdapter(
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  color: Colors.white,
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 15),
                      Image.asset('assets/search-empty.png'),
                      SizedBox(height: 15),
                      Text(
                        'Rất tiếc !',
                        style: TextStyle(
                            fontSize: FontDefault * 2,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 15),
                      Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal:
                                  MediaQuery.of(context).size.width * 0.1),
                          child: Text(
                            'Không tìm thấy sản phẩm \n phù hợp với lựa chọn của bạn',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.black54, fontSize: FontDefault),
                          )),
                      SizedBox(height: 15),
                      Container(
                        margin: EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width * 0.6,
                        height: 50,
                        child: FlatButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SearchBarExample(),
                                ),
                              );
                            },
                            child: Text(
                              'Tìm kiếm lại',
                              style: TextStyle(
                                  color: Colors.white, fontSize: FontDefault),
                            ),
                            color: Colors.purple),
                      )
                    ],
                  ))),
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
