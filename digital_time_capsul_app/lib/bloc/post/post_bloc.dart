import 'package:flutter_bloc/flutter_bloc.dart';
import 'post_event.dart';
import 'post_state.dart';
import '../../repository/post_repository.dart';
import '../../models/post_model.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final PostRepository repository;

  List<Post> currentPosts = [];

  PostBloc(this.repository) : super(PostInitial()) {

    on<LoadPosts>((event, emit) async {
      emit(PostLoading());
      try {
        final posts = await repository.fetchPosts();
        currentPosts = posts;
        emit(PostLoaded(List.from(currentPosts)));
      } catch (e) {
        emit(PostError(e.toString()));
      }
    });

    on<AddPost>((event, emit) async {
      try {
        final createdPost = await repository.addPost(event.post);

        currentPosts.insert(0, createdPost);

        await repository.saveToCache(currentPosts);

        emit(PostLoaded(List.from(currentPosts)));

      } catch (e) {
        emit(PostError(e.toString()));
      }
    });

    on<UpdatePostEvent>((event, emit) async {
      try {
        final updatedPost = await repository.updatePost(event.post);

        final index =
            currentPosts.indexWhere((p) => p.id == event.post.id);

        if (index != -1) {
          currentPosts[index] = updatedPost;
        }

        await repository.saveToCache(currentPosts);

        emit(PostLoaded(List.from(currentPosts)));

      } catch (e) {
        emit(PostError(e.toString()));
      }
    });

    on<DeletePostEvent>((event, emit) async {
      try {
        await repository.deletePost(event.id);

        currentPosts =
            currentPosts.where((post) => post.id != event.id).toList();

        await repository.saveToCache(currentPosts);

        emit(PostLoaded(List.from(currentPosts)));

      } catch (e) {
        emit(PostError(e.toString()));
      }
    });
  }
}