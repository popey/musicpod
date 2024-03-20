import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yaru/yaru.dart';

import '../../build_context_x.dart';
import '../../common.dart';
import '../../data.dart';
import '../../theme.dart';
import '../../theme_data_x.dart';

class AudioTileImage extends ConsumerWidget {
  const AudioTileImage({
    super.key,
    this.audio,
    required this.size,
  });
  final Audio? audio;
  final double size;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final iconSize = size / (1.65);
    final theme = context.t;
    IconData iconData;
    if (audio?.audioType == AudioType.radio) {
      iconData = Iconz().radio;
    } else if (audio?.audioType == AudioType.podcast) {
      iconData = Iconz().podcast;
    } else {
      iconData = Iconz().musicNote;
    }
    if (audio?.pictureData != null) {
      return Image.memory(
        filterQuality: FilterQuality.medium,
        fit: BoxFit.cover,
        audio!.pictureData!,
        height: size,
      );
    } else {
      if (audio?.imageUrl != null || audio?.albumArtUrl != null) {
        return SafeNetworkImage(
          url: audio?.imageUrl ?? audio?.albumArtUrl,
          height: size,
          fit: BoxFit.cover,
        );
      } else {
        return Center(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                colors: [
                  getAlphabetColor(
                    audio?.title ?? audio?.album ?? 'a',
                  ).scale(
                    lightness: theme.isLight ? 0 : -0.4,
                    saturation: -0.5,
                  ),
                  getAlphabetColor(
                    audio?.title ?? audio?.album ?? 'a',
                  ).scale(
                    lightness: theme.isLight ? -0.1 : -0.2,
                    saturation: -0.5,
                  ),
                ],
              ),
            ),
            width: size,
            height: size,
            child: Icon(
              iconData,
              size: iconSize,
              color: contrastColor(
                getAlphabetColor(
                  audio?.title ?? audio?.album ?? 'a',
                ),
              ),
            ),
          ),
        );
      }
    }
  }
}
