import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class MediaCapture extends StatelessWidget {
  final String widgetToShow;

  const MediaCapture({super.key, required this.widgetToShow});

  @override
  Widget build(BuildContext context) {
    switch (widgetToShow) {
      case "TakePhoto":
        return const TakePhoto();
      case "PickSingleImage":
        return const PickSingleImage();
      case "PickMultipleImages":
        return const PickMultipleImages();
      case "RecordVideo":
        return const RecordVideo();
      case "PlayVideo":
        return const PlayVideo();
      default:
        return const TakePhoto();
    }
  }
}

class TakePhoto extends StatefulWidget {
  const TakePhoto({super.key});

  @override
  State<TakePhoto> createState() => _TakePhotoState();
}

class _TakePhotoState extends State<TakePhoto> {
  File? _image;
  final ImagePicker _picker = ImagePicker();

  Future<void> _takePhoto() async {
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);

    if (photo != null) {
      setState(() {
        _image = File(photo.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Take a Photo'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_image != null)
              Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Image.file(
                  _image!,
                  fit: BoxFit.cover,
                ),
              )
            else
              Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.camera_alt,
                  size: 100,
                  color: Colors.grey,
                ),
              ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: _takePhoto,
              icon: const Icon(Icons.camera),
              label: const Text('Take Photo'),
            ),
          ],
        ),
      ),
    );
  }
}

class PickSingleImage extends StatefulWidget {
  const PickSingleImage({super.key});

  @override
  State<PickSingleImage> createState() => _PickSingleImageState();
}

class _PickSingleImageState extends State<PickSingleImage> {
  File? _image;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _image = File(image.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pick a Single Image'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_image != null)
              Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Image.file(
                  _image!,
                  fit: BoxFit.cover,
                ),
              )
            else
              Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.photo_library,
                  size: 100,
                  color: Colors.grey,
                ),
              ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: _pickImage,
              icon: const Icon(Icons.photo_library),
              label: const Text('Select Image'),
            ),
          ],
        ),
      ),
    );
  }
}

class PickMultipleImages extends StatefulWidget {
  const PickMultipleImages({super.key});

  @override
  State<PickMultipleImages> createState() => _PickMultipleImagesState();
}

class _PickMultipleImagesState extends State<PickMultipleImages> {
  List<File> _images = [];
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickMultipleImages() async {
    final List<XFile> selectedImages = await _picker.pickMultiImage();

    if (selectedImages.isNotEmpty) {
      setState(() {
        _images = selectedImages.map((image) => File(image.path)).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pick Multiple Images'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: _pickMultipleImages,
            icon: const Icon(Icons.photo_library),
            label: const Text('Select Multiple Images'),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: _images.isEmpty
                ? const Center(
                    child: Text(
                      'No images selected',
                      style: TextStyle(fontSize: 18),
                    ),
                  )
                : GridView.builder(
                    padding: const EdgeInsets.all(8),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                    ),
                    itemCount: _images.length,
                    itemBuilder: (context, index) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.file(
                          _images[index],
                          fit: BoxFit.cover,
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

class RecordVideo extends StatefulWidget {
  const RecordVideo({super.key});

  @override
  State<RecordVideo> createState() => _RecordVideoState();
}

class _RecordVideoState extends State<RecordVideo> {
  File? _videoFile;
  final ImagePicker _picker = ImagePicker();

  Future<void> _recordVideo() async {
    final XFile? video = await _picker.pickVideo(source: ImageSource.camera);

    if (video != null) {
      setState(() {
        _videoFile = File(video.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Record Video'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_videoFile != null)
              Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    const Icon(
                      Icons.video_file,
                      size: 100,
                      color: Colors.grey,
                    ),
                    Text(
                      'Video recorded: ${_videoFile!.path.split('/').last}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        backgroundColor: Colors.white70,
                      ),
                    ),
                  ],
                ),
              )
            else
              Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.videocam,
                  size: 100,
                  color: Colors.grey,
                ),
              ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: _recordVideo,
              icon: const Icon(Icons.videocam),
              label: const Text('Record Video'),
            ),
          ],
        ),
      ),
    );
  }
}

class PlayVideo extends StatefulWidget {
  const PlayVideo({super.key});

  @override
  State<PlayVideo> createState() => _PlayVideoState();
}

class _PlayVideoState extends State<PlayVideo> {
  File? _videoFile;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickVideo() async {
    final XFile? video = await _picker.pickVideo(source: ImageSource.gallery);

    if (video != null) {
      setState(() {
        _videoFile = File(video.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Play Video'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_videoFile != null)
              Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    const Icon(
                      Icons.video_file,
                      size: 100,
                      color: Colors.grey,
                    ),
                    Text(
                      'Selected video: ${_videoFile!.path.split('/').last}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        backgroundColor: Colors.white70,
                      ),
                    ),
                  ],
                ),
              )
            else
              Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.video_library,
                  size: 100,
                  color: Colors.grey,
                ),
              ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: _pickVideo,
              icon: const Icon(Icons.video_library),
              label: const Text('Select Video'),
            ),
          ],
        ),
      ),
    );
  }
}
