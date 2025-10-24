import 'dart:ui';

final class SongEntity {
  final Color backgroundColor;
  final String title;
  final List<String> artists;
  final int durationInSeconds;
  final String albumCoverUrl;
  final String monthlyListeners;
  final String artistDescription;
  final String songLyrics;
  final String artistImageUrl;
  SongEntity({
    required this.artistImageUrl,
    required this.backgroundColor,
    required this.songLyrics,
    required this.monthlyListeners,
    required this.artistDescription,
    required this.title,
    required this.artists,
    required this.durationInSeconds,
    required this.albumCoverUrl,
  });
}
