import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';

class GestureCatcher extends StatelessWidget {
  const GestureCatcher({
    Key? key,
    required this.pointerKindsToCatch,
    required this.child,
  }) : super(key: key);

  final Set<PointerDeviceKind> pointerKindsToCatch;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return RawGestureDetector(
      key: ValueKey(pointerKindsToCatch),
      gestures: {
        GestureCatcherRecognizer:
        GestureRecognizerFactoryWithHandlers<GestureCatcherRecognizer>(
              () => GestureCatcherRecognizer(
            debugOwner: this,
            pointerKindsToCatch: pointerKindsToCatch,
          ),
              (GestureCatcherRecognizer instance) {},
        )
      },
      child: child,
    );
  }
}

class GestureCatcherRecognizer extends OneSequenceGestureRecognizer {
  GestureCatcherRecognizer({
    required Set<PointerDeviceKind> pointerKindsToCatch,
    Object? debugOwner,
  }) : super(debugOwner: debugOwner, supportedDevices: pointerKindsToCatch);

  @override
  String get debugDescription => 'pan catcher';

  @override
  void didStopTrackingLastPointer(int pointer) {}

  @override
  void handleEvent(PointerEvent event) {
    resolve(GestureDisposition.accepted);
  }
}