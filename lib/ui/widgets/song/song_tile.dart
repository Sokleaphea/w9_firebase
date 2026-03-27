import 'package:flutter/material.dart';
import 'package:w9_firebase/model/songs/song_and_artist.dart';


class SongTile extends StatelessWidget {
  const SongTile({
    super.key,
    required this.songAndArtist,
    required this.isPlaying,
    required this.onTap,
  });

  final SongAndArtist songAndArtist;
  final bool isPlaying;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15)
        ),
        child: ListTile(
          onTap: onTap,
          title: Text(songAndArtist.song.title),
          subtitle: Row(
            children: [
              Text("${songAndArtist.song.duration.inMinutes} mins"),
              SizedBox(width: 20),
              Text(songAndArtist.artist.name),
              SizedBox(width: 20),
              Text(songAndArtist.artist.genre),
            ],
          ),
          leading: CircleAvatar(backgroundImage: NetworkImage(songAndArtist.song.imageUrl.toString())),
          trailing: Text(
            isPlaying ? "Playing" : "",
            style: TextStyle(color: Colors.amber),
          ),
        ),
      ),
    );
  }
}
