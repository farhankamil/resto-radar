part of 'scheduling_bloc.dart';

abstract class SchedulingState {}

class SchedulingInitial extends SchedulingState {}

class SchedulingSwitchOn extends SchedulingState {
  final bool isScheduled;

  SchedulingSwitchOn(this.isScheduled);
}

class SchedulingSwitchOff extends SchedulingState {
  final bool isScheduled;

  SchedulingSwitchOff(this.isScheduled);
}
