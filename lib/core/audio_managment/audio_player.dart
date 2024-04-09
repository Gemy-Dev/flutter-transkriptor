// import 'dart:async';

// import 'package:audioplayers/audioplayers.dart' as ap;
// import 'package:audioplayers/audioplayers.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';

// class AudioPlayerState extends ChangeNotifier{
// final String source;
// AudioPlayerState(this.source){}

//     final _audioPlayer = ap.AudioPlayer()..setReleaseMode(ReleaseMode.stop);
//   late StreamSubscription<void> _playerStateChangedSubscription;
//   late StreamSubscription<Duration?> _durationChangedSubscription;
//   late StreamSubscription<Duration> _positionChangedSubscription;
//   Duration? _position;
//   Duration? _duration;


//   void initState() {
//     _playerStateChangedSubscription =
//         _audioPlayer.onPlayerComplete.listen((state) async {
//       await stop();
//     });
//     _positionChangedSubscription = _audioPlayer.onPositionChanged.listen(
//       (position) {
//         _position = position;
//         notifyListeners();
//       }
    
//     );
//     _durationChangedSubscription = _audioPlayer.onDurationChanged.listen(
//       (duration)  {
//         _duration = duration;
//          notifyListeners();
//       },
//     );

//     _audioPlayer.setSource(_source);
//  notifyListeners();
//   }


//   void dispose() {
//     _playerStateChangedSubscription.cancel();
//     _positionChangedSubscription.cancel();
//     _durationChangedSubscription.cancel();
//     _audioPlayer.dispose();
//     super.dispose();
//   }
  
//    Future<void> play() => _audioPlayer.play(_source);

//   Future<void> pause() async {
//     await _audioPlayer.pause();
//    notifyListeners();
//   }

//   Future<void> stop() async {
//     await _audioPlayer.stop();
//    notifyListeners();
//   }

//   Source get source =>
//       kIsWeb ? ap.UrlSource(widget.source) : ap.DeviceFileSource(widget.source);
// }