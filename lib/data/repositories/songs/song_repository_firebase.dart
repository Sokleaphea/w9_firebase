import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../model/songs/song.dart';
import '../../dtos/song_dto.dart';
import 'song_repository.dart';

class SongRepositoryFirebase extends SongRepository {
  static final Uri baseUri = Uri.https(
    'w8-practice-53cd2-default-rtdb.asia-southeast1.firebasedatabase.app',
  );
  static final Uri songUri = baseUri.replace(path: 'songs.json');

  @override
  Future<List<Song>> fetchSongs() async {
    final http.Response response = await http.get(songUri);

    if (response.statusCode == 200) {
      // 1 - Send the retrieved list of songs
      // List<dynamic> songJson = json.decode(response.body);
      Map<String, dynamic> songJson = json.decode(response.body);
      List<Song> result = [];
      for (var iterable in songJson.entries) {
        result.add(SongDto.fromJson(iterable.key, iterable.value));
      }
      return result;
    } else {
      // 2- Throw expcetion if any issue
      throw Exception('Failed to load posts');
    }
  }

  @override
  Future<Song?> fetchSongById(String id) async {}
}
