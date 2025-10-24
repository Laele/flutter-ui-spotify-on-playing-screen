// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spotify_on_play_view_adaptative/cubit/music_player_cubit.dart';
import 'package:flutter_spotify_on_play_view_adaptative/cubit/music_player_state.dart';

import 'package:flutter_spotify_on_play_view_adaptative/utils/double_to_min_sec.dart';

class SongSlider extends StatefulWidget {
  final Duration songDuration;
  final VoidCallback onSongEnd;
  final bool isPlaying;

  const SongSlider({Key? key, required this.songDuration, required this.onSongEnd, required this.isPlaying}) : super(key: key);

  @override
  State<SongSlider> createState() => _SongSliderState();
}

class _SongSliderState extends State<SongSlider> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.songDuration);
  }

  @override
  void didUpdateWidget(SongSlider oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Continue animating in case is playing song and not animating
    if (widget.isPlaying && !_controller.isAnimating) {
      _controller.forward(from: _controller.value);

      // Stop animation in case is not playing and controller was animating
    } else if (!widget.isPlaying && _controller.isAnimating) {
      _controller.stop();
    }

    if (oldWidget.songDuration != widget.songDuration) {
      _controller.duration = widget.songDuration;
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MusicPlayerCubit, MusicPlayerState>(
      listener: (context, state) {
        _controller.value = 0;
      },
      listenWhen: (previous, current) {
        if (previous.index != current.index) {
          return true;
        } else {
          return false;
        }
      },
      builder: (context, state) => AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          final valuePosition = _controller.value * widget.songDuration.inMilliseconds;

          if (_controller.isCompleted) {
            widget.onSongEnd();
            _controller.value = 0;
          }

          return Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Slider(
                      activeColor: Colors.white,
                      allowedInteraction: SliderInteraction.slideOnly,
                      min: 0,
                      max: widget.songDuration.inMilliseconds.toDouble(),
                      value: valuePosition,
                      onChangeStart: (value) {
                        context.read<MusicPlayerCubit>().stopSong();
                      },
                      onChangeEnd: (value) {
                        context.read<MusicPlayerCubit>().playSong();
                      },
                      onChanged: (value) {
                        _controller.value = value / widget.songDuration.inMilliseconds;
                      },
                      padding: EdgeInsets.zero,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    doubleTominSec((_controller.value * widget.songDuration.inMilliseconds).toInt()).toString(),
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  Spacer(),
                  Text(
                    doubleTominSec((widget.songDuration.inMilliseconds - (_controller.value * widget.songDuration.inMilliseconds)).toInt()).toString(),
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
