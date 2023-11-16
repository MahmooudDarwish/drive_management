
import 'package:flutter/material.dart';


/*
class FilesScreen extends StatelessWidget {
  const FilesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      builder: (context, state) {
        return Center(
          child: ConditionalBuilder(
            condition: false,
            fallback: (context) {
              return Scaffold(
                body:
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GridView.builder(
                      itemCount: cubit.filesList.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: kIsWeb ? 5 : 2,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10),
                      itemBuilder: (context, index) {
                        return fileItem(cubit.filesList, index, context);
                      },
                    ))
                ,
                floatingActionButton: FloatingActionButton(
                    onPressed: () {
                      if (kIsWeb) {
                        cubit.uploadFileToGoogleDriveWeb();
                      } else {
                        cubit.uploadFileToGoogleDriveAndroid();
                      }
                    },
                    child: Icon(Icons.upload)),
              );
            },
            builder: (context) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        );
      },
      listener: (context, state) {},
    );
  }

  Widget fileItem(List<drive.File?> filesList, int index, context) {
    return Stack(
      alignment: AlignmentDirectional.topStart,
      children: [
        Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Image.network(
              height: 170,
              filesList[index]?.thumbnailLink != null
                  ? "${filesList[index]?.thumbnailLink}"
                  : "https://img.freepik.com/premium-vector/computer-folder-icon-flat-style-document-archive-vector-illustration-isolated-background-portfolio-sign-business-concept_157943-1342.jpg?w=740",
              errorBuilder: (context, error, stackTrace) {
                return Image.network(
                  height: 170,
                  //fit: BoxFit.cover,
                  filesList[index]?.iconLink != null
                      ? "${filesList[index]?.iconLink}"
                      : "https://img.freepik.com/premium-vector/computer-folder-icon-flat-style-document-archive-vector-illustration-isolated-background-portfolio-sign-business-concept_157943-1342.jpg?w=740",
                  errorBuilder: (context, error, stackTrace) {
                    return Image.network(
                        height: 170,
                        "https://img.freepik.com/premium-vector/computer-folder-icon-flat-style-document-archive-vector-illustration-isolated-background-portfolio-sign-business-concept_157943-1342.jpg?w=740");
                  },
                );
              },
            ),
            Container(
                height: 60,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      "${filesList[index]?.name}",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                color: Colors.grey[300]),
          ],
        ),
        Row(
          children: [
            IconButton(
                onPressed: () {
                  AppCubit.get(context)
                      .deleteFiles(fileId: filesList[index]!.id);
                },
                icon: Icon(
                  Icons.delete,
                  size: 20,
                  color: Colors.black,
                )),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: IconButton(
                  onPressed: () {
                    if (kIsWeb) {
                      AppCubit.get(context).downloadGoogleDriveFileWeb(
                          fileId: filesList[index]!.id);
                    } else {
                      AppCubit.get(context).downloadGoogleDriveFileAndroid(
                          fileName: filesList[index]!.name,
                          fileId: filesList[index]!.id);
                    }
                  },
                  icon: Icon(
                    Icons.download,
                    size: 20,
                    color: Colors.black,
                  )),
            ),
          ],
        )
      ],
    );
  }
}
*/
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("home"),
    );
  }
}
