import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spotify_on_play_view_adaptative/app_pallete.dart';
import 'package:flutter_spotify_on_play_view_adaptative/cubit/music_player_cubit.dart';
import 'package:flutter_spotify_on_play_view_adaptative/cubit/music_player_state.dart';
import 'package:flutter_spotify_on_play_view_adaptative/list_of_songs.dart';

class AboutArtistSection extends StatelessWidget {
  const AboutArtistSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MusicPlayerCubit, MusicPlayerState>(
      builder: (context, state) => Container(
        decoration: BoxDecoration(color: AppPallete.backgroundContainer, borderRadius: BorderRadius.circular(12.0)),
        height: 350,
        child: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    child: ClipRRect(
                      borderRadius: BorderRadiusGeometry.only(topLeft: Radius.circular(12.0), topRight: Radius.circular(12.0)),
                      child: Image.network(ListOfSongs.songs[state.index].artistImageUrl, fit: BoxFit.cover),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Acerca del artista', style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  ListOfSongs.songs[state.index].artists[0],
                                  style: Theme.of(context).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold),
                                ),
                                Icon(Icons.verified),
                              ],
                            ),
                            Text(
                              ListOfSongs.songs[state.index].monthlyListeners + ' oyentes mensuales',
                              style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      OutlinedButton(
                        onPressed: () {},
                        child: Text('Seguir'),
                        style: OutlinedButton.styleFrom(foregroundColor: Colors.white),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          ListOfSongs.songs[state.index].artistDescription,
                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
