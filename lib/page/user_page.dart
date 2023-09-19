import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tect_ggf/model/user_model.dart';

import '../bloc/bloc/users_bloc.dart';

class UserPage extends StatelessWidget {
  const UserPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController updateController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Data Users"),
      ),
      body: BlocConsumer<UsersBloc, UsersState>(
        listener: (context, state) {
          if (state is UsersFailed) {
            SnackBar(content: Text(state.e));
          }
        },
        builder: (context, state) {
          if (state is UsersLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is UsersSuccess) {
            return ListView.builder(
                itemCount: state.users.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(state.users[index].name.toString()),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  contentPadding: const EdgeInsets.all(20),
                                  title: const Text(
                                      "Apakah Anda Yakin Ingin Menghapus ? "),
                                  actions: [
                                    ElevatedButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text("Batal")),
                                    ElevatedButton(
                                        onPressed: () {
                                          context.read<UsersBloc>().add(
                                              UserDeleteDataUser(
                                                  request: UserModel(
                                                      id: state
                                                          .users[index].id)));
                                          Navigator.pop(context);
                                        },
                                        child: const Text("Ya"))
                                  ],
                                ),
                              );
                            },
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            )),
                        IconButton(
                            onPressed: () {
                              customPopup(
                                  nameController: updateController,
                                  context: context,
                                  onPressed: () {
                                    context.read<UsersBloc>().add(
                                        UserUpdateDataUser(
                                            request: UserModel(
                                                name: updateController.text,
                                                id: state.users[index].id)));
                                    Navigator.pop(context);
                                  },
                                  title: "Update Data User");
                            },
                            icon: const Icon(Icons.edit)),
                      ],
                    ),
                    leading: Container(
                      width: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                              state.users[index].avatar.toString()),
                        ),
                      ),
                    ),
                  );
                });
          }
          return const SizedBox();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          customPopup(
              nameController: nameController,
              context: context,
              onPressed: () {
                context.read<UsersBloc>().add(UserAddDataUsers(
                    request: UserModel(name: nameController.text)));

                Navigator.pop(context);
              },
              title: "Add Data User");
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<dynamic> customPopup(
      {required BuildContext context,
      required Function() onPressed,
      required TextEditingController nameController,
      required String title}) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
          insetPadding: const EdgeInsets.all(20),
          contentPadding: const EdgeInsets.all(20),
          title: Text(title),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          content: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: nameController,
                  decoration:
                      const InputDecoration(border: OutlineInputBorder()),
                ),
                const SizedBox(height: 30),
                ElevatedButton(onPressed: onPressed, child: const Text("Save"))
              ],
            ),
          )),
    );
  }
}
