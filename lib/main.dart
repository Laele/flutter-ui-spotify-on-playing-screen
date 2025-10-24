import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spotify_on_play_view_adaptative/const.dart';
import 'package:flutter_spotify_on_play_view_adaptative/cubit/music_player_cubit.dart';
import 'package:flutter_spotify_on_play_view_adaptative/widgets/about_artist_widget.dart';
import 'package:flutter_spotify_on_play_view_adaptative/widgets/album_portrait_swipper.dart';
import 'package:flutter_spotify_on_play_view_adaptative/widgets/appbar_widget.dart';
import 'package:flutter_spotify_on_play_view_adaptative/widgets/music_controller_widget.dart';
import 'package:flutter_spotify_on_play_view_adaptative/widgets/lyrics_widget.dart';
import 'package:flutter_spotify_on_play_view_adaptative/widgets/screen_background_widget.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return DevicePreview(
      builder: (context) =>
          MaterialApp(useInheritedMediaQuery: true, title: 'Material App', theme: ThemeData.dark(), home: _HomeScreen(), debugShowCheckedModeBanner: false),
    );
    //return MaterialApp(title: 'Material App', theme: ThemeData.dark(), home: _HomeScreen(), debugShowCheckedModeBanner: false);
  }
}

class _HomeScreen extends StatelessWidget {
  const _HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      // Music Controller Cubit
      create: (context) => MusicPlayerCubit(),
      child: Scaffold(
        body: SingleChildScrollView(
          // Screen Backgorund using album portrait main color
          child: ScreenBackground(
            child: SafeArea(
              child: Column(
                children: [
                  // Custom AppBar
                  CustomAppBar(),

                  // Container using remaining space of the device screen minus fixed height space to show Lyrics widget
                  SizedBox(
                    height:
                        MediaQuery.of(context).size.height -
                        kToolbarHeight -
                        MediaQuery.of(context).padding.top -
                        //MediaQuery.of(context).padding.bottom -
                        Const.verticalWidgetSpace -
                        Const.paddingContainer -
                        48,
                    child: Column(
                      children: [
                        SizedBox(height: Const.verticalWidgetSpace),
                        // Album Portrair Image
                        AlbumPortraitSwipper(),

                        SizedBox(height: Const.verticalWidgetSpace),

                        // Music Controller ( Song Info, Swipper, Buttons)
                        MusicController(),
                      ],
                    ),
                  ),

                  ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: Const.mainWidgetsMaxWidth),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: Const.paddingScreen),
                      child: Column(
                        children: [
                          SizedBox(height: Const.verticalWidgetSpace),
                          // Lyrics
                          LyricsSection(),
                          SizedBox(height: Const.verticalWidgetSpace),
                          // About Artist
                          AboutArtistSection(),
                          SizedBox(height: Const.verticalWidgetSpace),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
