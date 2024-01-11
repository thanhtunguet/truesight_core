part of 'json.dart';

class JsonObject<T extends DataModel> extends JsonType<T> implements JsonObjectType {
  JsonObject(
    super.name, {
    super.isRequired,
    super.defaultValue,
  }) {
    genericType = T;
  }

  @override
  void fromJSON(dynamic value) {
    final ModelType typeMapping = DataModel.getType(genericType);
    final T instance = typeMapping.constructor() as T;
    if (value != null) {
      instance.fromJSON(value);
    }
    this.value = instance;
  }

  @override
  toJSON() {
    return value?.toJSON();
  }

  @override
  late Type genericType;
}
