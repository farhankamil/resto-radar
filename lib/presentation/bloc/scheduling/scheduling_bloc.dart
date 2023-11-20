import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:resto_radar/utils/background_service.dart';

import '../../../utils/date_time_helper.dart';
part 'scheduling_event.dart';
part 'scheduling_state.dart';

class SchedulingBloc extends Bloc<SchedulingEvent, SchedulingState> {
  SchedulingBloc() : super(SchedulingInitial()) {
    on<ToggleSchedulingOnEvent>((event, emit) async {
      final isNotificationAllowed = await _checkNotificationPermission();
      if (isNotificationAllowed) {
        final result = await scheduleReminder(event.value);
        emit(SchedulingSwitchOn(result));
      } else {
        emit(SchedulingSwitchOff(false));
      }
    });

    on<ToggleSchedulingOffEvent>((event, emit) async {
      final isCanceled = await _cancelReminder();
      emit(SchedulingSwitchOff(isCanceled));
    });
  }
  Future<bool> _checkNotificationPermission() async {
    final status = await Permission.notification.status;
    if (status == PermissionStatus.granted) {
      return true;
    } else if (status == PermissionStatus.denied) {
      final result = await Permission.notification.request();
      return result == PermissionStatus.granted;
    } else {
      return false;
    }
  }

  Future<bool> scheduleReminder(bool value) async {
    try {
      if (value == true) {
        debugPrint('Scheduling Reminder Activated');
        return await AndroidAlarmManager.periodic(
          const Duration(hours: 24),
          1,
          BackgroundService.callback,
          startAt: DateTimeHelper.format(),
          exact: true,
          wakeup: true,
        );
      } else {
        debugPrint('Scheduling News Canceled');
        return await AndroidAlarmManager.cancel(1);
      }
    } catch (e) {
      debugPrint('Error in scheduleReminder: $e');
      return false;
    }
  }

  Future<bool> _cancelReminder() async {
    debugPrint('Scheduling News Canceled');
    return await AndroidAlarmManager.cancel(1);
  }
}
