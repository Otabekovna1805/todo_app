import 'package:bloc/bloc.dart';

class CounterCubitt extends Cubit<int> {
  CounterCubitt() : super(0);

  void increment() => emit(state + 1);
  void decrement() => emit(state - 1);
}

class MyBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    print("${bloc.runtimeType} $change");
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    print('${bloc.runtimeType} $error $stackTrace');
  }
}

abstract class EventClass {}

class Increment extends EventClass{}
class Decrement extends EventClass{}

class CounterCubit extends Bloc<EventClass, int> {
  CounterCubit() : super(0) {
    on<Increment>((event, emit) => emit(state + 1));
    on<Decrement>((event, emit) => emit(state - 1));
  }
}