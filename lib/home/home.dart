import 'package:driver_management/home/file_item.dart';
import 'package:driver_management/home/cubit/cubit.dart';
import 'package:driver_management/home/cubit/states.dart';
import 'package:driver_management/services/services_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<HomeCubit>()..getFiles(),
      child: const FilesView(),
    );
  }
}

class FilesView extends StatelessWidget {
  const FilesView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: ConditionalBuilder(
            condition: sl<HomeCubit>().driveFiles.isNotEmpty,
            builder: (context) {
              return Scaffold(
                floatingActionButton: FloatingActionButton(
                  onPressed: () {
                    sl<HomeCubit>().uploadFile();
                },
              child: const Icon(Icons.upload, color: Colors.black,)),
                body: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GridView.builder(
                      itemCount: sl<HomeCubit>().driveFiles.length,
                      gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10),
                      itemBuilder: (context, index) {
                        return FileItem(
                            driveFile: sl<HomeCubit>().driveFiles[index]);
                      },
                    )),
              );
            },
            fallback: (context) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        );
      },
    );
  }
}
