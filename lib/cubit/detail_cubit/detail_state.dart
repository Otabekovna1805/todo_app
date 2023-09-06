part of 'detail_cubit.dart';

@immutable
abstract class DetailState {}

class DetailInitial extends DetailState {}
class DetailFailure extends DetailState {
  final String message;
  DetailFailure({required this.message});
}

class DetailLoading extends DetailState {}
class DetailCreateSuccess extends DetailState {}
class DetailDeleteSuccess extends DetailState {}
class DetailUpdateSuccess extends DetailState {}
class DetailReadSuccess extends DetailState {}
