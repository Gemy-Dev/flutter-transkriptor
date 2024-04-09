import 'dart:async';

import 'package:audioplayers/audioplayers.dart' as ap;
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';

class AppAudioPlayer extends ChangeNotifier {
  String? _path;

  final _audioPlayer = ap.AudioPlayer()..setReleaseMode(ReleaseMode.stop);
  late StreamSubscription<void> _playerStateChangedSubscription;
  late StreamSubscription<Duration?> _durationChangedSubscription;
  late StreamSubscription<Duration> _positionChangedSubscription;
  Duration? _position;
  Duration? _duration;
  Duration? get position => _position;
  Duration? get duration => _duration;

  Future<void> seek(Duration position) async =>
      await _audioPlayer.seek(position);
  PlayerState get state => _audioPlayer.state;
  void init(String path) {
    _path = path;
    _playerStateChangedSubscription =
        _audioPlayer.onPlayerComplete.listen((state) async {
      await stop();
    });
    _positionChangedSubscription =
        _audioPlayer.onPositionChanged.listen((position) {
      _position = position;
      notifyListeners();
    });
    _durationChangedSubscription = _audioPlayer.onDurationChanged.listen(
      (duration) {
        _duration = duration;
        notifyListeners();
      },
    );

    _audioPlayer.setSource(_source);
    notifyListeners();
  }

  void close() {
    if (_path == null) return;
    _playerStateChangedSubscription.cancel();
    _positionChangedSubscription.cancel();
    _durationChangedSubscription.cancel();
    _audioPlayer.dispose();
  }

  Future<void> play() => _audioPlayer.play(_source);
  Future<void> playByOne(String path) async {
    _path = path;
    notifyListeners();
    await play();
  }

  Future<void> pause() async {
    await _audioPlayer.pause();
    notifyListeners();
  }

  Future<void> stop() async {
    await _audioPlayer.stop();
    notifyListeners();
  }

  Source get _source =>
      kIsWeb ? ap.UrlSource(_path!) : ap.DeviceFileSource(_path!);
}
