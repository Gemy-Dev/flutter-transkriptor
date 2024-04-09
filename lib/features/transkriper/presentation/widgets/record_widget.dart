// import 'dart:developer';
// import 'dart:io';
// import 'dart:typed_data';

// import 'package:flutter/material.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:record/record.dart';
// import 'package:audioplayers/audioplayers.dart';
// import 'package:transkriptor/core/extensions/time_formate_ex.dart';

// // As always, don't forget this one.
// class Recorder extends StatefulWidget {
//   const Recorder({super.key});

//   @override
//   State<Recorder> createState() => _RecorderState();
// }

// class _RecorderState extends State<Recorder> {
//   final record = AudioRecorder();
//   String? path;
//   bool isRecoding = false;
//   Stream<Uint8List>? stream;
//   start() async {
//     if (await record.hasPermission()) {
//       final path=await getApplicationCacheDirectory();
//       // Start recording to file
//       log(path.path);
//       await record.start(const RecordConfig(), path: '${path.path}/${DateTime.now().formattedDate}.m4a');
//       setState(() {
//         isRecoding = true;
//       });
//       // ... or to stream
//       // stream = await record
//       //     .startStream(const RecordConfig(encoder: AudioEncoder.wav));
//     }
//   }
// // Check and request permission if needed

//   stop() async {
//     print('///////////////');
//     setState(() {
//       isRecoding=false;
//     });
//     path = await record.stop();

//   }

// // Stop recording...
//   cancel() async => await record.cancel();
// // ... or cancel it (and implicitly remove file/blob).

//   @override
//   void dispose() {
//     record.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Column(children: [
//         Row(
//           children: [
//             Expanded(
//                 child: IconButton(
//                     onPressed: () async {
//                       print(isRecoding);
//                       if (isRecoding) {
//                         await stop();
//                       } else {
//                         await start();
//                       }
//                     },
//                     icon: Icon(
//                       isRecoding ? Icons.square : Icons.mic,
//                       color: Colors.red,
//                     ))),
//             Expanded(
//                 child: IconButton(
//                     onPressed: () async {if(path==null) return;
//                        final player = AudioPlayer();
// await player.play(AssetSource(File(path!).path));
//     log(path.toString());
//     log(player.state.name);
//                     },
//                     icon: const Icon(
//                      Icons.play_arrow
//                     )))
//           ],
//         )
//       ]),
//     );
//   }
// }
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transkriptor/features/transkriper/presentation/blocs/bloc.dart';
import 'package:transkriptor/features/transkriper/presentation/blocs/state.dart';

import 'audio_player.dart';
import 'record_player.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool showPlayer = false;
  String? audioPath;

  @override
  void initState() {
    showPlayer = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: BlocConsumer<TranskripBloc, TranskriptState>(
          listener: (context, state) {
         
          },
          builder: (context, state) {
            return Center(
              child: showPlayer
                  ? Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 25),
                              child: RecordPlayer(
                                source: audioPath!,
                                onDelete: ()async {
                               if(audioPath!=null){await   File(audioPath!).delete();}
                                  setState(() => showPlayer = false);
                                },
                              )),
                        ),
                        ElevatedButton(
                            onPressed: () {

                              BlocProvider.of<TranskripBloc>(context).createTranskript(audioPath!);
                              Navigator.pop(context);
                            }, child: const Text('Transkript'))
                      ],
                    )
                  : Recorder(
                      onStop: (path) {
                        if (kDebugMode) print('Recorded file path: $path');
                        setState(() {
                          audioPath = path;
                          showPlayer = true;
                        });
                      },
                    ),
            );
          },
        ),
      ),
    );
  }
}
