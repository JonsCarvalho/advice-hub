// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_controller.dart';

// **************************************************************************
// InjectionGenerator
// **************************************************************************

final $ProfileController = BindInject(
  (i) => ProfileController(i<ProfileRepository>()),
  singleton: true,
  lazy: true,
);

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ProfileController on _ProfileControllerBase, Store {
  final _$profileAtom = Atom(name: '_ProfileControllerBase.profile');

  @override
  ObservableFuture<ProfileModel> get profile {
    _$profileAtom.reportRead();
    return super.profile;
  }

  @override
  set profile(ObservableFuture<ProfileModel> value) {
    _$profileAtom.reportWrite(value, super.profile, () {
      super.profile = value;
    });
  }

  final _$repositoriesAtom = Atom(name: '_ProfileControllerBase.repositories');

  @override
  ObservableFuture<List<RepositoriesModel>> get repositories {
    _$repositoriesAtom.reportRead();
    return super.repositories;
  }

  @override
  set repositories(ObservableFuture<List<RepositoriesModel>> value) {
    _$repositoriesAtom.reportWrite(value, super.repositories, () {
      super.repositories = value;
    });
  }

  final _$_ProfileControllerBaseActionController =
      ActionController(name: '_ProfileControllerBase');

  @override
  dynamic fetchProfile(dynamic user) {
    final _$actionInfo = _$_ProfileControllerBaseActionController.startAction(
        name: '_ProfileControllerBase.fetchProfile');
    try {
      return super.fetchProfile(user);
    } finally {
      _$_ProfileControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
profile: ${profile},
repositories: ${repositories}
    ''';
  }
}
