import 'dart:io';

import 'package:driver_management/core/toasts.dart';
import 'package:driver_management/home/cubit/states.dart';
import 'package:driver_management/home/model/drive_file.dart';
import 'package:driver_management/services/google_service.dart';
import 'package:driver_management/services/services_locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:file_picker/file_picker.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitialState());

  /// Get files
  List<DriveFile> driveFiles = [];

  void getFiles() async {
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
  void deleteFile({required String fileId}) async {
    emit(DeleteDriveFileLoadingState());

    final result = await sl<GoogleService>().deleteFile(fileId: fileId);

    result.fold(
        (leftError) => emit(DeleteDriveFileErrorState(errorMessage: leftError)),
        (rightFileDeleted) {
      driveFiles.removeWhere((element) => element.id == fileId);
      emit(DeleteDriveFileSuccessState());
    });
  }

  /// Download file
  void downloadFile({required String fileId, required String fileName}) async {
    emit(DownloadDriveFileLoadingState());

    try {
      String fileDownloadedPath = await sl<GoogleService>()
          .downloadFile(fileId: fileId, fileName: fileName);
      //to save it in the gallery
      if (fileDownloadedPath.contains(".jpg") ||
          fileDownloadedPath.contains(".png")) {
        saveImageInGallery(fileDownloadedPath: fileDownloadedPath);
      }
      emit(DownloadDriveFileSuccessState());
    } catch (error) {
      showToast(message: error.toString(), state: ToastState.error);
      emit(DownloadDriveFileErrorState(
          errorMessage: "Error ${error.toString()}"));
    }
  }

  void saveImageInGallery({required String fileDownloadedPath}) async {
    await ImageGallerySaver.saveFile(fileDownloadedPath);
  }

  /// Upload file
  void uploadFile() async {
    emit(UploadDriveFileLoadingState());
    var pickFile = await FilePicker.platform.pickFiles();
    String? path = pickFile?.files.first.path;
    File selectedFile = File('$path');

    if (pickFile != null) {
      var result = await sl<GoogleService>()
          .uploadFile(selectedFile: selectedFile, filePickerResult: pickFile);

      result.fold((leftError) {
        showToast(message: leftError, state: ToastState.error);
        emit(UploadDriveFileErrorState(errorMessage: leftError));
      }, (rightUploadedFile) {
        driveFiles.add(DriveFile(
            thumbnailLink: rightUploadedFile.thumbnailLink,
            iconLink: rightUploadedFile.iconLink,
            name: rightUploadedFile.name,
            id: rightUploadedFile.id));
        emit(UploadDriveFileSuccessState());
      });
    }
  }
}
