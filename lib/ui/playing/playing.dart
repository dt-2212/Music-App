import 'dart:math';

import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_app/ui/playing/player_manager.dart';

import '../../data/model/song.dart';

class NowPlaying extends StatelessWidget {
  const NowPlaying({super.key, required this.playingSong, required this.songs});

  final Song playingSong;
  final List<Song> songs;

  @override
  Widget build(BuildContext context) {
    return NowPlayingPage(
      songs: songs,
      playingSong: playingSong,
    );
  }
}

class NowPlayingPage extends StatefulWidget {
  const NowPlayingPage(
      {super.key, required this.songs, required this.playingSong});

  final Song playingSong;
  final List<Song> songs;

  @override
  State<NowPlayingPage> createState() => _NowPlayingPageState();
}

class _NowPlayingPageState extends State<NowPlayingPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _imageAnimController;
  late AudioPlayerManager _audioPlayerManager;
  late int _selectedIndex;
  late Song _song;
  late double _currentAnimation;
  bool _shuffle=false;
  late LoopMode _loopMode;






  @override
  void initState() {
    super.initState();
    _currentAnimation = 0.0;
    _song = widget.playingSong;
    _imageAnimController = AnimationController(vsync: this, duration: const Duration(milliseconds: 12000));
    _audioPlayerManager = AudioPlayerManager(songUrl: _song.source);
    _audioPlayerManager.init();
    _selectedIndex = widget.songs.indexOf(widget.playingSong);
    _loopMode = LoopMode.off;
  }

  @override
  Widget build(BuildContext context) {

    // return const Scaffold(
    //   body: Center(
    //     child: Text('Now Playing'),
    //   ),
    // );
    final screenWidth = MediaQuery.of(context).size.width;
    const delta = 64;
    final radius = (screenWidth - delta) / 2;
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: const Text('Now Playing'),
          trailing: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_horiz),
          ),
        ),
        child: Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(_song.album),
                const SizedBox(
                  height: 16,
                ),
                const Text('_ ___ _'),
                const SizedBox(
                  height: 48,
                ),
                RotationTransition(
                  turns:
                      Tween(begin: 0.0, end: 1.0).animate(_imageAnimController),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(radius),
                    child: FadeInImage.assetNetwork(
                      placeholder: 'assets/music.png',
                      image: _song.image,
                      width: screenWidth - delta,
                      height: screenWidth - delta,
                      imageErrorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          'assets/music.png',
                          width: screenWidth - delta,
                          height: screenWidth - delta,
                        );
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 64, bottom: 16),
                  child: SizedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.share_outlined),
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        Column(
                          children: [
                            Text(_song.title),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                              _song.artist,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .color,
                                  ),
                            ),
                          ],
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.favorite_outline),
                          color: Theme.of(context).colorScheme.primary,
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 32,
                    left: 24,
                    right: 24,
                    bottom: 16,
                  ),
                  child: _progressBar(),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 24,
                    right: 24,
                  ),
                  child: _mediaButtons(),
                ),
              ],
            ),
          ),
        ));
  }

  @override
  void dispose() {
    _audioPlayerManager.dispose();
    _imageAnimController.dispose();
    super.dispose();
  }

  Widget _mediaButtons() {
    return SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          MediaButtonControl(
              function: _setShuffle,
              icon: Icons.shuffle,
              color: _getShuffleColor(),
              size: 24),
          MediaButtonControl(
              function: _setPrevSong,
              icon: Icons.skip_previous,
              color: Colors.deepPurple,
              size: 36),
          // const MediaButtonControl(
          //     function: null,
          //     icon: Icons.play_arrow_sharp,
          //     color: Colors.deepPurple,
          //     size: 48,),
          _playButton(),

          MediaButtonControl(
              function: _setNextSong,
              icon: Icons.skip_next,
              color: Colors.deepPurple,
              size: 36),
          MediaButtonControl(
              function: _setRepeat,
              icon: _repeatIcon(),
              color: _getRepeatIconColor(),
              size: 24),
        ],
      ),
    );
  }

  StreamBuilder<DurationState> _progressBar() {
    return StreamBuilder<DurationState>(
        stream: _audioPlayerManager.durationState,
        builder: (context, snapshot) {
          final durationState = snapshot.data;
          final progress = durationState?.progress ?? Duration.zero;
          final buffered = durationState?.buffered ?? Duration.zero;
          final total = durationState?.total ?? Duration.zero;
          return ProgressBar(
            progress: progress,
            total: total,
            buffered: buffered,
            onSeek: _audioPlayerManager.player.seek,
            barHeight: 5.0,
            barCapShape: BarCapShape.round,
            baseBarColor: Colors.grey.withOpacity(0.3),
            progressBarColor: Colors.blue,
            bufferedBarColor: Colors.grey.withOpacity(0.3),
            thumbColor: Colors.deepPurple,
            thumbGlowColor: Colors.blueGrey.withOpacity(0.3),
            thumbRadius: 10.0,
          );
        });
  }

  StreamBuilder<PlayerState> _playButton() {
    return StreamBuilder(
      stream: _audioPlayerManager.player.playerStateStream,
      builder: (context, snapshot) {
        final playState = snapshot.data;
        final processingState = playState?.processingState;
        final playing = playState?.playing;
        if (processingState == ProcessingState.loading ||
            processingState == ProcessingState.buffering) {
          _pauseAnim();
          return Container(
            margin: const EdgeInsets.all(8),
            width: 48,
            height: 48,
            child: const CircularProgressIndicator(),
          );
        } else if (playing != true) {
          return MediaButtonControl(
              function: () {
                // start or resume animation
                _audioPlayerManager.player.play();
              },
              icon: Icons.play_arrow,
              color: null,
              size: 48);
        } else if (processingState != ProcessingState.completed) {
          _playAnim();
          return MediaButtonControl(
              function: () {
                _audioPlayerManager.player.pause();
                _pauseAnim();
              },
              icon: Icons.pause,
              color: null,
              size: 48);
        } else {
          if(processingState == ProcessingState.completed){
            _stopAnim();
            _resetAnim();
          }
          return MediaButtonControl(
              function: () {
                _resetAnim();
                _audioPlayerManager.player.seek(Duration.zero);
              },
              icon: Icons.replay,
              color: null,
              size: 48);
        }
      },
    );
  }

