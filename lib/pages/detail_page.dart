import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/cubit/detail_cubit/detail_cubit.dart';
import 'package:todo_app/model/todo_model.dart';

class DetailPage extends StatelessWidget {
  final Todo? todo;

  DetailPage({super.key, this.todo});

  final textController = TextEditingController();
  final descriptionController = TextEditingController();

  void init() {
    textController.text = todo?.title ?? "";
    descriptionController.text = todo?.description ?? "";
  }

  @override
  Widget build(BuildContext context) {
    init();
    final cubit = context.read<DetailCubit>();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail").tr(),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                if (todo == null) {
                  cubit.create(
                      textController.text, descriptionController.text);
                } else {
                  cubit.edit(
                      textController.text, descriptionController.text, todo!);
                }
              },
              icon: const Icon(Icons.save))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: textController,
              decoration: InputDecoration(hintText: "title".tr()),
            ),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(hintText: "description".tr()),
            ),
            BlocConsumer(
              bloc: cubit,
              builder: (context, state) {
                /// builder
                if (cubit.state is DetailLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return const SizedBox.shrink();
              },
              listener: (BuildContext context, Object? state) {
                if (cubit.state is DetailFailure) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content:
                          Text((cubit.state as DetailFailure).message)));
                }

                if ((cubit.state is DetailUpdateSuccess ||
                        cubit.state is DetailCreateSuccess) &&
                    context.mounted) {
                  Navigator.pop(context);
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
