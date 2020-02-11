class SearchResultsService {
  SearchResultsService();
  Future searchData() async {
    await Future.delayed(const Duration(milliseconds: 2000), () {
      return;
    });
  }
}
