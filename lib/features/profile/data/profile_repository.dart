import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_thingy_app/features/profile/service/profile_api_service.dart';
import 'package:simple_thingy_app/models/ModelProvider.dart';

final profileRepositoryProvider = Provider<ProfileRepository>((ref) {
  final profileAPIService = ref.read(profileAPIServiceProvider);
  return ProfileRepository(profileAPIService);
});

class ProfileRepository {
  ProfileRepository(this.profileAPIService);
  final ProfileAPIService profileAPIService;

  Future<Profile> getProfile() {
    return profileAPIService.getProfile();
  }

  Future<void> update(Profile updatedProfile) async {
    return profileAPIService.updateProfile(updatedProfile);
  }
}
