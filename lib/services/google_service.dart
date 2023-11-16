import 'package:dartz/dartz.dart';
import 'package:driver_management/core/api_constance.dart';
import 'package:driver_management/services/google_http_client.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/drive/v3.dart' as drive;

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

  Future<Either<String, List<drive.File>>> getFiles() async {
    List<drive.File> driveFiles = [];
    try {
      var fileList = await driveApi.files.list();
      for (var file in fileList.files!) {
        final fileTemp = await driveApi.files.get(file.id!,
            $fields: 'id,name,thumbnailLink,iconLink') as drive.File;
        driveFiles.add(fileTemp);
      }
      return Right(driveFiles);
    } catch (error) {
      return Left("Error ${error.toString()}");
    }
  }
}
