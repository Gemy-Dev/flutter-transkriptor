import 'dart:io';
import 'package:audioplayers/audioplayers.dart' as ap;
import 'package:audioplayers/audioplayers.dart';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:transkriptor/core/audio_managment/audio_player.dart';
import 'package:transkriptor/core/theme/colors.dart';

import '../widgets/records_list.dart';

class Records extends StatefulWidget {
  const Records({super.key});

  @override
  State<Records> createState() => _RecordsState();
}

class _RecordsState extends State<Records> {
  late AppAudioPlayer audioPlayer;
  @override
  void initState() {
    audioPlayer = AppAudioPlayer();
    super.initState();
  }

  @override
  void dispose() {
    audioPlayer.close();
    super.dispose();
  }

  int currentAudio = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bg,
      appBar: AppBar(
        title: Text('Recordes'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: FutureBuilder(
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
                if (audioFiles.isEmpty)
                  return const Center(
                    child: Icon(Icons.insert_drive_file_sharp),
                  );
                audioFiles = audioFiles.reversed.toList();

                audioPlayer.init(audioFiles[0]);
                return RecordesList(
                  audioFiles: audioFiles,
                  player: audioPlayer,
                );
              } else {
                return const Center(child: Icon(Icons.hourglass_empty_rounded));
              }
            }),
      ),
    );
  }
}
