import 'package:dio/dio.dart';

class ApiService {
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: 'https://dummyjson.com',
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 5),
    ),
  );

  // GET posts
  Future<Response> getPosts() async {
    return await dio.get('/posts');
  }

  // CREATE post
  Future<Response> createPost(Map<String, dynamic> data) async {
    return await dio.post('/posts/add', data: data);
  }

  // UPDATE post
  Future<Response> updatePost(int id, Map<String, dynamic> data) async {
    return await dio.put('/posts/$id', data: data);
  }

  // DELETE post
  Future<Response> deletePost(int id) async {
    return await dio.delete('/posts/$id');
  }
}