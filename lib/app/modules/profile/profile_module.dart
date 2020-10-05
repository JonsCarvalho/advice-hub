import 'package:dio/native_imp.dart';

import 'repositories/profile_repository.dart';
import 'profile_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'profile_page.dart';

class ProfileModule extends ChildModule {
  final String user;

  ProfileModule({this.user});

  @override
  List<Bind> get binds => [
        $ProfileRepository,
        $ProfileController,
        Bind((i) => DioForNative()),
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(Modular.initialRoute,
            child: (_, args) => ProfilePage(user: user)),
      ];

  static Inject get to => Inject<ProfileModule>.of();
}
