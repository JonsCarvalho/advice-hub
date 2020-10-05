import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

part 'login_controller.g.dart';

@Injectable()
class LoginController = _LoginControllerBase with _$LoginController;

abstract class _LoginControllerBase with Store {
  @computed
  bool get isValid {
    return (validateText() == null) && (text != null);
  }

  @observable
  TextEditingController textController = TextEditingController();

  @observable
  String text;

  @action
  setText(value) => text = value;

  String validateText() {
    if (text == null) {
      return null;
    } else if (text.toString().trim().isEmpty) {
      return 'Este campo é obrigatório.';
    }

    return null;
  }
}
