import 'package:driver_management/home/cubit/cubit.dart';
import 'package:driver_management/home/cubit/states.dart';
import 'package:driver_management/home/model/drive_file.dart';
import 'package:driver_management/services/services_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FileItem extends StatelessWidget {
  final DriveFile driveFile;

  const FileItem({super.key, required this.driveFile});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Stack(
          alignment: AlignmentDirectional.topStart,
          children: [
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Image.network(
                  height: 170,
                  driveFile.thumbnailLink != null
                      ? "${driveFile.thumbnailLink}"
                      : "https://img.freepik.com/premium-vector/computer-folder-icon-flat-style-document-archive-vector-illustration-isolated-background-portfolio-sign-business-concept_157943-1342.jpg?w=740",
                  errorBuilder: (context, error, stackTrace) {
                    return Image.network(
                      height: 170,
                      //fit: BoxFit.cover,
                      driveFile.iconLink != null
                          ? "${driveFile.iconLink}"
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
                    color: Colors.grey[300],
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          driveFile.name ?? "default title",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    )),
              ],
            ),
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      sl<HomeCubit>().deleteFile(fileId: driveFile.id!);
                    },
                    icon: const Icon(
                      Icons.delete,
                      size: 20,
                      color: Colors.black,
                    )),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: IconButton(
                      onPressed: () {
                        sl<HomeCubit>().downloadFile(
                            fileId: driveFile.id!, fileName: driveFile.name!);
                      },
                      icon: const Icon(
                        Icons.download,
                        size: 20,
                        color: Colors.black,
                      )),
                ),
              ],
            )
          ],
        );
      },
    );
  }
}
