
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resto_radar/presentation/bloc/scheduling/scheduling_bloc.dart';
import 'package:permission_handler/permission_handler.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  void showDialogPermissionIsPermanentlyDenied(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Izinkan aplikasi untuk tampilkan notifikasi'),
        content: const Text(
            'Anda perlu memberikan izin ini dari pengaturan sistem.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              openAppSettings();
            },
            child: const Text('Buka pengaturan'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return BlocProvider<SchedulingBloc>(
      create: (context) => SchedulingBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Pengaturan'),
        ),
        body: BlocListener<SchedulingBloc, SchedulingState>(
          listener: (context, state) {
            if (state is SchedulingSwitchOn) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('notifikasi berhasil di hidupkan'),
                ),
              );
            }

            if (state is SchedulingSwitchOff) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('notifikasi berhasil di matikan'),
                ),
              );
            }
          },
          child: BlocBuilder<SchedulingBloc, SchedulingState>(
            builder: (context, state) {
              return SwitchListTile(
                title: const Text('Daily Reminder'),
                //todo seharusnya value di ambil dari PreferencesBloc
                value: state is SchedulingSwitchOn ? state.isScheduled : false,

                onChanged: (value) async {
                
                  if (value == true) {
                    BlocProvider.of<SchedulingBloc>(context)
                        .add(ToggleSchedulingOnEvent(value));
                  } else {
                    BlocProvider.of<SchedulingBloc>(context)
                        .add(ToggleSchedulingOffEvent(value));
                  }
                },
              );
            },
          ),
        ),
      ),
    );
  }
}

