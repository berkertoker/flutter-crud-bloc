import 'package:bloc_flutter/blocs/user_list/user_list_bloc.dart';
import 'package:bloc_flutter/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
State<Welcome> createState() => _Welcome();
}

class _Welcome extends State<Welcome> {
  String capitalize(String input) {
  if (input.isEmpty) return input;
  return input[0].toUpperCase() + input.substring(1).toLowerCase();
  }

  UserListBloc userListBloc(BuildContext context) {
    return BlocProvider.of<UserListBloc>(context);
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  static Widget buildTextField({
    required TextEditingController controller,
    required String hint,
  }) =>
      Padding(
        padding: const EdgeInsets.all(12.0),
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hint,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      );


  void showBottomSheet({
    required BuildContext context,
    bool isEdit =false,
    required int id,
  }) =>
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context){
          return Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                buildTextField(controller: nameController, hint: 'Ener Name'),
                buildTextField(controller: emailController, hint: 'Enter Email'),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed:(){
                      final user = User(
                        name: nameController.text,
                        email: emailController.text,
                        id: id,
                      );
                      if(isEdit){
                        userListBloc(context).add(UpdateUser(user: user));
                      }else{
                        userListBloc(context).add(AddUser(user: user));
                      }
                      Navigator.pop(context);
                    }, 
                    child: Text(isEdit ? 'Update' : 'Add User'),
                  ),

                )
              ]
            ),
        
          );
        }
      );


  Widget buildUserTile(BuildContext context, User user){
    return ListTile(
      title: Text(capitalize(nameController.text)),
      subtitle: Text(user.email),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed:(){
              userListBloc(context).add(DeleteUser(user: user));         
            }, 
            icon: const Icon(Icons.delete, size: 30,color: Colors.red,)        
          ),
          IconButton(
            onPressed:(){
              nameController.text = user.name;
              emailController.text = user.email;
              showBottomSheet(context: context, id: user.id, isEdit:true);        
            }, 
            icon: const Icon(Icons.edit, size: 30,color: Colors.green,)        
          ),
        ],
      ),
    );
  }
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Crud Using Bloc')),
    floatingActionButton: ElevatedButton(
      onPressed: () {
        final state = userListBloc(context).state;
        final id = state.users.length +1;
        showBottomSheet(context: context, id: id);
      },
      child: const Text('Add User'),
    ),
    body: BlocBuilder<UserListBloc, UserListState>(
      builder: (context, state){
        if(state is UserListUpdated && state.users.isNotEmpty){
          final users = state.users;
          return ListView.builder(
            itemCount: users.length,
            itemBuilder:(context, index){
              final user = users[index];
              return buildUserTile(context,user);
            },
          );
        }
        else{
          return const SizedBox(
            width: double.infinity,
            child: Center(child:Text('No users found')),
          );
        }
      },
    ),
  );
}
