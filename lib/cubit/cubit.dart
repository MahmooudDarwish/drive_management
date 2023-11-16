/*
class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  Future deleteFiles({required String? fileId}) async {
    loadingScreen = true;
    emit(AppDeleteFileLoadingState());
    await fileManager.files.delete(fileId!).then((value) {
      filesList.removeWhere((element) => element?.id == fileId);
      loadingScreen = false;

      emit(AppDeleteFileSuccessState());
    }).catchError((error) {
      emit(AppDeleteFileErrorState());
    });
  }

  Future<void> downloadGoogleDriveFileAndroid(
      {required String? fileName, required String? fileId}) async {
    emit(AppDownloadFileLoadingState());
    drive.Media file = await fileManager.files.get(fileId!,
        downloadOptions: drive.DownloadOptions.fullMedia) as drive.Media;
    final directory = await getExternalStorageDirectory();
    final saveFile = File('${directory?.path}/$fileName');
    List<int> dataStore = [];
    file.stream.listen((data) {
      dataStore.insertAll(dataStore.length, data);
    }, onDone: () {
      saveFile.writeAsBytes(dataStore);
      emit(AppDownloadFileSuccessState());
    }, onError: (error) {
      emit(AppDownloadFileErrorState());
    });
  }

  uploadFileToGoogleDriveAndroid() async {
    drive.File fileToUpload = drive.File();
    var result = await FilePicker.platform.pickFiles();
    emit(AppUploadFileLoadingState());
    String? path = result?.files.first.path;
    File selectedFile = File('$path');
    final media = drive.Media(
      selectedFile.openRead(),
      result?.files.first.size,
    );
    fileToUpload.name = result?.files.first.name;
    await fileManager.files
        .create(
      fileToUpload,
      uploadMedia: media,
    )
        .then((value) {
      getFiles();
      emit(AppUploadFileSuccessState());
    }).catchError((error) {
      emit(AppUploadFileErrorState());
    });


 }
*/