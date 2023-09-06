import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/cubit/detail_cubit/detail_cubit.dart';
import 'package:todo_app/cubit/home/home_cubit.dart';
import 'package:todo_app/cubit/mode/theme_mode_cubit.dart';
 import 'package:todo_app/pages/detail_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    context.read<HomeCubit>().fetchTodo();
  }

  @override
  Widget build(BuildContext context) {
    final homeCubit = context.read<HomeCubit>();
    final detailCubit = context.read<DetailCubit>();
    final themeMode = context.read<ThemeModeCubit>();

    return BlocListener<DetailCubit, DetailState>(
      bloc: context.read<DetailCubit>(),
      listener: (context, state) {
        if(state is DetailDeleteSuccess || detailCubit.state is DetailCreateSuccess) {
          homeCubit.fetchTodo();
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Delete")));
        }

        if(state is DetailUpdateSuccess) {
          homeCubit.fetchTodo();
        }

        if(state is DetailDeleteSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Delete")));
        }
      },
      child: Scaffold(
        appBar: AppBar(title: const Text("app_name").tr(), centerTitle: true,
          actions: [
            BlocBuilder<ThemeModeCubit, ThemeModeState>(
                bloc: themeMode,
                builder: (context, state) {
                  return IconButton(onPressed: (){
                    themeMode.change();
                  }, icon: Icon(themeMode.state.mode == ThemeMode.light ? Icons.dark_mode : Icons.light_mode));
                }
            ),

            PopupMenuButton<Locale>(
              onSelected: context.setLocale,
              itemBuilder: (context) {
                return [
                  const PopupMenuItem(
                    value: Locale('uz', 'UZ'),
                    child: Text("🇺🇿 UZ"),
                  ),
                  const PopupMenuItem(
                      value: Locale('ru', 'RU'), child: Text("🇷🇺 RU")),
                  const PopupMenuItem(
                      value: Locale('en', 'US'), child: Text("🇺🇸 EN")),
                ];
              },
              icon: const Icon(Icons.language_outlined),
            )
          ],
        ),
        body: BlocBuilder<HomeCubit, HomeState>(
          bloc: homeCubit,
          builder: (context, state) {
            final items = state.todos;
            return Stack(
              children: [
                ListView.builder(
                  padding: const EdgeInsets.all(20),
                  itemCount: items.length,
                  itemBuilder: (ctx, i) {
                    final item = items[i];
                    return Card(
                      child: ListTile(
                        title: Text(item.title),
                        subtitle: Text(item.description),
                        trailing: PopupMenuButton(
                            onSelected: (value) {
                              if(value == "delete") {
                                detailCubit.delete(item.id);
                                Navigator.pop(context);
                              } else if(value == "edit") {
                                Navigator.of(context).push(MaterialPageRoute(builder: (_) => DetailPage(todo: item,)));
                              }
                            },
                            itemBuilder: (context) => [
                              PopupMenuItem(
                                value: const Text("edit"),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Text("delete".tr(), style: const TextStyle(fontSize: 16),),
                                    IconButton(
                                      onPressed: () {
                                        detailCubit.delete(item.id);
                                      },
                                      icon: const Icon(Icons.delete),
                                    ),
                                  ],
                                ),

                              ),
                              PopupMenuItem(
                                value: const Text("edit"),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Text("edit".tr(), style: const TextStyle(fontSize: 16),),
                                    IconButton(
                                      onPressed: () {
                                        Navigator.of(context).push(MaterialPageRoute(builder: (_) => DetailPage(todo: item,)));
                                      },
                                      icon: const Icon(Icons.edit),
                                    ),
                                  ],
                                ),),
                            ]
                        ),
                        leading: StreamBuilder(
                            initialData: detailCubit.state,
                            stream: detailCubit.stream,
                            builder: (context, snapshot) {
                              return IconButton(
                                onPressed: () {
                                  detailCubit.complete(item);
                                },
                                icon: Icon(item.isCompleted ? Icons.check_box : Icons.check_box_outline_blank),
                              );
                            }
                        ),
                      ),
                    );
                  },
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 660, left: 180),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed("/counter");
                    },
                    child: const Text("Counter"),
                  ),
                ),
              ],
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).pushNamed("/detail");
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
