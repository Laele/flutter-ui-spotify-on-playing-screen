import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spotify_on_play_view_adaptative/cubit/music_player_cubit.dart';
import 'package:flutter_spotify_on_play_view_adaptative/cubit/music_player_state.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MusicPlayerCubit, MusicPlayerState>(
      builder: (context, state) => PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(onPressed: () {}, icon: Icon(Icons.arrow_drop_down)),
            Text('Reproduciendo canción index ${state.index}', style: Theme.of(context).textTheme.titleMedium),
            IconButton(onPressed: () {}, icon: Icon(Icons.more_horiz)),
          ],
        ),
      ),
    );
  }
}
