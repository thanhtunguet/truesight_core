import 'package:truesight_core/data_structure/data_structure.dart';

part 'json_boolean.dart';
part 'json_date.dart';
part 'json_list.dart';
part 'json_number.dart';
part 'json_object.dart';
part 'json_string.dart';

typedef DataModelNewInstance = DataModel Function();

interface class JsonType<T> implements DataSerializable {
  final String name;

  final Type type = T;

  Type? genericType;

  bool isRequired;

  T? value;

  T? defaultValue;

  String? helper;

  String? information;

  String? warning;

  String? error;

  bool get hasValue {
    return value != null;
  }

  bool get hasError {
    return error != null && error != "";
  }

  bool get hasWarning {
    return warning != null && warning != "";
  }

  bool get hasInfo {
    return information != null && information != "";
  }

  bool get isNull {
    return value == null;
  }

  T get notNullValue {
    return value!;
  }

  JsonType(
    this.name, {
    this.isRequired = false,
    this.defaultValue,
    this.helper,
  });

  @override
  dynamic toJSON() {
    return value;
  }

  @override
  void fromJSON(dynamic value) {
    this.value = value ?? defaultValue;
  }
}
