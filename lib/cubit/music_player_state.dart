import 'package:equatable/equatable.dart';

class MusicPlayerState extends Equatable {
  final int index;
  final bool isPlaying;

  const MusicPlayerState({this.index = 0, this.isPlaying = false});

  MusicPlayerState copyWith({int? index, bool? isPlaying, int? secPaused}) {
    return MusicPlayerState(index: index ?? this.index, isPlaying: isPlaying ?? this.isPlaying);
  }

  @override
  List<Object> get props => [index, isPlaying];
}
