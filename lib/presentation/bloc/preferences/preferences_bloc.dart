import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../../data/preferences/preferences_helper.dart';

part 'preferences_event.dart';
part 'preferences_state.dart';

//todo  udh fixx
//todo tambahkan on event
// Bloc untuk manajemen keadaan pengaturan

// class PreferencesBloc extends Bloc<PreferencesEvent, DailyReminderState> {
//   final PreferencesHelper preferencesHelper;

//   PreferencesBloc({required this.preferencesHelper})
//       : super(DailyReminderState(false));

//   Stream<DailyReminderState> mapEventToState(PreferencesEvent event) async* {
//     if (event is DoPreferencesEvent) {
//       yield* _mapToggleDailyReminderEventToState();
//     }
//   }

//   Stream<DailyReminderState> _mapToggleDailyReminderEventToState() async* {
//     final bool currentStatus = state.isDailyReminderActive;
//     preferencesHelper.setDailyReminder(!currentStatus);
//     final bool newStatus = await preferencesHelper.isDailyReminderActive;
//     yield DailyReminderState(newStatus);
//   }
// }

class PreferencesBloc extends Bloc<PreferencesEvent, PreferencesState> {
  final PreferencesHelper preferencesHelper;

  PreferencesBloc({required this.preferencesHelper})
      : super(PreferencesState(false)) {
    on<DoPreferencesEvent>((event, emit) async {
      try {
        final bool newValue = event.value;
        final bool currentStatus = state.isDailyReminderActive;

        if (newValue != currentStatus) {
          preferencesHelper.setDailyReminder(newValue);
          final bool newStatus = await preferencesHelper.isDailyReminderActive;
          emit(PreferencesState(newStatus));
        }
      } catch (e) {
        print('Error: $e');
      }
    });
  }

  Stream<PreferencesState> mapEventToState(PreferencesEvent event) async* {
    if (event is DoPreferencesEvent) {
      // Langsung melakukan perubahan state berdasarkan event
      yield* _mapToggleDailyReminderEventToState(event.value);
    }
  }

  Stream<PreferencesState> _mapToggleDailyReminderEventToState(
      bool value) async* {
    print('Toggle Daily Reminder Event Triggered');
    final bool currentStatus = state.isDailyReminderActive;
    print('current $currentStatus');
    if (value != currentStatus) {
      preferencesHelper.setDailyReminder(value);
      final bool newStatus = await preferencesHelper.isDailyReminderActive;
      yield PreferencesState(newStatus);
    }
  }
}







// class PreferencesBloc extends Bloc<PreferencesEvent, PreferencesState> {
//   final PreferencesHelper preferencesHelper;

//   PreferencesBloc({required this.preferencesHelper})
//       : super(PreferencesState(false)) {
//     // on<DoPreferencesEvent>((event, emit) async {
//     //   // logika pemrosesan event di sini
//     //   try {
//     //     final bool currentStatus = state.isDailyReminderActive;
//     //     preferencesHelper.setDailyReminder(!currentStatus);
//     //     final bool newStatus = await preferencesHelper.isDailyReminderActive;
//     //     emit(DailyReminderState(newStatus));
//     //   } catch (e) {
//     //     const Text('preferences bloc tidak bisa');
//     //   }
//     // }

//     on<DoPreferencesEvent>((event, emit) async {
//       try {
//         const bool newValue = true;
//         final bool currentStatus = state.isDailyReminderActive;

//         if (newValue != currentStatus) {
//           preferencesHelper.setDailyReminder(newValue);
//           final bool newStatus = await preferencesHelper.isDailyReminderActive;
//           emit(PreferencesState(newStatus));
//         }
//       } catch (e) {
//         // Handle error jika diperlukan
//         print('Error: $e');
//       }
//     });
//   }

//   Stream<PreferencesState> mapEventToState(PreferencesEvent event) async* {
//     if (event is DoPreferencesEvent) {
//       yield* _mapToggleDailyReminderEventToState(event.value);
//     }
//   }

//   // Stream<DailyReminderState> _mapToggleDailyReminderEventToState() async* {
//   //   final bool currentStatus = state.isDailyReminderActive;
//   //   preferencesHelper.setDailyReminder(!currentStatus);
//   //   final bool newStatus = await preferencesHelper.isDailyReminderActive;
//   //   yield DailyReminderState(newStatus);
//   // }

//   Stream<PreferencesState> _mapToggleDailyReminderEventToState(
//       bool value) async* {
//     final bool currentStatus = state.isDailyReminderActive;
//     if (value != currentStatus) {
//       preferencesHelper.setDailyReminder(value);
//       final bool newStatus = await preferencesHelper.isDailyReminderActive;
//       yield PreferencesState(newStatus);
//     }
//   }
// }
