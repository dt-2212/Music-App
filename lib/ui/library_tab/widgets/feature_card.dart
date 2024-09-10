import 'package:flutter/material.dart';

class FeatureCard extends StatelessWidget {
  const FeatureCard({
    super.key,
    required this.icon,
    required this.title,
    required this.count,
    required this.color,
  });

  final IconData icon;
  final String title;
  final String count;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 32, color: color),
          const SizedBox(height: 10),
          Text(
            title,
            style: const TextStyle(
                fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 5),
          Text(
            count,
            style: const TextStyle(
                fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black87),
          ),
        ],
      ),
    );
  }
}

class ListFeatureCard extends StatelessWidget {
  const ListFeatureCard({super.key});

  @override
  Widget build(BuildContext context) {
    const List<String> titles = [
      'Yêu thích',
      'Đã tải',
      'Upload',
      'MV',
      'Nghệ sĩ',
    ];
    const List<String> counts = [
      '7',
      '999+',
      '12',
      '',
      '2',
    ];
    const List<IconData> icons = [
      Icons.favorite,
      Icons.downloading,
      Icons.cloud_upload_rounded,
      Icons.video_collection,
      Icons.queue_music,
    ];
    const List<Color> colors = [
      Colors.red,
      Colors.green,
      Colors.blue,
      Colors.orange,
      Colors.purple,
    ];
    return SizedBox(
      height: 140,
      width: MediaQuery.of(context).size.width - 16,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: titles.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: FeatureCard(
              icon: icons[index],
              title: titles[index],
              count: counts[index],
              color: colors[index],
            ),
          );
        },
      ),
    );
  }
}
