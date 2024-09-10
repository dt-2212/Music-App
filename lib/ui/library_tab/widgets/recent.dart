import 'package:flutter/material.dart';

class RecentList extends StatelessWidget {
  const RecentList({super.key});

  @override
  Widget build(BuildContext context) {
    const List<String> titles = [
      'Bài Hát Nghe\nGần Đây',
      'V-Pop',
      'Thanh Âm\nIndie Buồn',
      'US-UK',
      'Rap Việt\nCực Chất',
    ];

    const List<String> images = [
      'assets/images/recent_1.png',
      'assets/images/recent_2.jpg',
      'assets/images/recent_3.jpg',
      'assets/images/recent_4.jpg',
      'assets/images/recent_5.png',
    ];

    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text('Nghe gần đây',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const Spacer(),
              IconButton(
                  onPressed: () {}, icon: const Icon(Icons.read_more_outlined, size: 32))
            ],
          ),
          SizedBox(
            height: 180,
            width: MediaQuery.of(context).size.width - 16,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: titles.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            image: DecorationImage(
                              image: AssetImage(images[index]),
                              fit: BoxFit.cover,
                            ),
                            color: Colors.white),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        titles[index],
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
