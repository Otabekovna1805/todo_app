import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo_app/main.dart';
import 'package:todo_app/model/todo_model.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(const HomeInitial(todos: []));

  void fetchTodo() async {
    emit(HomeLoading(todos: state.todos));
    try {
      final todos = await sql.todos();
      emit(HomeFailure(todos: todos, message: "Success"));
    } catch (e) {
      emit(HomeFailure(todos: state.todos, message: "Home Error: $e"));
    }
  }
}
