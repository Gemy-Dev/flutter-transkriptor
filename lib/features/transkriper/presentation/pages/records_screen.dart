import 'dart:developer';
import 'dart:io';
import 'package:audioplayers/audioplayers.dart' as ap;
import 'package:audioplayers/audioplayers.dart';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:transkriptor/features/transkriper/presentation/widgets/audio_player.dart';

class Records extends StatefulWidget {
  const Records({super.key});

  @override
  State<Records> createState() => _RecordsState();
}

class _RecordsState extends State<Records> {
 final _audioPlayer = ap.AudioPlayer()..setReleaseMode(ReleaseMode.stop) 
 ; 
 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
          future: getApplicationDocumentsDirectory(),
          builder: (context, dirctory) {
            if (dirctory.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (dirctory.hasData) {
              final List<FileSystemEntity> items = dirctory.data!.listSync();
              List<String> audioFiles = [];

              for (var audio in items) {
                if (audio.path.contains('m4a')) {
                  audioFiles.add(audio.path);
                }
              }
              audioFiles = audioFiles.reversed.toList();

              return StatefulBuilder(builder: (context, build) {
                return ListView.builder(
                    itemCount: audioFiles.length,
                    itemBuilder: (_, index) => ListTile(
                          title: Text(getTileFromPath(audioFiles[index])),
                          trailing: SizedBox(
                            width: 150,
                            child: IconButton(icon:  const Icon(Icons.play_arrow),onPressed: () => _audioPlayer.play(ap.DeviceFileSource(audioFiles[index])),),
                          ),
                        ));
              });
            } else
              return const Center(child: Icon(Icons.hourglass_empty_rounded));
          }),
    );
  }
  String getTileFromPath(String path) {
    final result = path.split('/').last;
    return result.split('.').first;
  }
}
