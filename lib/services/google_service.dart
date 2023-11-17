import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:driver_management/core/api_constance.dart';
import 'package:driver_management/services/google_http_client.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/drive/v3.dart' as drive;
import 'package:path_provider/path_provider.dart';

class GoogleService {
  final _googleSignIn = GoogleSignIn(scopes: ApiConstance.scopes);

  late GoogleSignInAccount? user;
  late drive.DriveApi driveApi;

  Future<Either<String, GoogleSignInAccount?>> login() async {
    try {
      user = await _googleSignIn.signIn();
      var authHeaders = (await user!.authHeaders);
      driveApi = drive.DriveApi(GoogleHttpClient(authHeaders));
      return Right(user);
    } catch (error) {
      return Left("Error ${error.toString()}");
    }
  }

  Future<Either<String, GoogleSignInAccount?>> logout() async {
    try {
      user = await _googleSignIn.disconnect();
      return Right(user);
    } catch (error) {
      return Left("Error ${error.toString()}");
    }
  }

  Future<drive.File> getFileById({required String fileId}) async {
    return await driveApi.files
        .get(fileId, $fields: 'id,name,thumbnailLink,iconLink') as drive.File;
  }

  Future<Either<String, List<drive.File>>> getFiles() async {
    List<drive.File> driveFiles = [];
    try {
      var fileList = await driveApi.files.list();
      for (var file in fileList.files!) {
        final fileTemp = await getFileById(fileId: file.id!);
        driveFiles.add(fileTemp);
      }
      return Right(driveFiles);
    } catch (error) {
      return Left("Error ${error.toString()}");
    }
  }

  Future<Either<String, DeleteFile>> deleteFile(
      {required String fileId}) async {
    try {
      await driveApi.files.delete(fileId);
      //its better to return enum rather than string in this situation
      return const Right(DeleteFile.deleted);
    } catch (error) {
      return Left("Error ${error.toString()}");
    }
  }

  Future<String> downloadFile(
      {required String? fileName, required String? fileId}) async {
    drive.Media file = await driveApi.files.get(fileId!,
        downloadOptions: drive.DownloadOptions.fullMedia) as drive.Media;

    final directory = await getExternalStorageDirectory();
    final saveFile = File('${directory?.path}/$fileName');
    List<int> dataStore = [];
    file.stream.listen((data) {
      dataStore.insertAll(dataStore.length, data);
    }, onDone: () async {
      saveFile.writeAsBytes(dataStore);
    });
    return saveFile.path;
  }
}

enum DeleteFile { deleted }
