import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movies_app/core/components/listview_card.dart';
import 'package:movies_app/core/components/loading_indicator.dart';
import 'package:movies_app/core/components/vertical_listview.dart';
import 'package:movies_app/core/global/app_string/app_string.dart';
import 'package:movies_app/core/network/api_constance.dart';
import 'package:movies_app/core/utils/enum.dart';
import 'package:movies_app/movies/domain/entities/movie.dart';
import 'package:movies_app/movies/presentation/controller/movies_bloc.dart';
import 'package:movies_app/movies/presentation/controller/movies_events.dart';
import 'package:movies_app/movies/presentation/controller/movies_states.dart';
import 'package:movies_app/movies/presentation/screens/movie_details_screen.dart';
import 'package:movies_app/movies/presentation/screens/see_more.dart';
import 'package:shimmer/shimmer.dart';

class TopRatedMoviesWidget extends StatelessWidget {
  const TopRatedMoviesWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MoviesBloc, MoviesStates>(
      buildWhen: (previous, current) =>
          previous.topRatedStates != current.topRatedStates,
      builder: (context, state) {
        switch (state.topRatedStates) {
          case RequestState.loading:
            return const SizedBox(
                height: 170, child: Center(child: CircularProgressIndicator()));
          case RequestState.loaded:
            return Column(
              children: [
                Container(
                  margin: const EdgeInsets.fromLTRB(
                    16.0,
                    24.0,
                    16.0,
                    8.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppString.topRated,
                        style: GoogleFonts.poppins(
                          fontSize: 19,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.15,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                              builder: (BuildContext context) {
                            return SeeMoreScreen(
                                movieList: state.topRatedMovies,
                                title: AppString.topRated);
                          }));
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Text(
                                AppString.seeMore,
                                style: TextStyle(color: Colors.white),
                              ),
                              Icon(
                                color: Colors.white,
                                Icons.arrow_forward_ios,
                                size: 16.0,
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                FadeIn(
                  duration: const Duration(milliseconds: 500),
                  child: SizedBox(
                    height: 170.0,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      itemCount: state.topRatedMovies.length,
                      itemBuilder: (context, index) {
                        final movie = state.topRatedMovies[index];
                        return Container(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MovieDetailsScreen(
                                    movieID: movie.id,
                                  ),
                                ),
                              );
                            },
                            child: ClipRRect(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(8.0)),
                              child: CachedNetworkImage(
                                height: double.infinity,
                                width: 120.0,
                                fit: BoxFit.cover,
                                imageUrl:
                                    ApiConstance.imageURL(movie.backdropPath),
                                placeholder: (context, url) =>
                                    Shimmer.fromColors(
                                  baseColor: Colors.grey[850]!,
                                  highlightColor: Colors.grey[800]!,
                                  child: Container(
                                    height: 170.0,
                                    width: 120.0,
                                    decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                  ),
                                ),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            );
          case RequestState.error:
            return SizedBox(
                height: 400, child: Center(child: Text(state.topRatedMessage)));
        }
      },
    );
  }
}

class TopRatedWidget extends StatelessWidget {
  const TopRatedWidget({
    required this.movies,
    super.key,
  });

  final List<Movies> movies;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MoviesBloc, MoviesStates>(
      builder: (context, state) {
        return VerticalListView(
          itemCount: movies.length + 1,
          itemBuilder: (context, index) {
            if (index < movies.length) {
              return VerticalListViewCard(movies: movies[index]);
            } else {
              return const LoadingIndicator();
            }
          },
          addEvent: () {
            context.read<MoviesBloc>().add(FetchMoreTopRatedMoviesEvent());
          },
        );
      },
    );
  }
}
