import 'package:demo_flutter/screens/examples/search/model/search_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String KEY_SEARCH = 'history_seach';

class SearchService {
  SearchService();
  Future<List<String>> getHistory() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String> history = prefs.getStringList(KEY_SEARCH);
      history = history == null ? [] : history.take(10).toList();
      return history;
    } catch (e) {
      return [];
    }
  }

  Future<List<KeyHot>> getHotKey() async {
    try {
      return [
        KeyHot(key: 'key?=cham-soc-toc', name: 'Chăm sóc tóc'),
        KeyHot(key: 'key?=duong-toc', name: 'Dưỡng tóc'),
        KeyHot(key: 'key?=thuốc nhuộm', name: 'Thuốc nhuộm')
      ];
    } catch (e) {
      return [];
    }
  }

  Future<bool> updateHistory(String item) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String> list = await getHistory();
      list.insert(0, item);
      await prefs.setStringList(KEY_SEARCH, list);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> clearHistory() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setStringList(KEY_SEARCH, []);
      return true;
    } catch (e) {
      return false;
    }
  }
}
