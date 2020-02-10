import 'package:json_annotation/json_annotation.dart';
part 'search_model.g.dart';

//explicitToJson:  true => Map<String, dynamic> toJson() => {'child': child?.toJson()};
//explicitToJson:  fasle => Map<String, dynamic> toJson() => {'child': child};
@JsonSerializable(explicitToJson: true)
class KeyHot {
  @JsonKey(required: true, name: 'name', defaultValue: '')
  String name;
  @JsonKey(required: true, name: 'key', defaultValue: '')
  String key;
  KeyHot({this.name, this.key});
  factory KeyHot.fromJson(Map<String, dynamic> json) => _$KeyHotFromJson(json);
  Map<String, dynamic> toJson() => _$KeyHotToJson(this);
}
