part of 'data_structure.dart';

abstract interface class DataSerializable {
  void fromJSON(dynamic json);

  dynamic toJSON();
}
