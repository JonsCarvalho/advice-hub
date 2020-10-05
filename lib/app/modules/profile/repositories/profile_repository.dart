import 'package:advice_hub/app/modules/profile/models/profile_model.dart';
import 'package:advice_hub/app/modules/profile/models/repositories_model.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:dio/native_imp.dart';

part 'profile_repository.g.dart';

@Injectable()
class ProfileRepository extends Disposable {
  final DioForNative client;

  ProfileRepository(this.client);

  Future<ProfileModel> fetchProfile(String user) async {
    final response = await client.get('https://api.github.com/users/$user');

    ProfileModel profile = ProfileModel.fromJson(response.data);

    return profile;
  }

  Future<List<RepositoriesModel>> fetchRepositories(String user) async {
    final response =
        await client.get('https://api.github.com/users/$user/repos');

    List<RepositoriesModel> list = [];

    for (var json in (response.data)) {
      list.add(RepositoriesModel.fromJson(json));
    }

    return list;
  }

  @override
  void dispose() {}
}
