part of 'data_structure.dart';

/// Abstract class `DataFilter`
///
/// This class serves as a base for creating data filters in a Flutter application.
/// It is intended to be extended by concrete filter classes to implement custom filtering logic.
///
/// Attributes:
/// - `fields`: A list of `AbstractFilter` items. Each item represents a field that can be used for filtering.
/// - `skip`: An integer representing the number of records to skip, typically used for pagination.
/// - `take`: An integer indicating the number of records to take or return, usually used for pagination.
/// - `orderBy`: A nullable string that specifies the field name to order the data by.
/// - `orderType`: A nullable `OrderType` (either `asc` for ascending or `desc` for descending) indicating the sorting order of the data.
///
/// Methods:
/// - `fromString(String orderType)`: Converts a string to an `OrderType`. Returns null if the input string does not match "asc" or "desc".
/// - `orderTypeAsString()`: Converts the current `orderType` to a string. Returns null if `orderType` is null.
/// - `toJSON()`: Converts the current filter state to a JSON object. This includes pagination information and any field-specific filters.
/// - `fromJSON(dynamic json)`: Initializes the filter with data from a

abstract class DataFilter {
  List<AbstractFilter> get fields;

  int skip = 0;

  int take = 10;

  String? orderBy;

  OrderType? orderType;

  OrderType? fromString(String orderType) {
    if (orderType.toLowerCase() == "desc") {
      return OrderType.desc;
    }
    if (orderType.toLowerCase() == "asc") {
      return OrderType.asc;
    }
    return null;
  }

  String? orderTypeAsString() {
    if (orderType == OrderType.asc) {
      return "ASC";
    }
    if (orderType == OrderType.desc) {
      return "DESC";
    }
    return null;
  }

  Map<String, dynamic> toJSON() {
    final Map<String, dynamic> result = {
      'skip': skip,
      'take': take,
    };
    if (orderBy != null) {
      result["orderBy"] = orderBy;
    }
    if (orderType != null) {
      result["orderType"] = orderTypeAsString();
    }

    for (final field in fields) {
      result[field.fieldName] = field.toJSON();
    }

    return result;
  }

  void fromJSON(dynamic json) {
    if (json is! Map<String, dynamic>) {
      throw Exception(
        "Data passed to DataFilter.fromJSON must be a Map<String, dynamic>",
      );
    }
    if (json.containsKey("skip")) {
      skip = json["skip"];
    }
    if (json.containsKey("take")) {
      take = json["take"];
    }
    if (json.containsKey("orderBy")) {
      orderBy = json["orderBy"];
    }
    if (json.containsKey("orderType")) {
      orderType = fromString(json["orderType"]);
    }
    for (final field in fields) {
      if (json.containsKey(field.fieldName)) {
        field.fromJSON(json[field.fieldName]);
      }
    }
  }

  @override
  String toString() {
    return jsonEncode(toJSON());
  }
}
