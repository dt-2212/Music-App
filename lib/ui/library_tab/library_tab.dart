import 'package:flutter/material.dart';
import 'package:music_app/ui/library_tab/widgets/feature_card.dart';
import 'package:music_app/ui/library_tab/widgets/play_list.dart';
import 'package:music_app/ui/library_tab/widgets/recent.dart';

class LibraryTab extends StatelessWidget {
  const LibraryTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thư viện',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
              icon: const Icon(Icons.search), onPressed: () {}, color: Colors.black),
          const SizedBox(width: 10)
        ],
      ),
      body: const Padding(
        padding: EdgeInsets.all(8),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [Expanded(child: ListFeatureCard())],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [Expanded(child: RecentList())],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [Expanded(child: Playlist())],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
