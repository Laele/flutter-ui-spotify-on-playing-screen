import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spotify_on_play_view_adaptative/app_pallete.dart';
import 'package:flutter_spotify_on_play_view_adaptative/cubit/music_player_cubit.dart';
import 'package:flutter_spotify_on_play_view_adaptative/cubit/music_player_state.dart';
import 'package:flutter_spotify_on_play_view_adaptative/list_of_songs.dart';

class ScreenBackground extends StatelessWidget {
  final Widget child;
  const ScreenBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MusicPlayerCubit, MusicPlayerState>(
      builder: (context, state) => AnimatedContainer(
        duration: Duration(milliseconds: 100),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [ListOfSongs.songs[state.index].backgroundColor, AppPallete.backgroundScreen],
            stops: [0.0, 0.55],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: child,
      ),
    );
  }
}
