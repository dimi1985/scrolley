import 'package:flutter/material.dart';
import 'package:scrolley/models/movie.dart';
import 'package:scrolley/utils/api.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MoviePoster extends StatefulWidget {
  final Movie movie;
  const MoviePoster({super.key, required this.movie});

  @override
  State<MoviePoster> createState() => _MoviePosterState();
}

class _MoviePosterState extends State<MoviePoster> {
  late YoutubePlayerController _controller =
      YoutubePlayerController(initialVideoId: '');
  late bool showImage;

  @override
  void initState() {
    super.initState();
    showImage = true;
    _loadVideo();
  }

  void _loadVideo() async {
    await Future.delayed(const Duration(seconds: 3));

    try {
      final video = await Api.fetchFirstMovieVideo(widget.movie.id);
      _controller = YoutubePlayerController(
        initialVideoId: video.key,
        flags: const YoutubePlayerFlags(
          hideThumbnail: true,
          controlsVisibleAtStart: false,
          disableDragSeek: false,
          useHybridComposition: true,
          loop: true,
          autoPlay: true,
          mute: true,
        ),
      );
      setState(() {
        showImage = false;
      });
    } catch (e) {
      print('Failed to load video: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: widget.movie.title.isNotEmpty
            ? Text(widget.movie.title)
            : const Text('Movie App'),
      ),
      body: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.black,
              Colors.black,
            ],
            stops: [0.0, 0.6],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Stack(
              children: [
                AnimatedOpacity(
                  duration: const Duration(seconds: 5),
                  opacity: showImage ? 1.0 : 0.0,
                  child: Image.network(
                    'https://image.tmdb.org/t/p/w500/${widget.movie.posterPath}',
                    fit: BoxFit.fill,
                    height: double.infinity,
                    width: double.infinity,
                  ),
                ),
                AnimatedOpacity(
                  duration: const Duration(seconds: 5),
                  opacity: showImage ? 0.0 : 1.0,
                  child: showImage
                      ? Container()
                      : SizedBox(
                          height: double.infinity,
                          child: YoutubePlayer(
                            controller: _controller,
                            aspectRatio: 16 / 9,
                          ),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
