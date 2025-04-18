import 'package:flutter/widgets.dart';
import 'package:todo/models/user_model.dart';

class UserProvider with ChangeNotifier {
  UserModel? currentUser;
  void updateUser(UserModel? user) {
    currentUser = user;
    notifyListeners();
  }
}
