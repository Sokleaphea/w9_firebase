import 'dart:convert';

import 'package:w9_firebase/data/dtos/artist_dto.dart';
import 'package:w9_firebase/data/repositories/artists/artist_repository.dart';
import 'package:w9_firebase/model/artists/artist.dart';
import 'package:http/http.dart' as http;

class ArtistRepositoryFirebase extends ArtistRepository {
  static final Uri baseUri = Uri.https(
    'w8-practice-53cd2-default-rtdb.asia-southeast1.firebasedatabase.app',
  );
  static final Uri artistUri = baseUri.replace(path: 'artists.json');

  @override
  Future<List<Artist>> fetchArtists() async {
    final http.Response response = await http.get(artistUri);

    if (response.statusCode == 200) {
      Map<String, dynamic> artistJson = json.decode(response.body);
      List<Artist> results = [];
      for (var iterable in artistJson.entries) {
        results.add(ArtistDto.fromJson(iterable.key, iterable.value));
      }
      return results;
    } else {
      throw Exception('Failed to load posts');
    }
  }
  @override
  Future<Artist?> fetchArtistById(String id) async {}
}
