// part of 'scheduling_bloc.dart';

// abstract class SchedulingEvent {}

// class ScheduleReminderEvent extends SchedulingEvent {
//   final bool value;

//   ScheduleReminderEvent(this.value);
// }

part of 'scheduling_bloc.dart';

abstract class SchedulingEvent {}

class ToggleSchedulingOnEvent extends SchedulingEvent {
  final bool value;

  ToggleSchedulingOnEvent(this.value);
}

class ToggleSchedulingOffEvent extends SchedulingEvent {
  final bool value;

  ToggleSchedulingOffEvent(this.value);
}
