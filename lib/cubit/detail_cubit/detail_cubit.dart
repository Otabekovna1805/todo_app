import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:todo_app/main.dart';
import 'package:todo_app/model/todo_model.dart';

part 'detail_state.dart';

class DetailCubit extends Cubit<DetailState> {
  DetailCubit() : super(DetailInitial());

  void create(String title, String description) async {
    if(title.isEmpty || description.isEmpty) {
      emit(DetailFailure(message: "Please fill in all fields"));
      return;
    }
    emit(DetailLoading());
    try {
      final todo = Todo(id: 1, title: title, description: description, isCompleted: false);
      await sql.insert(todo);
      emit(DetailCreateSuccess());
    } catch (e) {
      emit(DetailFailure(message: "Detail Error: $e"));
    }
  }

  void delete(int id) async {
    emit(DetailLoading());
    try {
      await sql.delete(id);
      emit(DetailDeleteSuccess());
    } catch (e) {
      emit(DetailFailure(message: "Detail error: $e"));
    }
  }

  void complete(Todo todo) async {
    emit(DetailLoading());
    try {
      todo.isCompleted = !todo.isCompleted;
      await sql.update(todo);
      emit(DetailUpdateSuccess());
    } catch (e) {
      emit(DetailFailure(message: "Detail error: $e"));
    }
  }

  void edit(String title, String description, Todo todo) async {
    if(title.isEmpty || description.isEmpty) {
      emit(DetailFailure(message: "Please fill in all fields"));
      return;
    }
    emit(DetailLoading());
    try {
     todo.title = title;
     todo.description = description;
     await sql.update(todo);
     emit(DetailUpdateSuccess());
    } catch (e) {
      emit(DetailFailure(message: "Detail Error: $e"));
    }
  }

}
