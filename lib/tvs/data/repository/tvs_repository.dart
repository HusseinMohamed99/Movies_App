import 'package:movies_app/core/error/exceptions.dart';
import 'package:movies_app/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:movies_app/tvs/data/datasource/tv_remote_data_source.dart';
import 'package:movies_app/tvs/domain/entities/tvs.dart';
import 'package:movies_app/tvs/domain/repository/base_tvs_repository.dart';

class TvsRepository extends BaseTvRepository {
  final BaseTvRemoteDataSource baseTvRemoteDataSource;

  TvsRepository({required this.baseTvRemoteDataSource});

  @override
  Future<Either<Failure, List<Tvs>>> getOnTheAirTv() async {
    final result = await baseTvRemoteDataSource.getOnTheAirTvs();
    try {
      return Right(result);
    } on ServerException catch (failure) {
      return Left(
          ServerFailure(message: failure.errorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, List<Tvs>>> getAiringTodayTvs() async {
    final result = await baseTvRemoteDataSource.getAiringTodayTvs();
    try {
      return Right(result);
    } on ServerException catch (failure) {
      return Left(
          ServerFailure(message: failure.errorMessageModel.statusMessage));
    }
  }

// @override
// Future<Either<Failure, List<Movies>>> getUpcomingMovies() async {
//   final result = await baseMovieRemoteDataSource.getUpcomingMovies();
//   try {
//     return Right(result);
//   } on ServerException catch (failure) {
//     return Left(
//         ServerFailure(message: failure.errorMessageModel.statusMessage));
//   }
// }
//
// @override
// Future<Either<Failure, List<Movies>>> getPopularMovies() async {
//   final result = await baseMovieRemoteDataSource.getPopularMovies();
//   try {
//     return Right(result);
//   } on ServerException catch (failure) {
//     return Left(
//         ServerFailure(message: failure.errorMessageModel.statusMessage));
//   }
// }
//
// @override
// Future<Either<Failure, List<Movies>>> getTopRatedMovies() async {
//   final result = await baseMovieRemoteDataSource.getTopRatedMovies();
//   try {
//     return Right(result);
//   } on ServerException catch (failure) {
//     return Left(
//         ServerFailure(message: failure.errorMessageModel.statusMessage));
//   }
// }
//
// @override
// Future<Either<Failure, MovieDetails>> getMovieDetails(
//     MovieDetailsParameters parameters) async {
//   final result = await baseMovieRemoteDataSource.getMovieDetails(parameters);
//   try {
//     return Right(result);
//   } on ServerException catch (failure) {
//     return Left(
//         ServerFailure(message: failure.errorMessageModel.statusMessage));
//   }
// }
//
// @override
// Future<Either<Failure, List<MoviesRecommendation>>> getMovieRecommendation(
//     MovieRecommendationParameters parameters) async {
//   final result =
//       await baseMovieRemoteDataSource.getMovieRecommendation(parameters);
//   try {
//     return Right(result);
//   } on ServerException catch (failure) {
//     return Left(
//         ServerFailure(message: failure.errorMessageModel.statusMessage));
//   }
// }
//
// @override
// Future<Either<Failure, List<MoviesSimilar>>> getMovieSimilar(
//     MovieSimilarParameters parameters) async {
//   final result = await baseMovieRemoteDataSource.getMovieSimilar(parameters);
//   try {
//     return Right(result);
//   } on ServerException catch (failure) {
//     return Left(
//         ServerFailure(message: failure.errorMessageModel.statusMessage));
//   }
// }
}
