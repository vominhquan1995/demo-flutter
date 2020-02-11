import 'package:demo_flutter/screens/examples/search/search.dart';
import 'package:demo_flutter/screens/examples/search/widget/search_box_static.dart';
import 'package:demo_flutter/screens/examples/search_results/service/service_search_results.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/search_results_bloc.dart';

const MarginBody = EdgeInsets.fromLTRB(10, 20, 10, 10);
const FontDefault = 15.0;

class SearchResults extends StatefulWidget {
  final String keySearch;
  SearchResults({Key key, this.keySearch}) : super(key: key);

  @override
  _SearchResultsState createState() => _SearchResultsState();
}

class _SearchResultsState extends State<SearchResults> {
  SearchResultsBloc bloc =
      new SearchResultsBloc(service: SearchResultsService());
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
    bloc.add(SearchData());
  }

  void onClickSearch() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => SearchPage(),
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
              child: Column(
            children: <Widget>[
              AppBar(
                elevation: 0.0, //shadow
                titleSpacing: 0,
                actions: <Widget>[Container()],
                backgroundColor: Colors.white,
                automaticallyImplyLeading: false,
                title: Container(
                  margin: EdgeInsets.symmetric(horizontal: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Icon(
                                Icons.close,
                                color: Colors.black,
                              ),
                              Text(
                                "Đóng",
                                style: TextStyle(
                                    color: Colors.black, fontSize: FontDefault),
                              )
                            ],
                          )),
                      GestureDetector(
                        onTap: () {
                          _clearFilter();
                        },
                        child: Text(
                          "Xóa chọn",
                          style: TextStyle(
                              color: Colors.blue, fontSize: FontDefault),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 5),
                child: Column(
                  children: _buildFilter(context),
                ),
              ),
            ],
          ))),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            backgroundColor: Colors.white,
            title: SearchBoxStatic(value: widget.keySearch, isPageResult: true),
            pinned: true,
            automaticallyImplyLeading: false,
            titleSpacing: 0,
            actions: <Widget>[new Container()],
          ),
          SliverPersistentHeader(
            pinned: true,
            delegate: HeaderFilterCustom(numberFilter: data.length),
          ),
          BlocBuilder(
              bloc: bloc,
              builder: (BuildContext context, SearchResultsState state) {
                if (state is LoadedData) {
                  return SliverFillRemaining(child: SearchNotFound());
                }
                return SliverFillRemaining(
                    child: Center(
                  child: CircularProgressIndicator(),
                ));
              }),
        ],
      ),
    );
  }
}

class SearchNotFound extends StatelessWidget {
  const SearchNotFound({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
                    horizontal: MediaQuery.of(context).size.width * 0.1),
                child: Text(
                  'Không tìm thấy sản phẩm \n phù hợp với lựa chọn của bạn',
                  textAlign: TextAlign.center,
                  style:
                      TextStyle(color: Colors.black54, fontSize: FontDefault),
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
                        builder: (context) => SearchPage(),
                      ),
                    );
                  },
                  child: Text(
                    'Tìm kiếm lại',
                    style:
                        TextStyle(color: Colors.white, fontSize: FontDefault),
                  ),
                  color: Colors.purple),
            )
          ],
        ));
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

class HeaderFilterCustom extends SliverPersistentHeaderDelegate {
  final int numberFilter;
  HeaderFilterCustom({this.numberFilter});
  @override
  Widget build(
          BuildContext context, double shrinkOffset, bool overlapsContent) =>
      Container(
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                width: 1,
                color: Colors.black12,
              )),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
            child: GestureDetector(
              onTap: () {
                Scaffold.of(context).openEndDrawer();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.sort,
                    color: Colors.black,
                  ),
                  Text('Chọn lọc', style: TextStyle(color: Colors.black)),
                  Text('(${numberFilter})',
                      style: TextStyle(color: Colors.blue))
                ],
              ),
            ),
          ));

  @override
  double get maxExtent => 50;

  @override
  double get minExtent => 50;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
