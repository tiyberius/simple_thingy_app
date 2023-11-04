import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_thingy_app/models/ModelProvider.dart';

final profileAPIServiceProvider = Provider<ProfileAPIService>((ref) {
  return ProfileAPIService();
});

class ProfileAPIService {
  ProfileAPIService();

  Future<Profile> getProfile() async {
    try {
      final request = ModelQueries.list(Profile.classType);
      final response = await Amplify.API.query(request: request).response;

      final profile = response.data!.items.first;

      return profile!;
    } on Exception catch (error) {
      debugPrint('getProfile fialed: $error');
      rethrow;
    }
  }

  Future<void> updateProfile(Profile updatedProfile) async {
    try {
      await Amplify.API
          .mutate(
            request: ModelMutations.update(updatedProfile),
          )
          .response;
    } on Exception catch (error) {
      debugPrint('updateProfile failed: $error');
    }
  }
}
