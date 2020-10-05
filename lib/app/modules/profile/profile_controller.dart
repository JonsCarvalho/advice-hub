import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'models/profile_model.dart';
import 'models/repositories_model.dart';
import 'repositories/profile_repository.dart';

part 'profile_controller.g.dart';

@Injectable()
class ProfileController = _ProfileControllerBase with _$ProfileController;

abstract class _ProfileControllerBase with Store {
  final ProfileRepository repository;

  @observable
  ObservableFuture<ProfileModel> profile;
  
  @observable
  ObservableFuture<List<RepositoriesModel>> repositories;

  _ProfileControllerBase(this.repository);

  @action
  fetchProfile(user) {
    profile = repository.fetchProfile(user).asObservable();

    fetchRepositories(user);
  }
  
  @action
  fetchRepositories(user) {
    repositories = repository.fetchRepositories(user).asObservable();
  }
}
