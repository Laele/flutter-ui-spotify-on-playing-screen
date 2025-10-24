import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spotify_on_play_view_adaptative/app_pallete.dart';
import 'package:flutter_spotify_on_play_view_adaptative/const.dart';
import 'package:flutter_spotify_on_play_view_adaptative/cubit/music_player_cubit.dart';
import 'package:flutter_spotify_on_play_view_adaptative/cubit/music_player_state.dart';
import 'package:flutter_spotify_on_play_view_adaptative/list_of_songs.dart';

class LyricsSection extends StatefulWidget {
  const LyricsSection({super.key});

  @override
  State<LyricsSection> createState() => _LyricsSectionState();
}

class _LyricsSectionState extends State<LyricsSection> {
  bool _doSlide = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MusicPlayerCubit, MusicPlayerState>(
      listener: (context, state) {},
      listenWhen: (previous, current) {
        if (previous.index != current.index) {
          _doSlide = !_doSlide;
          return true;
        }
        return false;
      },
      builder: (context, state) => AnimatedSlide(
        duration: Duration(milliseconds: 500),
        offset: _doSlide ? Offset(0, 1) : Offset.zero,
        curve: Curves.easeIn,
        onEnd: () => setState(() {
          _doSlide = false;
        }),
        child: Container(
          height: 300,
          decoration: BoxDecoration(color: ListOfSongs.songs[state.index].backgroundColor, borderRadius: BorderRadius.circular(12.0)),
          child: Padding(
            padding: const EdgeInsets.all(Const.paddingContainer),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Letra', style: Theme.of(context).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold)),
                    Spacer(),
                    IconButton(
                      style: IconButton.styleFrom(foregroundColor: Colors.white, backgroundColor: AppPallete.backgroundContainer, shape: CircleBorder()),
                      onPressed: () {},
                      icon: Icon(Icons.translate),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.ios_share),
                      style: IconButton.styleFrom(foregroundColor: Colors.white, backgroundColor: AppPallete.backgroundContainer, shape: CircleBorder()),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.more_horiz),
                      style: IconButton.styleFrom(foregroundColor: Colors.white, backgroundColor: AppPallete.backgroundContainer, shape: CircleBorder()),
                    ),
                  ],
                ),
                SizedBox(height: Const.verticalColumnSpace),

                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Text(
                          ListOfSongs.songs[state.index].songLyrics,
                          style: Theme.of(
                            context,
                          ).textTheme.titleLarge!.copyWith(color: Colors.white, letterSpacing: 0, wordSpacing: 1.5, height: 2.0, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.start,
                          overflow: TextOverflow.fade,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
