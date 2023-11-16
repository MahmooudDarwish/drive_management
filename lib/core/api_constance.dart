import 'package:googleapis/drive/v3.dart' as drive;

class ApiConstance {
  static const baseUrl = "https://www.googleapis.com/auth/drive.";
  static const file = "file";

  static const clientId =
      "1096186518013-937419pm99mmmtmicvck0l8k7hgub261.apps.googleusercontent.com";

  static const List<String> scopes = [
    drive.DriveApi.driveFileScope,
  ];
}
