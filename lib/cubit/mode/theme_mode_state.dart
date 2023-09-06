part of 'theme_mode_cubit.dart';

@immutable
abstract class ThemeModeState {
  final ThemeMode mode;
  const ThemeModeState({required this.mode});
}

class ThemeModeInitial extends ThemeModeState {
  const ThemeModeInitial({required super.mode});
}