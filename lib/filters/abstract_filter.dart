part of 'filters.dart';

/// Base class for filter classes
abstract interface class AbstractFilter implements DataSerializable {
  final String fieldName;

  AbstractFilter(this.fieldName);

  /// Convert this filter directly to JSON string
  @override
  String toString() {
    return jsonEncode(toJSON());
  }
}
