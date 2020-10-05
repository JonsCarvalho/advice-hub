import 'dart:ui';
import 'package:advice_hub/app/modules/profile/profile_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'login_controller.dart';

class LoginPage extends StatefulWidget {
  final String title;
  const LoginPage({Key key, this.title = "Login"}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends ModularState<LoginPage, LoginController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: adviceHubAppBar(),
      body: Stack(
        children: [
          ListView(
            physics: BouncingScrollPhysics(),
            children: [
              Container(
                height: MediaQuery.of(context).size.height -
                    MediaQuery.of(context).padding.vertical -
                    100,
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    SizedBox(),
                    SvgPicture.asset(
                      'assets/developer.svg',
                      width: MediaQuery.of(context).size.width,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        input(),
                        SizedBox(height: 16.0),
                        button(),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  adviceHubAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      title: Row(
        children: [
          Icon(
            FontAwesomeIcons.github,
            size: 38,
            color: Theme.of(context).primaryColor,
          ),
          SizedBox(width: 8.0),
          Text(
            'AdviceHub',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  button() {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).accentColor.withAlpha(100),
            blurRadius: 10,
            spreadRadius: 3,
            offset: Offset(
              0.0,
              5.0,
            ),
          )
        ],
      ),
      child: Observer(builder: (_) {
        return FlatButton(
          onPressed: controller.isValid
              ? () {
                  Modular.to.push(
                    MaterialPageRoute(
                      builder: (context) => RouterOutlet(
                        module: ProfileModule(user: controller.text),
                      ),
                    ),
                  );
                }
              : () {
                  controller.textController.clear();
                  controller.setText('');
                },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          color: Theme.of(context).accentColor,
          child: Text(
            'Buscar usuário',
            style: GoogleFonts.roboto(
              fontSize: 17,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        );
      }),
    );
  }

  input() {
    return Observer(builder: (_) {
      return TextField(
        controller: controller.textController,
        onChanged: controller.setText,
        textInputAction: TextInputAction.next,
        textAlign: TextAlign.start,
        style: TextStyle(
          color: Color.fromRGBO(71, 71, 71, 1),
          fontSize: 17,
        ),
        keyboardType: TextInputType.text,
        cursorColor: Colors.black,
        onSubmitted: (value) => FocusScope.of(context).unfocus(),
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          errorText: controller.validateText == null
              ? null
              : controller.validateText(),
          contentPadding: EdgeInsets.only(top: 30, left: 20),
          prefixIcon: Icon(FontAwesomeIcons.githubAlt),
          labelText: 'Usuário do GitHub',
          labelStyle: TextStyle(
            fontSize: 17,
          ),
        ),
      );
    });
  }
}
