import 'package:bloc/bloc.dart';
import 'package:flutter_spotify_on_play_view_adaptative/list_of_songs.dart';
import 'package:meta/meta.dart';

import 'music_player_state.dart';

class MusicPlayerCubit extends Cubit<MusicPlayerState> {
  MusicPlayerCubit() : super(MusicPlayerState());

  void nextSong() {
    int index;
    if (state.index == ListOfSongs.songs.length - 1) {
      return;
    } else {
      index = state.index + 1;
    }
    emit(state.copyWith(index: index));
  }

  void previousSong() {
    int index;
    if (state.index == 0) {
      return;
    } else {
      index = state.index - 1;
    }
    emit(state.copyWith(index: index));
  }

  void playSong() {
    emit(state.copyWith(index: state.index, isPlaying: true));
  }

  void stopSong() {
    emit(state.copyWith(index: state.index, isPlaying: false));
  }
}
