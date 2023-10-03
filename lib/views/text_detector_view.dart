import 'package:audioplayers/audioplayers.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'detector_view.dart';
import '../painters/text_detector_painter.dart';

class TextRecognizerView extends StatefulWidget {
  @override
  State<TextRecognizerView> createState() => _TextRecognizerViewState();
}

class _TextRecognizerViewState extends State<TextRecognizerView> {
  var _textRecognizer = TextRecognizer(script: TextRecognitionScript.korean);
  bool _canProcess = true;
  bool _isBusy = false;
  bool _isEpic = false;
  CustomPaint? _customPaint;
  String? _text;
  var _cameraLensDirection = CameraLensDirection.back;

  @override
  void dispose() async {
    _canProcess = false;
    _textRecognizer.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          DetectorView(
            title: 'Text Detector',
            customPaint: _customPaint,
            text: _text,
            onImage: _processImage,
            initialCameraLensDirection: _cameraLensDirection,
            onCameraLensDirectionChanged: (value) => _cameraLensDirection = value,
          ),
        ]
      ),
    );
  }

  Future<void> _processImage(InputImage inputImage) async {
    if (!_canProcess) return;
    if (_isBusy) return;
    _isBusy = true;
    setState(() {
      _text = '';
    });
    final recognizedText = await _textRecognizer.processImage(inputImage);
    if (inputImage.metadata?.size != null &&
        inputImage.metadata?.rotation != null) {
      final painter = TextRecognizerPainter(
        recognizedText,
        inputImage.metadata!.size,
        inputImage.metadata!.rotation,
        _cameraLensDirection,
      );
      _customPaint = CustomPaint(painter: painter);
    } else {
      _text = 'Recognized text:\n\n${recognizedText.text}';
      // TODO: set _customPaint to draw boundingRect on top of image
      _customPaint = null;
    }
    if (recognizedText.text.contains('에픽') && _isEpic == false) {
      final player = AudioPlayer();
      player.play(AssetSource('sound.wav'));
      _isEpic = true;
    }

    if (recognizedText.text.contains('STR')) {
      if (recognizedText.text.substring(recognizedText.text.indexOf('STR')+1).contains('STR') || recognizedText.text.contains('올스탯')) {
        final player = AudioPlayer();
        player.play(AssetSource('sound.wav'));
      }
    }
    if (recognizedText.text.contains('DEX')) {
      if (recognizedText.text.substring(recognizedText.text.indexOf('DEX')+1).contains('DEX') || recognizedText.text.contains('올스탯')) {
        final player = AudioPlayer();
        player.play(AssetSource('sound.wav'));
      }
    }
    if (recognizedText.text.contains('INT')) {
      if (recognizedText.text.substring(recognizedText.text.indexOf('INT')+1).contains('INT') || recognizedText.text.contains('올스탯')) {
        final player = AudioPlayer();
        player.play(AssetSource('sound.wav'));
      }
    }
    if (recognizedText.text.contains('LUK')) {
      if (recognizedText.text.substring(recognizedText.text.indexOf('LUK')+1).contains('LUK') || recognizedText.text.contains('올스탯')) {
        final player = AudioPlayer();
        player.play(AssetSource('sound.wav'));
      }
    }

    _isBusy = false;
    if (mounted) {
      setState(() {});
    }
  }
}
