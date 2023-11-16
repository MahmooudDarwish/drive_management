import 'package:driver_management/home/cubit/states.dart';
import 'package:driver_management/home/model/drive_file.dart';
import 'package:driver_management/services/google_service.dart';
import 'package:driver_management/services/services_locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitialState());

  /// Get files
  List<DriveFile> driveFiles = [];

  Future getFiles() async {
    emit(GetDriveFilesLoadingState());

    final result = await sl<GoogleService>().getFiles();

    result.fold(
        (leftError) => emit(GetDriveFilesErrorState(errorMessage: leftError)),
        (rightDriveFiles) {
      for (var element in rightDriveFiles) {
        driveFiles.add(DriveFile(
            thumbnailLink: element.thumbnailLink,
            iconLink: element.iconLink,
            name: element.name,
            id: element.id));
      }
      emit(GetDriveFilesSuccessState());
    });
  }

  /// Delete file

  /// Upload file

  /// download file
}
