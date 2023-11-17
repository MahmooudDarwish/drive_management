import 'package:equatable/equatable.dart';

abstract class HomeStates extends Equatable {
  const HomeStates();
}

class HomeInitialState extends HomeStates {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

/// Get States
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

/// Delete states
class DeleteDriveFileLoadingState extends HomeStates {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class DeleteDriveFileSuccessState extends HomeStates {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class DeleteDriveFileErrorState extends HomeStates {
  final String errorMessage;
  const DeleteDriveFileErrorState({required this.errorMessage});
  @override
  List<Object?> get props => [errorMessage];
}

/// Download states
class DownloadDriveFileLoadingState extends HomeStates {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class DownloadDriveFileSuccessState extends HomeStates {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class DownloadDriveFileErrorState extends HomeStates {
  final String errorMessage;
  const DownloadDriveFileErrorState({required this.errorMessage});
  @override
  List<Object?> get props => [errorMessage];
}

/// Upload states
class UploadDriveFileLoadingState extends HomeStates {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class UploadDriveFileSuccessState extends HomeStates {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class UploadDriveFileErrorState extends HomeStates {
  final String errorMessage;
  const UploadDriveFileErrorState({required this.errorMessage});
  @override
  List<Object?> get props => [errorMessage];
}
