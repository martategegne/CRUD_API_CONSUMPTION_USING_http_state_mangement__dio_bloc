import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'services/api_service.dart';
import 'repository/post_repository.dart';

import 'bloc/post/post_bloc.dart';
import 'bloc/post/post_event.dart';

import 'screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Dependency setup
    final repository = PostRepository(ApiService());

    return BlocProvider(
      create: (_) => PostBloc(repository)..add(LoadPosts()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Digital Time Capsule',

        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),

        home: const HomeScreen(),
      ),
    );
  }
}