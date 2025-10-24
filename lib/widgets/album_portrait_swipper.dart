import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spotify_on_play_view_adaptative/const.dart';
import 'package:flutter_spotify_on_play_view_adaptative/cubit/music_player_cubit.dart';
import 'package:flutter_spotify_on_play_view_adaptative/cubit/music_player_state.dart';
import 'package:flutter_spotify_on_play_view_adaptative/list_of_songs.dart';

class AlbumPortraitSwipper extends StatefulWidget {
  const AlbumPortraitSwipper({super.key});

  @override
  State<AlbumPortraitSwipper> createState() => _AlbumPortraitSwipperState();
}

class _AlbumPortraitSwipperState extends State<AlbumPortraitSwipper> {
  final PageController _pageViewController = PageController(viewportFraction: 1);
  bool _isPageChanging = false;

  // Change Song funciton, sets _isPageChanging when it's swtiching song in animation
  void _changeSong(BuildContext context, int index) async {
    _isPageChanging = true;
    try {
      await _pageViewController.animateToPage(index, duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
    } finally {
      _isPageChanging = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MusicPlayerCubit, MusicPlayerState>(
      builder: (context, state) => Expanded(
        child: AnimatedBuilder(
          animation: _pageViewController,
          builder: (context, child) => PageView.builder(
            controller: _pageViewController,
            itemCount: ListOfSongs.songs.length,
            onPageChanged: (value) {
              if (_isPageChanging) {
                return;
              } else {
                if (value < state.index) {
                  context.read<MusicPlayerCubit>().previousSong();
                } else if (value > state.index) {
                  context.read<MusicPlayerCubit>().nextSong();
                }
              }
            },
            itemBuilder: (context, index) {
              // Store the current page from page view controller2
              double currentPage = (_pageViewController.hasClients && _pageViewController.positions.length == 1)
                  ? (_pageViewController.page ?? _pageViewController.initialPage.toDouble())
                  : 0;
              // Store the diffenrece between current page value minus index (this value can be negative)
              final double diff = (currentPage - index);
              // Store the scale to apply as animation , from  .75 to 1 as min value
              final double scale = (1 - (diff.abs() * .25)).clamp(0.75, 1.0);
              // Store opacity value from 0 to 1
              final double opacityValue = (1.0 - diff.abs()).clamp(0.0, 1.0);
              return Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: Const.paddingScreen),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: Const.mainWidgetsMaxWidth),
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: Transform(
                        alignment: Alignment.center,
                        transform: Matrix4.identity()..scale(scale),
                        child: Opacity(
                          opacity: opacityValue,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(Const.borderRadiusContainer),
                            child: Image.network(ListOfSongs.songs[index].albumCoverUrl, fit: BoxFit.cover),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
      listener: (BuildContext context, MusicPlayerState state) {
        _changeSong(context, state.index);
      },
      listenWhen: (previous, current) {
        if (previous.index != current.index) {
          return true;
        }
        return false;
      },
    );
  }
}
