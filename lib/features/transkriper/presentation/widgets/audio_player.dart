import 'dart:async';

import 'package:audioplayers/audioplayers.dart' as ap;
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:transkriptor/core/audio_managment/audio_player.dart';

class RecordPlayer extends StatefulWidget {
  /// Path from where to play recorded audio
  final String source;

  /// Callback when audio file should be removed
  /// Setting this to null hides the delete button
  final VoidCallback? onDelete;

  const RecordPlayer({
    super.key,
    required this.source,
     this.onDelete,
  });

  @override
  RecordPlayerState createState() => RecordPlayerState();
}

class RecordPlayerState extends State<RecordPlayer> {
  static const double _controlSize = 56;
  static const double _deleteBtnSize = 24;


  String get _source=>widget.source;
late AppAudioPlayer _audioPlayer;
  @override
  void initState() {
    _audioPlayer=AppAudioPlayer();
    _audioPlayer.init(_source);
   

    super.initState();
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
  
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return ListenableBuilder(listenable: _audioPlayer,
          builder: (context,_) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    _buildControl(),
                    _buildSlider(constraints.maxWidth),
                if(widget.onDelete!=null)     IconButton(
                      icon: const Icon(Icons.delete,
                          color: Color(0xFF73748D), size: _deleteBtnSize),
                      onPressed: () {
                        if (_audioPlayer.state == ap.PlayerState.playing) {
                          stop().then((value) {
                     
                         widget.onDelete!();
                         
                          });
                        } else {
                     
                         widget.onDelete!();
                        
                        }
                      },
                    ),
                  ],
                ),
                Text(((_audioPlayer.duration??Duration.zero )- (_audioPlayer.position??Duration.zero)).toString() ),
              ],
            );
          }
        );
      },
    );
  }

  Widget _buildControl() {
    Icon icon;
    Color color;

    if (_audioPlayer.state == ap.PlayerState.playing) {
      icon = const Icon(Icons.pause, color: Colors.red, size: 30);
      color = Colors.red.withOpacity(0.1);
    } else {
      final theme = Theme.of(context);
      icon = Icon(Icons.play_arrow, color: theme.primaryColor, size: 30);
      color = theme.primaryColor.withOpacity(0.1);
    }

    return ClipOval(
      child: Material(
        color: color,
        child: InkWell(
          child:
              SizedBox(width: _controlSize, height: _controlSize, child: icon),
          onTap: () {
            if (_audioPlayer.state == ap.PlayerState.playing) {
              pause();
            } else {
              play();
            }
          },
        ),
      ),
    );
  }

  Widget _buildSlider(double widgetWidth) {
    bool canSetValue = false;
    final duration = _audioPlayer.duration;
    final position = _audioPlayer.position;

    if (duration != null && position != null) {
      canSetValue = position.inMilliseconds > 0;
      canSetValue &= position.inMilliseconds < duration.inMilliseconds;
    }

    double width = widgetWidth - _controlSize - _deleteBtnSize;
    width -= _deleteBtnSize;

    return SizedBox(
      width: width,
      child: Slider(
        activeColor: Theme.of(context).primaryColor,
        inactiveColor: Theme.of(context).colorScheme.secondary,
        onChanged: (v) {
          if (duration != null) {
            final position = v * duration.inMilliseconds;
            _audioPlayer.seek(Duration(milliseconds: position.round()));
          }
        },
        value: canSetValue && duration != null && position != null
            ? position.inMilliseconds / duration.inMilliseconds
            : 0.0,
      ),
    );
  }

  Future<void> play() => _audioPlayer.play();

  Future<void> pause() async {
    await _audioPlayer.pause();
    setState(() {});
  }

  Future<void> stop() async {
    await _audioPlayer.stop();
    setState(() {});
  }

 
}