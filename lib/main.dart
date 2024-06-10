import 'package:bloc_flutter/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'blocs/user_list/user_list_bloc.dart';

void main(){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}): super(key:key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (context) =>UserListBloc())],
      child:MaterialApp(
        title: 'CRUD using bloc',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Welcome(),
        debugShowCheckedModeBanner: false,

      )
    );
  }
}