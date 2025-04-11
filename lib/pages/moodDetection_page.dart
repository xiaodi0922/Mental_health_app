import 'dart:math' as math;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:permission_handler/permission_handler.dart';

import '../emoji_images/mood_images.dart';

class MoodDetectionPage extends StatefulWidget {
  @override
  _MoodDetectionPageState createState() => _MoodDetectionPageState();
}

class _MoodDetectionPageState extends State<MoodDetectionPage> {
  CameraController? _cameraController;
  FaceDetector? _faceDetector;
  bool _isDetecting = false;
  double _sliderValue = 2; // Default to "Neutral"

  Uint8List convertYUV420toNV21(CameraImage image) {
    final int width = image.width;
    final int height = image.height;
    final int ySize = width * height;
    final int uvSize = width * height ~/ 2;

    final Uint8List nv21 = Uint8List(ySize + uvSize);

    // Copy Y plane
    final Uint8List yPlane = image.planes[0].bytes;
    nv21.setRange(0, yPlane.length, yPlane);

    // Copy UV planes — limit the index to available space
    final Uint8List uPlane = image.planes[1].bytes;
    final Uint8List vPlane = image.planes[2].bytes;

    int uvIndex = yPlane.length;
    final int maxUVLength = nv21.length - uvIndex;

    for (int i = 0; i < uPlane.length && i < vPlane.length && (i * 2 + 1) < maxUVLength; i++) {
      nv21[uvIndex++] = vPlane[i]; // V
      nv21[uvIndex++] = uPlane[i]; // U
    }

    return nv21;
  }



  @override
  void initState() {
    super.initState();
    requestCameraPermission();
    initializeCamera();
    _faceDetector = FaceDetector(
      options: FaceDetectorOptions(
        enableClassification: true,
        enableLandmarks: true,
        performanceMode: FaceDetectorMode.accurate,
      ),
    );
  }

  Future<void> requestCameraPermission() async {
    var status = await Permission.camera.status;

    if (!status.isGranted) {
      await Permission.camera.request();
    }
  }

  Future<void> initializeCamera() async {
    final cameras = await availableCameras();
    final frontCamera = cameras.firstWhere(
          (camera) => camera.lensDirection == CameraLensDirection.front,
      orElse: () => cameras.first,
    );

    _cameraController = CameraController(
      frontCamera,
      ResolutionPreset.medium,
      enableAudio: false,
    );

    await _cameraController?.initialize();
    if (!mounted) return;

    setState(() {});
    startFaceDetection();
  }
  InputImageRotation _cameraRotation() {
    final camera = _cameraController!.description;

    switch (camera.sensorOrientation) {
      case 0:
        return InputImageRotation.rotation0deg;
      case 90:
        return InputImageRotation.rotation90deg;
      case 180:
        return InputImageRotation.rotation180deg;
      case 270:
        return InputImageRotation.rotation270deg;
      default:
        return InputImageRotation.rotation0deg;
    }
  }


  void startFaceDetection() {
    _cameraController?.startImageStream((CameraImage image) async {
      if (_isDetecting) return;
      _isDetecting = true;

      try {
        final bytes = convertYUV420toNV21(image);

        final inputImage = InputImage.fromBytes(
          bytes: bytes,
          metadata: InputImageMetadata(
            size: Size(image.width.toDouble(), image.height.toDouble()),
            rotation: _cameraRotation(),
            format: InputImageFormat.nv21,
            bytesPerRow: image.planes[0].bytesPerRow,
          ),
        );

        final faces = await _faceDetector!.processImage(inputImage);

        if (faces.isNotEmpty) {
          final detectedFace = faces.first;
          debugPrint("Face Detected!");
          debugPrint("Smile Probability: ${detectedFace.smilingProbability}");

          setState(() {
            _sliderValue = getMoodIndex(detectedFace);
          });
        } else {
          debugPrint("No face detected!");
        }
      } catch (e) {
        print("Error in face detection: $e");
      }

      _isDetecting = false;
    });
  }



  double getMoodIndex(Face face) {
    if (face.smilingProbability != null) {
      final double smileProb = face.smilingProbability!;
      debugPrint("Detected Smile Probability: $smileProb");

      if (smileProb > 0.8) return 4; // Great 😃
      if (smileProb > 0.6 && smileProb <= 0.8) return 3; // Good 🙂
      if (smileProb > 0.4 && smileProb <= 0.6) return 2; // Neutral 😐
      if (smileProb > 0.061 && smileProb <= 0.2) return 1; // Sad 😟
      if (smileProb <= 0.1) return 0; // Awful 😞
    }
    return 2; // Default to Sad if no smile probability is detected
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    _faceDetector?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Mood Detection")),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: _cameraController == null || !_cameraController!.value.isInitialized
                ? Center(child: CircularProgressIndicator())
                : Transform(
              alignment: Alignment.center,
              transform: Matrix4.rotationY(math.pi), // Flip horizontally
              child: CameraPreview(_cameraController!),
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Your Mood: ${MoodImages.moodTexts[_sliderValue.toInt()]}",
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Column(
                    children: [
                      Image.asset(
                        MoodImages.moodImages[_sliderValue.toInt()],
                        width: 100,
                        height: 100,
                      ),
                      Slider(
                        value: _sliderValue,
                        min: 0,
                        max: 4,
                        divisions: 4,
                        onChanged: (value) {},
                        activeColor: Colors.green,
                        inactiveColor: Colors.grey.shade300,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}