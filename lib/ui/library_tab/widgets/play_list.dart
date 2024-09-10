import 'package:flutter/material.dart';

class Playlist extends StatelessWidget {
  const Playlist({super.key});

  @override
  Widget build(BuildContext context) {
    const List<String> playlistTitles = [
      'Chill Hits',
      'Sơn Tùng M-TP',
      'HIEUTHUHAI',
      "Today's V-pop Hits",
      'Guitar',
      'Piano',
      'Lofi Hits',
    ];

    const List<String> playlistSubtitles = [
      'Music app',
      'Music app',
      '',
      '',
      '',
      '',
      '',
    ];

    const List<String> playlistImages = [
      'assets/images/chill.jpg',
      'assets/images/mtp.jpg',
      'assets/images/hieut2.jpg',
      'assets/images/vpop.jpg',
      'assets/images/guitar.jpg',
      'assets/images/piano.jpg',
      'assets/images/lofi.jpg',
    ];

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text('Playlist',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(width: 20),
                const Text('Album',
                    style: TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey)),
                const Spacer(),
                IconButton(
                    onPressed: () {}, icon: const Icon(Icons.more_horiz, size: 32)),
              ],
            ),
            Column(
              children: List.generate(playlistTitles.length, (index) {
                return ListTile(
                  contentPadding: const EdgeInsets.symmetric(vertical: 8.0),
                  leading: Container(
                    width: 80,
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      image: DecorationImage(
                        image: AssetImage(playlistImages[index]),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  title: Text(
                    playlistTitles[index],
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(playlistSubtitles[index]),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
