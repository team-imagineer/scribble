import 'dart:ui';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'point.freezed.dart';

part 'point.g.dart';

@freezed
class Point with _$Point {
  const Point._();

  const factory Point(double x, double y) = _Point;

  factory Point.fromJson(Map<String, dynamic> json) => _$PointFromJson(json);

  Offset get asOffset => Offset(x, y);
}
