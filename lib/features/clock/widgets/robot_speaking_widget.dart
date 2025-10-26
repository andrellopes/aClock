import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class RobotSpeakingWidget extends StatefulWidget {
  final FlutterTts flutterTts;
  final VoidCallback onSpeechComplete;

  const RobotSpeakingWidget({
    super.key,
    required this.flutterTts,
    required this.onSpeechComplete,
  });

  @override
  State<RobotSpeakingWidget> createState() => _RobotSpeakingWidgetState();
}

class _RobotSpeakingWidgetState extends State<RobotSpeakingWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _mouthAnimationController;
  late Animation<double> _mouthAnimation;

  @override
  void initState() {
    super.initState();
    _mouthAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _mouthAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _mouthAnimationController,
        curve: Curves.easeInOut,
      ),
    );

    widget.flutterTts.setStartHandler(() {
      Future.microtask(() {
        if (mounted) {
          _mouthAnimationController.repeat(reverse: true);
        }
      });
    });

    widget.flutterTts.setCompletionHandler(() {
      Future.microtask(() {
        if (mounted) {
          _mouthAnimationController.stop();
          setState(() => _mouthAnimationController.value = 0.0);
          widget.onSpeechComplete();
        }
      });
    });

    widget.flutterTts.setErrorHandler((msg) {
      debugPrint("TTS Error: $msg");
      Future.microtask(() {
        if (mounted) {
          _mouthAnimationController.stop();
          setState(() => _mouthAnimationController.value = 0.0);
          widget.onSpeechComplete();
        }
      });
    });
  }

  @override
  void dispose() {
    _mouthAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: Container(
          width: 200,
          height: 200,
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 204.0), // 0.8 * 255
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white, width: 2),
          ),
          child: CustomPaint(
            painter: RobotPainter(mouthAnimation: _mouthAnimation),
          ),
        ),
      ),
    );
  }
}

class RobotPainter extends CustomPainter {
  final Animation<double> mouthAnimation;

  RobotPainter({required this.mouthAnimation}) : super(repaint: mouthAnimation);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 5.0
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(Offset(size.width * 0.3, size.height * 0.4), 15, paint);
    canvas.drawCircle(Offset(size.width * 0.7, size.height * 0.4), 15, paint);

    paint.style = PaintingStyle.stroke;

    final mouthWidth = size.width * 0.4;
    final mouthY = size.height * 0.7;
    final mouthOpenness = size.height * 0.05 + (size.height * 0.15 * mouthAnimation.value);
    final path = Path();
    path.moveTo(size.width * 0.5 - mouthWidth / 2, mouthY);
    path.quadraticBezierTo(
      size.width * 0.5,
      mouthY + mouthOpenness,
      size.width * 0.5 + mouthWidth / 2,
      mouthY,
    );
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
