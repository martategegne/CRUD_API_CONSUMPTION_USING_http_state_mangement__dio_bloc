import 'package:equatable/equatable.dart';
import '../../models/post_model.dart';

abstract class PostEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadPosts extends PostEvent {}

class AddPost extends PostEvent {
  final Post post;

  AddPost(this.post);

  @override
  List<Object?> get props => [post];
}

class UpdatePostEvent extends PostEvent {
  final Post post;

  UpdatePostEvent(this.post);

  @override
  List<Object?> get props => [post];
}

class DeletePostEvent extends PostEvent {
  final int id;

  DeletePostEvent(this.id);

  @override
  List<Object?> get props => [id];
}