import 'package:demo_flutter/screens/examples/search/search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchBoxStatic extends StatefulWidget {
  SearchBoxStatic({Key key, @required this.value, @required this.isPageResult})
      : super(key: key);
  String value;
  bool isPageResult;
  @override
  _SearchBoxStaticState createState() => _SearchBoxStaticState();
}

class _SearchBoxStaticState extends State<SearchBoxStatic> {
  @override
  void initState() {
    super.initState();
  }

  void onClickSearch() {
    if (widget.isPageResult) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => SearchPage(),
        ),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SearchPage(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.width * 0.18,
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
                    child: GestureDetector(
                      onTap: onClickSearch,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                          color: Colors.white,
                        ),
                        child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              widget.value,
                              style: TextStyle(
                                  color: Colors.black, fontSize: FontDefault),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            )),
                      ),
                    ))),
            Expanded(
                child: GestureDetector(
                    child: Container(
                      width: 50,
                      child: Icon(Icons.shopping_cart, color: Colors.white),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    }))
          ],
        ));
  }
}
