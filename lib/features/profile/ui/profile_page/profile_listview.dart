import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_thingy_app/features/profile/controller/profile_controller.dart';
import 'package:simple_thingy_app/models/ModelProvider.dart';

class ProfileListView extends ConsumerWidget {
  const ProfileListView({
    required this.profile,
    super.key,
  });

  final AsyncValue<Profile> profile;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    switch (profile) {
      case AsyncData(:final value):
        return Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text('Counter Value'),
              const SizedBox(height: 16),
              Text(
                value.counter_value.toString(),
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      if (value.counter_value != null) {
                        int newCounterValue;
                        newCounterValue = value.counter_value! - 1;
                        final updatedProfile = value.copyWith(
                          counter_value: newCounterValue,
                        );
                        await ref
                            .watch(profileControllerProvider.notifier)
                            .updateProfile(updatedProfile);
                      }
                    },
                    child: const Icon(Icons.remove),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () async {
                      if (value.counter_value != null) {
                        int newCounterValue;
                        newCounterValue = value.counter_value! + 1;
                        final updatedProfile = value.copyWith(
                          counter_value: newCounterValue,
                        );
                        await ref
                            .watch(profileControllerProvider.notifier)
                            .updateProfile(updatedProfile);
                      }
                    },
                    child: const Icon(Icons.add),
                  )
                ],
              )
            ],
          ),
        );

      case AsyncError():
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                'Error',
                style: Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.center,
              ),
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: const TextStyle(fontSize: 20),
              ),
              onPressed: () async {
                ref.invalidate(profileControllerProvider);
              },
              child: const Text('Try again'),
            ),
          ],
        );
      case AsyncLoading():
        return const Center(
          child: CircularProgressIndicator(),
        );

      case _:
        return const Center(
          child: Text('Error'),
        );
    }
  }
}
