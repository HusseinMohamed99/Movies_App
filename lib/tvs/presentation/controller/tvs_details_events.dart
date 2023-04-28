import 'package:equatable/equatable.dart';

abstract class TvsDetailsEvent extends Equatable {
  const TvsDetailsEvent();
}

class GetTvsDetailsEvent extends TvsDetailsEvent {
  final int movieID;

  const GetTvsDetailsEvent(this.movieID);

  @override
  List<Object?> get props => [movieID];
}
//
// class GetTvsRecommendationEvent extends TvsDetailsEvent {
//   final int id;
//
//   const GetTvsRecommendationEvent(this.id);
//
//   @override
//   List<Object> get props => [id];
// }
//
// class GetTvsSimilarEvent extends TvsDetailsEvent {
//   final int id;
//
//   const GetTvsSimilarEvent(this.id);
//
//   @override
//   List<Object> get props => [id];
// }
