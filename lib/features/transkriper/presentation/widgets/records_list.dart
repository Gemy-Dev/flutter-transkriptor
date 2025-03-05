import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:transkriptor/core/audio_managment/audio_player.dart';
import 'package:transkriptor/core/theme/colors.dart';

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
            margin: const EdgeInsets.symmetric(vertical: 5),
            decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(blurRadius: 10, color: Colors.grey.shade300)
                ],
                borderRadius: BorderRadius.circular(10)),
            padding: const EdgeInsets.all(0),
            child: ListenableBuilder(
                listenable: widget.player,
                builder: (context, _) {
                  return Padding(
                    padding:
                        const EdgeInsets.only(top: 10, bottom: 20, left: 10),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: AppColor.secondary,
                                borderRadius: BorderRadius.circular(5)),
                            child: const Icon(Icons.audiotrack),
                          ),
                          Column(
                            spacing: 8,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(getTileFromPath(recordes[index])),
                              Text('date time')
                            ],
                          ),
                          Row(
                            children: [
                              InkWell(
                                onTap: () async {
                                  await widget.player
                                      .playByOne(recordes[index]);
                                  currentAudio = index;
                                },
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 4, color: AppColor.primary),
                                      borderRadius: BorderRadius.circular(50)),
                                  child: Icon(
                                    (widget.player.state ==
                                                PlayerState.playing &&
                                            currentAudio == index)
                                        ? Icons.pause
                                        : Icons.play_arrow,
                                    size: 25,
                                    color: AppColor.primary,
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.more_vert_outlined),
                                onPressed: () async => await _delete(index),
                              ),
                            ],
                          ),
                        ]),
                  );
                }),
          );
        });
  }

  String getTileFromPath(String path) {
    final result = path.split('/').last;
    List spletResult = result.split('.');
    return spletResult[spletResult.length - 2];
  }

  _delete(int index) async {
    final path = widget.audioFiles[index];
    if (!File(path).existsSync()) return;
    File(path).delete();
    await widget.player.stop();
    setState(() {
      widget.audioFiles.removeAt(index);
    });
  }
}
