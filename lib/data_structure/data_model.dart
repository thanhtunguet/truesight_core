part of 'data_structure.dart';

typedef InstanceConstructor<T extends DataModel> = T Function();

class ModelType<T extends DataModel> {
  final InstanceConstructor<T> constructor;

  const ModelType({
    required this.constructor,
  });
}

abstract class DataModel implements DataSerializable {
  List<JsonType> get fields;

  static final Map<Type, ModelType> _modelTypes = {};

  static setType(Type className, InstanceConstructor constructor) {
    _modelTypes[className] = ModelType(constructor: constructor);
  }

  static ModelType getType(Type type) {
    return _modelTypes[type]!;
  }

  static create<T extends DataModel>(Type type) {
    final ModelType modelType = _modelTypes[type]!;
    final T instance = modelType.constructor() as T;
    return instance;
  }

  @override
  void fromJSON(dynamic json) {
    if (json is Map<String, dynamic>) {
      final Map<String, dynamic> errors =
          json.containsKey("errors") && json["errors"] is Map
              ? json["errors"]
              : {};

      final Map<String, dynamic> warnings =
          json.containsKey("warnings") && json["warnings"] is Map
              ? json["warnings"]
              : {};

      final Map<String, dynamic> informations =
          json.containsKey("informations") && json["informations"] is Map
              ? json["informations"]
              : {};

      for (final field in fields) {
        if (errors.containsKey(field.name)) {
          field.error = errors[field.name];
        }

        if (warnings.containsKey(field.name)) {
          field.warning = warnings[field.name];
        }

        if (informations.containsKey(field.name)) {
          field.information = informations[field.name];
        }

        if (field is JsonString ||
            field is JsonBoolean ||
            field is JsonNumber) {
          field.value = json[field.name];
          continue;
        }

        if (field is JsonDate) {
          if (json.containsKey(field.name) && json[field.name] != null) {
            field.value = DateTime.parse(json[field.name]);
          } else {
            field.value = null;
          }
          continue;
        }

        if (field is JsonObject) {
          field.value = create<DataModel>(field.genericType!);
          if (json.containsKey(field.name) && json[field.name] != null) {
            field.fromJSON(json[field.name]);
          }
          continue;
        }

        if (field is JsonList) {
          if (json.containsKey(field.name) && json[field.name] is List) {
            field.fromJSON(json[field.name]);
          }
          continue;
        }
      }
      return;
    }
    throw Exception(
      "Data passed to DataModel.fromJSON must be a Map<String, dynamic>",
    );
  }

  @override
  Map<String, dynamic> toJSON() {
    final Map<String, dynamic> result = {};

    for (final field in fields) {
      if (field is JsonString || field is JsonNumber || field is JsonBoolean) {
        result[field.name] = field.value;
        continue;
      }
      if (field is JsonDate) {
        result[field.name] = field.value?.toIso8601String();
        continue;
      }
      if (field is JsonObject) {
        result[field.name] = field.value?.toJSON();
        continue;
      }
      if (field is JsonList) {
        result[field.name] =
            field.value?.map((element) => element.toJSON()).toList();
        continue;
      }
    }

    return result;
  }
}
