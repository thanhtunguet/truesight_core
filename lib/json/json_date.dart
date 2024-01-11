part of 'json.dart';

abstract interface class IJsonDate {
  String format(String format);
}

class JsonDate extends JsonType<DateTime?> implements IJsonDate {
  JsonDate(
    super.name, {
    super.isRequired,
    super.defaultValue,
  });

  @override
  void fromJSON(dynamic value) {
    if (value is String) {
      this.value = DateTime.parse(value);
      return;
    }
    this.value = DateTime.now();
  }

  @override
  toJSON() {
    return value?.toIso8601String();
  }

  @override
  String format(String format) {
    return DateFormat(format).format(value!);
  }
}
