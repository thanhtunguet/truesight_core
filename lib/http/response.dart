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
  List<T> bodyAsList<T extends DataModel>(Type type) {
    var result = <T>[];

    if (data is List) {
      for (var element in data) {
        var model = DataModel.create<T>(type);
        model.fromJSON(element);
        result.add(model);
      }
    }

    return result;
  }

  /// Get response body as text string
  String bodyAsString() {
    return data.toString();
  }

  // Get response body as numeric
  num bodyAsNumber() {
    return num.parse(data.toString());
  }

  int bodyAsInteger() {
    return int.parse(data.toString());
  }

  double bodyAsDecimal() {
    return double.parse(data.toString());
  }
}
