import 'package:equatable/equatable.dart';

abstract class HomeStates extends Equatable {
  const HomeStates();
}

class HomeInitialState extends HomeStates {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class GetDriveFilesLoadingState extends HomeStates {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class GetDriveFilesSuccessState extends HomeStates {
  @override
  List<Object?> get props => throw UnimplementedError();
}


class GetDriveFilesErrorState extends HomeStates {
  final String errorMessage;
  const GetDriveFilesErrorState({required this.errorMessage});
  @override
  List<Object?> get props => [errorMessage];
}
