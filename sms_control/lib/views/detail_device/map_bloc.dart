import 'dart:async';
import 'dart:typed_data';

import 'dart:ui';
import 'package:async/async.dart';
import 'package:flutter/material.dart';

class MapBloc {
  StreamController<Uint8List> _stIcon = StreamController();

  Stream<Uint8List> get stIcon => _stIcon.stream;

  AsyncMemoizer _cache = AsyncMemoizer();

  getBytesFromCanvas(int width, int height) async {
    _cache.runOnce(() async {
      final PictureRecorder pictureRecorder = PictureRecorder();
      final Canvas canvas = Canvas(pictureRecorder);
      final Paint paint = Paint()..color = Colors.red;
      final Radius radius = Radius.circular(25.0);
      canvas.drawRRect(
          RRect.fromRectAndCorners(
            Rect.fromLTWH(0.0, 0.0, width.toDouble(), height.toDouble()),
            topLeft: radius,
            topRight: radius,
            bottomLeft: radius,
            bottomRight: radius,
          ),
          paint);
      // TextPainter painter = TextPainter(textDirection: TextDirection.ltr);
//      painter.text = TextSpan(
//        text: 'Hi',
//        style: TextStyle(fontSize: 25.0, color: Colors.white),
//      );
      //painter.layout();
      // painter.paint(canvas, Offset((width * 0.5) - painter.width * 0.5, (height * 0.5) - painter.height * 0.5));
      final img = await pictureRecorder.endRecording().toImage(width, height);
      final data = await img.toByteData(format: ImageByteFormat.png);
      _stIcon.add(data!.buffer.asUint8List());
    });
  }
}
