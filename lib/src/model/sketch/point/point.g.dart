part of 'point.dart';

_$_Point _$$_PointFromJson(Map<String, dynamic> json) => _$_Point(
      double.parse(json['x'] as String).toDouble(),
      double.parse(json['y'] as String).toDouble(),
    );

Map<String, dynamic> _$$_PointToJson(_$_Point instance) =>
    <String, dynamic>{
      'x': instance.x.toStringAsFixed(2),
      'y': instance.y.toStringAsFixed(2),
    };
