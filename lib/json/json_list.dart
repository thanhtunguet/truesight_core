part of 'json.dart';

class JsonList<T extends DataModel> extends JsonType<List<T>> {
  JsonList(
    super.name, {
    super.isRequired,
    super.defaultValue,
  }) {
    genericType = T;
    value = [];
  }

  @override
  void fromJSON(dynamic value) {
    if (value is List) {
      final ModelType typeMapping = DataModel.getType(genericType!);
      this.value = value.map((element) {
        final T instance = typeMapping.constructor() as T;
        instance.fromJSON(element);
        return instance;
      }).toList();
    }
  }

  @override
  toJSON() {
    return value?.map((element) => element.toJSON()).toList();
  }
}
