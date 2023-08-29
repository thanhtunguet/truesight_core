part of 'data_structure.dart';

abstract class DataSerializable {
  void fromJSON(dynamic json);

  dynamic toJSON();
}
