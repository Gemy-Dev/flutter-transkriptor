import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:transkriptor/core/audio_managment/audio_player.dart';

class RecordesList extends StatefulWidget {
  const RecordesList({
    super.key,
    required this.audioFiles,
    required this.player,
  });
  final List<String> audioFiles;
  final AppAudioPlayer player;

  @override
  State<RecordesList> createState() => _RecordesListState();
}

class _RecordesListState extends State<RecordesList> {
  int currentAudio = 0;
  List<String> get recordes => widget.audioFiles;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: recordes.length,
        itemBuilder: (_, index) {
          return Container(
            margin: const EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(blurRadius: 10, color: Colors.grey.shade300)
                ],
                borderRadius: BorderRadius.circular(10)),
            padding: const EdgeInsets.all(8.0),
            child: ListenableBuilder(
                listenable: widget.player,
                builder: (context, _) {
                  return ListTile(
                    tileColor: Colors.white,
                    title: Text(getTileFromPath(recordes[index])),
                    subtitle: SizedBox(
                      width: 150,
                      child: 
                       IconButton(
                          icon: Icon(
                              (widget.player.state == PlayerState.playing &&
                                      currentAudio == index)
                                  ? Icons.pause
                                  : Icons.play_arrow, size: 25,),
                          onPressed: () async {
                            await widget.player.playByOne(recordes[index]);
                            currentAudio = index;
                          }),
                    ),trailing: IconButton(icon: const Icon(Icons.delete),onPressed: () async=> await _delete(index),),
                  );
                }),
          );
        });
  }

  String getTileFromPath(String path) {
    final result = path.split('\\').last;
    return result.split('.').first;
  }
  
  _delete(int index) async{
final path=widget.audioFiles[index];
    if(!File(path).existsSync()) return;
    File(path).delete();
  await    widget.player.stop();
    setState(() {
      widget.audioFiles.removeAt(index);
  });
}}
