part of 'http.dart';

/// Extension for `dio`'s Response class
extension ExtendedResponse on Response {
  /// Convert response body to a DataModel
  T body<T extends DataModel>(Type type) {
    T model = DataModel.create<T>(type);
    model.fromJSON(data);
    return model;
  }

  /// Convert response body to a list of DataModel
  List<T> list<T extends DataModel>(Type type) {
    return data.map((element) {
      T model = DataModel.create<T>(type);
      model.fromJSON(element);
      return model;
    });
  }

  /// Get response body as text string
  String text() {
    return data.toString();
  }

  // Get response body as numeric
  num number() {
    return num.parse(data.toString());
  }

  int integer() {
    return int.parse(data.toString());
  }

  double decimal() {
    return double.parse(data.toString());
  }
}