//============================================================================== Tiến/lùi bài hát
  void _setNextSong(){
    if(_shuffle){
      var random = Random();
      _selectedIndex = random.nextInt(widget.songs.length);
    } else if(_selectedIndex < widget.songs.length-1) {
      ++ _selectedIndex;
    } else if (_loopMode == LoopMode.all && _selectedIndex == widget.songs.length-1){
      _selectedIndex = 0;
    }
    if(_selectedIndex >= widget.songs.length){
      _selectedIndex = _selectedIndex%widget.songs.length;
    }
    final nextSong = widget.songs[_selectedIndex];
    _audioPlayerManager.updateSongUrl(nextSong.source);
    setState(() {
      _song= nextSong;
    });
  _resetAnim();
  }


  void _setPrevSong(){
    if(_shuffle){
      var random = Random();
      _selectedIndex = random.nextInt(widget.songs.length);
    } else if (_selectedIndex > 0) {
      -- _selectedIndex;
    } else if (_loopMode == LoopMode.all && _selectedIndex == 0){
      _selectedIndex = widget.songs.length-1;
    }
    if(_selectedIndex < 0){
      _selectedIndex = (-1*_selectedIndex)%widget.songs.length;
    }
    final nextSong = widget.songs[_selectedIndex];
    _audioPlayerManager.updateSongUrl(nextSong.source);
    setState(() {
      _song= nextSong;
    });
  _resetAnim();
  }
//==============================================================================
  void _playAnim(){    //  hàm chạy animation
    _imageAnimController.forward(from: _currentAnimation);
    _imageAnimController.repeat();
  }
  void _pauseAnim(){   //  dừng animation
    _stopAnim();
    _currentAnimation = _imageAnimController.value;
  }
  void _stopAnim(){
    _imageAnimController.stop();
  }
  void _resetAnim(){
    _currentAnimation = 0.0;
    _imageAnimController.value = _currentAnimation;
  }
//============================================================================== Random bài hát
  void _setShuffle(){
    setState(() {
      _shuffle = !_shuffle;
    });
  }
  Color? _getShuffleColor(){
    return _shuffle ? Colors.deepPurple : Colors.grey;
  }
//============================================================================== Lặp bài hát

  void _setRepeat(){
      if(_loopMode == LoopMode.off){
        _loopMode = LoopMode.one;
      } else if(_loopMode == LoopMode.one){
        _loopMode = LoopMode.all;
      } else {
        _loopMode = LoopMode.off;
      }
      setState(() {
        _audioPlayerManager.player.setLoopMode(_loopMode);
      });
  }

  IconData _repeatIcon() {
    switch (_loopMode) {
      case LoopMode.one:
        return Icons.repeat_one;
      case LoopMode.all:
        return Icons.repeat_on;
      default:
        return Icons.repeat;
    }
  }


  Color? _getRepeatIconColor(){
    return _loopMode == LoopMode.off
        ? Colors.grey
        : Colors.deepPurple;
  }
//==============================================================================


}

class MediaButtonControl extends StatefulWidget {
  const MediaButtonControl(
      {super.key,
      required this.function,
      required this.icon,
      required this.color,
      required this.size});

  final void Function()? function;
  final IconData icon;
  final double? size;
  final Color? color;

  @override
  State<StatefulWidget> createState() {
    return _MediaButtonControlState();
  }
}

class _MediaButtonControlState extends State<MediaButtonControl> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: widget.function,
      icon: Icon(widget.icon),
      iconSize: widget.size,
      color: widget.color ?? Theme.of(context).colorScheme.primary,
    );
  }
}
