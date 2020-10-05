import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'models/profile_model.dart';
import 'models/repositories_model.dart';
import 'profile_controller.dart';

class ProfilePage extends StatefulWidget {
  final String title;
  final String user;
  const ProfilePage({Key key, this.title = "Profile", this.user})
      : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends ModularState<ProfilePage, ProfileController> {
  @override
  void initState() {
    controller.fetchProfile(widget.user);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: Observer(
        builder: (_) {
          if (controller.profile.error != null ||
              controller.repositories.error != null) {
            return Center(
              child: reloadButton(),
            );
          }
          if (controller.profile.value == null ||
              controller.repositories.value == null) {
            return Center(
              child: Container(
                height: 100,
                width: 100,
                child: CircularProgressIndicator(
                  backgroundColor: Theme.of(context).primaryColor,
                ),
              ),
            );
          }
          ProfileModel profile = controller.profile.value;
          List<RepositoriesModel> repositories = controller.repositories.value;

          return ListView(
            physics: BouncingScrollPhysics(),
            children: [
              userDetails(profile, repositories.length),
              Column(
                children: List.generate(repositories.length,
                    (index) => cardRepository(repositories[index])).toList(),
              ),
            ],
          );
        },
      ),
    );
  }

  appBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      title: FlatButton.icon(
        label: Text(
          'Voltar',
          style: TextStyle(
            fontWeight: FontWeight.w900,
          ),
        ),
        icon: Icon(Icons.arrow_back_ios),
        onPressed: () {
          Modular.to.pop();
        },
      ),
    );
  }

  Widget cardRepository(RepositoriesModel repository) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10),
      child: Container(
        decoration: BoxDecoration(
          color: Color.fromRGBO(239, 239, 239, 1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                repository.name ?? '',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w900,
                  color: Theme.of(context).accentColor,
                ),
              ),
              SizedBox(height: 8),
              Text(
                repository.description ?? '',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    repository.language ?? '',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text('|'),
                  Text(
                    repository.stargazersCount.toString() + ' stars',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text('|'),
                  Text(
                    repository.forksCount.toString() + ' forks',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  avatarImage(url) {
    return Container(
      height: 209,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: 14.0,
            left: 14.0,
            right: 0.0,
            child: Container(
              height: 195,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: NetworkImage(url),
                  fit: BoxFit.fitHeight,
                ),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                child: Container(
                  height: 195,
                  width: 195,
                  color: Colors.white.withOpacity(0.0),
                ),
              ),
            ),
          ),
          Container(
            height: 195,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: NetworkImage(url),
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
        ],
      ),
    );
  }

  userDetails(ProfileModel profile, int repositoriesCount) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 30.0,
        right: 30.0,
        bottom: 30.0,
        top: 8.0,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          avatarImage(profile.avatarUrl),
          SizedBox(height: 17),
          Text(
            profile.name  == null
                ? widget.user
                : profile.name.split(' ')[0],
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w900,
            ),
          ),
          SizedBox(height: 8),
          Text(
            profile.bio ?? '',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              infoNumbers(repositoriesCount ?? 0, 'Repositórios'),
              infoNumbers(profile.followers, 'Seguidores'),
              infoNumbers(profile.following, 'Seguindo'),
            ],
          ),
        ],
      ),
    );
  }

  infoNumbers(int count, String name) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).primaryColor.withAlpha(100),
            blurRadius: 10,
            spreadRadius: 3,
            offset: Offset(
              0.0,
              3.0,
            ),
          )
        ],
      ),
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            count.toString(),
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w900,
            ),
          ),
          Text(
            name,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  reloadButton() {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Houve um erro na busca, talvez o usuário não exista.',
            style: TextStyle(
              fontSize: 17,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 30),
          Container(
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).primaryColor.withAlpha(100),
                  blurRadius: 10,
                  spreadRadius: 3,
                  offset: Offset(
                    0.0,
                    3.0,
                  ),
                )
              ],
            ),
            child: FlatButton(
              onPressed: () {
                controller.fetchProfile(widget.user);
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              color: Theme.of(context).primaryColor,
              child: Text(
                'Tentar novamente?',
                style: TextStyle(
                  fontSize: 17,
                  color: Colors.black87,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
