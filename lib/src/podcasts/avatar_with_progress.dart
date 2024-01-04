import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../build_context_x.dart';
import '../../common.dart';
import '../../data.dart';
import '../../player.dart';
import '../../theme.dart';
import 'audio_progress.dart';

class AvatarWithProgress extends StatelessWidget {
  const AvatarWithProgress({
    super.key,
    required this.selected,
    required this.lastPosition,
    required this.audio,
    required this.pause,
    required this.resume,
    required this.safeLastPosition,
    required this.play,
    required this.removeUpdate,
  });

  final bool selected;
  final Duration? lastPosition;
  final Audio audio;
  final void Function() pause;
  final Future<void> Function() resume;
  final void Function() safeLastPosition;
  final Future<void> Function({Audio? newAudio, Duration? newPosition}) play;
  final void Function()? removeUpdate;

  @override
  Widget build(BuildContext context) {
    final theme = context.t;
    bool? playing;
    if (selected) {
      playing = context.select((PlayerModel m) => m.isPlaying);
    }
    return Stack(
      alignment: Alignment.center,
      children: [
        AudioProgress(
          selected: selected,
          lastPosition: lastPosition,
          duration: audio.durationMs == null
              ? null
              : Duration(milliseconds: audio.durationMs!.toInt()),
        ),
        CircleAvatar(
          radius: avatarIconSize,
          backgroundColor: selected
              ? theme.colorScheme.primary.withOpacity(0.08)
              : theme.colorScheme.onSurface.withOpacity(0.09),
          child: IconButton(
            icon: (playing == true && selected)
                ? Icon(
                    Iconz().pause,
                  )
                : Padding(
                    padding: appleStyled
                        ? const EdgeInsets.only(left: 3)
                        : EdgeInsets.zero,
                    child: Icon(Iconz().playFilled),
                  ),
            onPressed: () {
              if (selected) {
                if (playing == true) {
                  pause();
                } else {
                  resume();
                }
              } else {
                safeLastPosition();
                play(newAudio: audio, newPosition: lastPosition);
                removeUpdate?.call();
              }
            },
          ),
        ),
      ],
    );
  }
}
