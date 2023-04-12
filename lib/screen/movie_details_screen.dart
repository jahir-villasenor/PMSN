import 'package:flutter/material.dart';
import 'package:practica1/responsive.dart';
import 'package:practica1/models/actor_model.dart';
import 'package:practica1/models/popular_model.dart';
import 'package:practica1/network/api_popular.dart';
import 'package:practica1/widgets/actor_card_info.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MovieDetailScreen extends StatelessWidget {
  ApiPopular apiPopular = ApiPopular();

  final PopularModel popularModel;
  MovieDetailScreen({Key? key, required this.popularModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.green,
        title: Text(popularModel.title!),
      ),
      body: Hero(
        tag: popularModel.id!,
        child: Responsive(
          mobile: _buildMobileLayout(context),
          tablet: _buildTabletLayout(context),
          desktop: _buildDesktopLayout(context),
        ),
      ),
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height,
                  child: Stack(
                    children: [
                      FutureBuilder(
                        future: apiPopular.getIdVideo(popularModel.id!),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return YoutubePlayer(
                              controller: YoutubePlayerController(
                                initialVideoId: snapshot.data!,
                                flags: YoutubePlayerFlags(
                                  autoPlay: false,
                                  mute: false,
                                  controlsVisibleAtStart: true,
                                ),
                              ),
                              showVideoProgressIndicator: true,
                              progressIndicatorColor: Colors.red,
                            );
                          } else {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: SingleChildScrollView(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    'https://image.tmdb.org/t/p/w500/' +
                        popularModel.backdropPath!,
                  ),
                  fit: BoxFit.cover,
                  opacity: 0.4,
                ),
              ),
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    popularModel.title!,
                    style: TextStyle(
                      color: Colors.yellow,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.star,
                        color: Colors.yellow,
                      ),
                      SizedBox(width: 10),
                      Text(
                        popularModel.voteAverage!.toString(),
                        style: TextStyle(
                          color: Colors.yellow,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    'Sinopsis',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    popularModel.overview!,
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Actores',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  FutureBuilder<List<ActorModel>?>(
                    future: apiPopular.getAllAuthors(popularModel),
                    builder: (context, snapshot) {
                      if (snapshot.hasData && snapshot.data != null) {
                        return SizedBox(
                          height: 150,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              ActorModel actor = snapshot.data![index];
                              return ActorCard(
                                name: actor.name!,
                                photoUrl:
                                    'https://image.tmdb.org/t/p/original${actor.profilePath}',
                              );
                            },
                          ),
                        );
                      } else {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  'https://image.tmdb.org/t/p/w500/' +
                      popularModel.backdropPath!,
                ),
                fit: BoxFit.fill,
                opacity: 0.3,
              ),
            ),
            padding: EdgeInsets.fromLTRB(20, 30, 20, 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(padding: EdgeInsets.all(5)),
                Text(
                  popularModel.title!,
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.star,
                      color: Colors.yellow.shade200,
                    ),
                    SizedBox(width: 10),
                    Text(
                      popularModel.voteAverage!.toString() + '/100',
                      style: TextStyle(
                        color: Colors.yellow.shade200,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Text(
                  'Sinopsis',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  popularModel.overview!,
                  style: TextStyle(
                    fontSize: 15,
                  ),
                  textAlign: TextAlign.justify,
                ),
                SizedBox(height: 30),
                Text(
                  'Actores',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                FutureBuilder<List<ActorModel>?>(
                  future: apiPopular.getAllAuthors(popularModel),
                  builder: (context, snapshot) {
                    if (snapshot.hasData && snapshot.data != null) {
                      return SizedBox(
                        height: 150,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            ActorModel actor = snapshot.data![index];
                            return ActorCard(
                              name: actor.name!,
                              photoUrl:
                                  'https://image.tmdb.org/t/p/original${actor.profilePath}',
                            );
                          },
                        ),
                      );
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
                FutureBuilder(
                  future: apiPopular.getIdVideo(popularModel.id!),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return YoutubePlayer(
                        controller: YoutubePlayerController(
                          initialVideoId: snapshot.data.toString(),
                          flags: YoutubePlayerFlags(
                            autoPlay: false,
                            mute: false,
                            controlsVisibleAtStart: true,
                          ),
                        ),
                        showVideoProgressIndicator: true,
                        progressIndicatorColor: Colors.red,
                      );
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabletLayout(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(
                          'https://image.tmdb.org/t/p/w500/' +
                              popularModel.posterPath!,
                        ),
                        fit: BoxFit.cover,
                        opacity: 0.4),
                  ),
                  height: MediaQuery.of(context).size.height,
                  child: Stack(
                    children: [
                      FutureBuilder(
                        future: apiPopular.getIdVideo(popularModel.id!),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return YoutubePlayer(
                              controller: YoutubePlayerController(
                                initialVideoId: snapshot.data.toString(),
                                flags: YoutubePlayerFlags(
                                  autoPlay: false,
                                  mute: false,
                                  controlsVisibleAtStart: true,
                                ),
                              ),
                              showVideoProgressIndicator: true,
                              progressIndicatorColor: Colors.red,
                            );
                          } else {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: SingleChildScrollView(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    'https://image.tmdb.org/t/p/w500/' +
                        popularModel.backdropPath!,
                  ),
                  fit: BoxFit.cover,
                  opacity: 0.4,
                ),
              ),
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    popularModel.title!,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.star,
                        color: Colors.yellow,
                      ),
                      SizedBox(width: 10),
                      Text(
                        popularModel.voteAverage!.toString(),
                        style: TextStyle(
                          color: Colors.yellow,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    'Sinopsis',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    popularModel.overview!,
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Actores',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  FutureBuilder<List<ActorModel>?>(
                    future: apiPopular.getAllAuthors(popularModel),
                    builder: (context, snapshot) {
                      if (snapshot.hasData && snapshot.data != null) {
                        return SizedBox(
                          height: 150,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              ActorModel actor = snapshot.data![index];
                              return ActorCard(
                                name: actor.name!,
                                photoUrl:
                                    'https://image.tmdb.org/t/p/original${actor.profilePath}',
                              );
                            },
                          ),
                        );
                      } else {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
