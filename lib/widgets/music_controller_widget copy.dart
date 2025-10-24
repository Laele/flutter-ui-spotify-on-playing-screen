import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spotify_on_play_view_adaptative/const.dart';
import 'package:flutter_spotify_on_play_view_adaptative/cubit/music_player_cubit.dart';
import 'package:flutter_spotify_on_play_view_adaptative/cubit/music_player_state.dart';
import 'package:flutter_spotify_on_play_view_adaptative/list_of_songs.dart';
import 'package:flutter_spotify_on_play_view_adaptative/utils/double_to_min_sec.dart';
import 'package:flutter_spotify_on_play_view_adaptative/widgets/music_action_button_widget.dart';

class MusicController extends StatefulWidget {
  const MusicController({super.key});

  @override
  State<MusicController> createState() => _MusicControllerState();
}

class _MusicControllerState extends State<MusicController> {
  double _songSliderValue = 0.0;
  Timer? _songTimer;

  void fakePlayingSong(BuildContext context) async {
    final musicPlayerCubit = context.read<MusicPlayerCubit>();
    final songDuration = ListOfSongs.songs[context.read<MusicPlayerCubit>().state.index].durationInSeconds.toDouble() * 1000;

    _songTimer?.cancel();

    _songTimer = Timer.periodic(Duration(milliseconds: 100), (t) {
      if (musicPlayerCubit.state.isPlaying) {
        setState(() {
          _songSliderValue += 100;

          if (_songSliderValue >= songDuration) {
            musicPlayerCubit.nextSong();
            _songSliderValue = 0.0;
            t.cancel();
          }
        });
      } else {
        t.cancel();
        return;
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _songTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MusicPlayerCubit, MusicPlayerState>(
      listenWhen: (previous, current) {
        if (previous.index != current.index || previous.isPlaying != current.isPlaying) {
          return true;
        }
        return false;
      },
      listener: (context, state) {
        if (state.isPlaying) {
          context.read<MusicPlayerCubit>().playSong();
          fakePlayingSong(context);
        } else {
          _songTimer?.cancel();
        }
        _songSliderValue = 0;
      },
      builder: (context, state) => ConstrainedBox(
        constraints: BoxConstraints(maxWidth: Const.mainWidgetsMaxWidth),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Const.paddingScreen),
          child: Column(
            children: [
              Row(
                children: [
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: BorderSide.none,
                      backgroundColor: const Color.fromARGB(255, 31, 31, 31),
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () {},
                    child: Row(children: [Icon(Icons.ondemand_video), SizedBox(width: 8.0), Text('Cambiar a video')]),
                  ),
                ],
              ),
              SizedBox(height: Const.verticalColumnSpace),
              // Song , Artist Name
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Flexible(
                              child: Text(
                                ListOfSongs.songs[state.index].title,
                                style: Theme.of(context).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold, overflow: TextOverflow.ellipsis),
                                maxLines: 1,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: Const.verticalColumnSpace),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Flexible(
                              child: Text(
                                ListOfSongs.songs[state.index].artists.join(', '),
                                style: Theme.of(context).textTheme.bodyMedium!.copyWith(overflow: TextOverflow.ellipsis),
                                maxLines: 1,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.task_alt),
                    style: IconButton.styleFrom(backgroundColor: Colors.green),
                  ),
                ],
              ),

              SizedBox(height: Const.verticalColumnSpace),

              // Song Slider
              Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Slider(
                          activeColor: Colors.white,
                          allowedInteraction: SliderInteraction.slideOnly,
                          min: 0,
                          max: ListOfSongs.songs[state.index].durationInSeconds.toDouble() * 1000,
                          value: _songSliderValue,
                          onChanged: (value) {
                            setState(() {
                              _songSliderValue = value;
                            });
                          },
                          padding: EdgeInsets.zero,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(doubleTominSec(_songSliderValue.toInt()), style: Theme.of(context).textTheme.bodySmall),
                      Spacer(),
                      Text(
                        doubleTominSec(ListOfSongs.songs[state.index].durationInSeconds * 1000 - _songSliderValue.toInt()),
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: Const.verticalColumnSpace),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MusicActionButton(icon: Icon(Icons.shuffle)),
                  MusicActionButton(
                    icon: Icon(Icons.skip_previous),
                    onPressed: () {
                      context.read<MusicPlayerCubit>().previousSong();
                    },
                  ),
                  IconButton(
                    style: IconButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      iconSize: 44,
                      padding: EdgeInsets.all(0),
                      minimumSize: Size(64, 64),
                    ),
                    onPressed: () {
                      if (state.isPlaying) {
                        context.read<MusicPlayerCubit>().stopSong();
                      } else {
                        context.read<MusicPlayerCubit>().playSong();
                      }
                      fakePlayingSong(context);
                    },
                    icon: state.isPlaying ? Icon(Icons.pause) : Icon(Icons.play_arrow),
                  ),
                  MusicActionButton(
                    icon: Icon(Icons.skip_next_sharp),
                    onPressed: () {
                      context.read<MusicPlayerCubit>().nextSong();
                    },
                  ),
                  MusicActionButton(icon: Icon(Icons.repeat)),
                ],
              ),
              SizedBox(height: Const.verticalColumnSpace),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(onPressed: () {}, icon: Icon(Icons.speaker)),
                  Spacer(),

                  IconButton(onPressed: () {}, icon: Icon(Icons.ios_share)),
                  IconButton(onPressed: () {}, icon: Icon(Icons.menu)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
