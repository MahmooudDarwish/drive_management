
/*
class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  List<drive.File?> filesList = [];

  Future getFiles() async {
    emit(AppGetFilesLoadingState());
    filesList.clear();
    await fileManager.files.list().then((value) async {
      for (final file in value.files!) {
        final fileTemp = await fileManager.files.get(file.id,
            $fields: 'id,name,thumbnailLink,iconLink') as drive.File;
        filesList.add(fileTemp);
      }
      emit(AppGetFilesSuccessState());
    }).catchError((error) {
      emit(AppGetFilesErrorState());
    });
  }



 */

/*
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

  Future<void> downloadGoogleDriveFileWeb({required String? fileId}) async {
    emit(AppDownloadFileLoadingState());
    final file = await fileManager.files
        .get(fileId, $fields: 'id,name,webContentLink') as drive.File;
    final url = file.webContentLink;

    final downloadLink = html.AnchorElement(href: url);
    downloadLink.download = file.name;
    try {
      html.document.body?.append(downloadLink);
      downloadLink.click();
      downloadLink.remove();
      emit(AppDownloadFileSuccessState());
    } catch (error) {
      emit(AppDownloadFileErrorState());
    }
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

  uploadFileToGoogleDriveWeb() async {
    // Create a file picker dialog box
    emit(AppUploadFileLoadingState());
    final completer = Completer<Stream<List<int>>>();
    final input = html.FileUploadInputElement();
    // Listen for the file selected event

    input.onChange.listen((event) {
      final file = input.files!.first;
      final reader = html.FileReader();

      // Listen for the file read event
      reader.onLoadEnd.listen((event) {
        // Get the bytes from the reader result
        final bytes = reader.result as Uint8List;

        // Convert the bytes to a stream
        final stream = Stream<List<int>>.fromIterable([bytes]);

        completer.complete(stream);
      });

      // Read the file as an array buffer
      reader.readAsArrayBuffer(file);
    });

    // Click the file picker dialog box
    input.click();
    Stream<List<int>> bytes = await completer.future;
    drive.Media media = drive.Media(bytes, await bytes.length);
    final fileUpload = drive.File()..name = input.files![0].name;
    try {
      final uploadedFile = await fileManager.files.create(
        fileUpload,
        uploadMedia: media,
      );

      final fileTemp = await fileManager.files.get(uploadedFile.id,
          $fields: 'id,name,thumbnailLink,iconLink') as drive.File;
      filesList.add(fileTemp);
      emit(AppUploadFileSuccessState());
    } catch (error) {
      emit(AppUploadFileErrorState());
    }
  }

  Map<String?, DroppedImageModel> droppedImages = {};
  Future chooseImage(
      {required DropzoneViewController controller,
      required dynamic event}) async {
    String imageName = event.name;
    final fileStream = controller.getFileStream(event);
    final fileData = await fileStream
        .fold<List<int>>(<int>[], (previous, chunk) => previous..addAll(chunk));
    await uploadImage(fileData: fileData, imageName: imageName);
    emit(AppChooseImageSuccessState());
  }

  Future<String?> searchFolderByName(String folderName) async {
    try {
      final response = await fileManager.files.list(
          q: "mimeType='application/vnd.google-apps.folder' and name='$folderName'");

      if (response.files != null && response.files!.isNotEmpty) {
        // Folder already exists
        return response.files![0].id;
      }
    } catch (e) {
      print("Error searching for folder: $e");
    }
    return null; // Folder not found
  }

  Future<String?> createFolder(String folderName) async {
    try {
      final folder = drive.File()
        ..name = folderName
        ..mimeType = 'application/vnd.google-apps.folder';

      final createdFolder = await fileManager.files.create(folder);
      return createdFolder.id;
    } catch (e) {
      print("Error creating folder: $e");
    }
    return null;
  }

  String? imageId;
  uploadImage({required List<int> fileData, required String imageName}) async {
    emit(AppUploadImageLoadingState());
    String? folderId = await searchFolderByName(driveImagesFolder);
    folderId ??= await createFolder(driveImagesFolder);

    final fileUpload = drive.File()
      ..name = imageName
      ..parents = [folderId!];
    drive.Media media =
        drive.Media(Stream.fromIterable([fileData]), fileData.length);
    try {
      final uploadedFile = await fileManager.files.create(
        fileUpload,
        uploadMedia: media,
      );
      final fileTemp = await fileManager.files
          .get(uploadedFile.id, $fields: 'id,webContentLink') as drive.File;
      imageId = fileTemp.id;
      droppedImages[fileTemp.id] = DroppedImageModel(
          fileData: fileData,
          name: imageName,
          id: fileTemp.id,
          link: fileTemp.webContentLink);

      emit(AppUploadImageSuccessState());
    } catch (error) {
      print(error);
      emit(AppUploadImageErrorState());
    }
    */

 // }
