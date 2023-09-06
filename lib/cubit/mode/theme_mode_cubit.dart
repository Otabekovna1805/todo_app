import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'theme_mode_state.dart';

class ThemeModeCubit extends Cubit<ThemeModeState> {
  ThemeModeCubit() : super(const ThemeModeInitial(mode: ThemeMode.light));

  void change() async {
    if(state.mode == ThemeMode.light) {
      emit(const ThemeModeInitial(mode: ThemeMode.dark));
    } else {
      emit(const ThemeModeInitial(mode: ThemeMode.light));
    }
  }
}
