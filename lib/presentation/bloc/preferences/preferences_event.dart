part of 'preferences_bloc.dart';

abstract class PreferencesEvent {}

class DoPreferencesEvent extends PreferencesEvent {
  final bool value;

  DoPreferencesEvent({required this.value});
}
