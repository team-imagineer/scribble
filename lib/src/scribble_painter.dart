import 'package:flutter/rendering.dart';
import 'package:perfect_freehand/perfect_freehand.dart' as pf;
import 'package:scribble/scribble.dart';

class ScribblePainter extends CustomPainter {
  ScribblePainter({
    required this.state,
    required this.drawPointer,
    required this.drawEraser,
    this.isDarkMode = false,
  });

  final ScribbleState state;
  final bool drawPointer;
  final bool drawEraser;
  final bool isDarkMode;

  List<SketchLine> get lines => state.lines;

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..style = PaintingStyle.fill;

    for (int i = 0; i < lines.length; ++i) {
      final line = lines[i];

      paint.color = CustomColor(lines[i].color, isDarkMode);
      final points =
          line.points.map((point) => pf.Point(point.x, point.y)).toList();
      final outlinePoints = pf.getStroke(
        points,
        size: line.width,
        thinning: 0,
        smoothing: 0,
        streamline: 0,
        simulatePressure: false,
      );
      final path = Path();
      if (outlinePoints.isEmpty) {
        continue;
      } else {
        path.moveTo(outlinePoints[0].x, outlinePoints[0].y);
        for (int i = 1; i < outlinePoints.length - 1; ++i) {
          final p0 = outlinePoints[i];
          final p1 = outlinePoints[i + 1];
          path.quadraticBezierTo(
              p0.x, p0.y, (p0.x + p1.x) / 2, (p0.y + p1.y) / 2);
        }
      }
      paint.color = CustomColor(lines[i].color, isDarkMode);
      canvas.drawPath(path, paint);
    }
    if (state.pointerPosition != null &&
        (state is Drawing && drawPointer || state is Erasing && drawEraser)) {
      paint.style = state.map(
        drawing: (_) => PaintingStyle.fill,
        erasing: (_) => PaintingStyle.stroke,
      );
      paint.color = state.map(
        drawing: (s) => CustomColor(s.selectedColor, isDarkMode),
        erasing: (s) => const Color(0xFF000000),
      );
      paint.strokeWidth = 1;
    }
  }

  @override
  bool shouldRepaint(ScribblePainter oldDelegate) {
    return oldDelegate.state != state;
  }
}

class CustomColor extends Color {
  CustomColor(int value, bool isDarkMode)
      : super((isDarkMode && value == 0xFF000000) ? 0xFFFFFFFF : value);
}
