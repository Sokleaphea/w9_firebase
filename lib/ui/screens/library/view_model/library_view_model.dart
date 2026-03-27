import 'package:flutter/material.dart';
import 'package:w9_firebase/data/repositories/artists/artist_repository.dart';
import 'package:w9_firebase/model/artists/artist.dart';
import 'package:w9_firebase/model/songs/song_and_artist.dart';
import '../../../../data/repositories/songs/song_repository.dart';
import '../../../states/player_state.dart';
import '../../../../model/songs/song.dart';
import '../../../utils/async_value.dart';

class LibraryViewModel extends ChangeNotifier {
  final SongRepository songRepository;
  final ArtistRepository artistRepository;
  final PlayerState playerState;

  AsyncValue<List<SongAndArtist>> songsValue = AsyncValue.loading();

  LibraryViewModel({
    required this.songRepository,
    required this.playerState,
    required this.artistRepository,
  }) {
    playerState.addListener(notifyListeners);

    // init
    _init();
  }

  @override
  void dispose() {
    playerState.removeListener(notifyListeners);
    super.dispose();
  }

  void _init() async {
    fetchSong();
  }

  void fetchSong() async {
    // 1- Loading state
    songsValue = AsyncValue.loading();
    notifyListeners();

    try {
      // 2- Fetch is successfull
      List<Song> songs = await songRepository.fetchSongs();
      List<Artist> artists = await artistRepository.fetchArtists();
      List<SongAndArtist> songAndArtist = [];
      for (Song song in songs) {
        for (Artist artist in artists) {
          if (song.artistId == artist.id) {
            songAndArtist.add((SongAndArtist(song: song, artist: artist)));
            break;
          }
        }
      }
      songsValue = AsyncValue.success(songAndArtist);
    } catch (e) {
      // 3- Fetch is unsucessfull
      songsValue = AsyncValue.error(e);
    }
    notifyListeners();
  }

  bool isSongPlaying(SongAndArtist songAndArtist) => playerState.currentSong == songAndArtist.song;

  void start(SongAndArtist songAndArtist) => playerState.start(songAndArtist.song);
  void stop() => playerState.stop();
}
