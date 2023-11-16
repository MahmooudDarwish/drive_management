import 'package:equatable/equatable.dart';

class DriveFile extends Equatable {
  final String? thumbnailLink;
  final String? iconLink;
  final String? name;
  final String? id;

  const DriveFile(
      {required this.thumbnailLink,
      required this.iconLink,
      required this.name,
      required this.id});
  @override
  List<Object?> get props => [thumbnailLink, iconLink, name, id];
}
