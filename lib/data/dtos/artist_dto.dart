import '../../model/artists/artist.dart';

class ArtistDto {
  static const String artistNameKey = "name";
  static const String genreKey = "genre";
  static const String imageUrlKey = "imageUrl";

  static Artist fromJson(String id, Map<String, dynamic> json) {
    assert(json[artistNameKey] is String);
    assert(json[genreKey] is String);
    assert(json[imageUrlKey] is String);
    return Artist(
      id: id,
      name: json[artistNameKey],
      genre: json[genreKey],
      imageUrl: Uri.parse(json[imageUrlKey])
    );
  }

  Map<String, dynamic> toJson(Artist artist) {
    return {
      artistNameKey: artist.name,
      genreKey: artist.genre,
      imageUrlKey: artist.imageUrl.toString(),
    };
  }
}
