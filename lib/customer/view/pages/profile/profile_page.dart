import 'package:flutter/material.dart';
import 'package:rent_home/customer/view/pages/profile/logged_view.dart';
import 'package:rent_home/customer/viewmodel/providers/user_provider.dart';
import 'package:rent_home/services/log_service.dart';
import 'package:provider/provider.dart';

import 'unlogged_view.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<UserProvider>();
    Log.d("profile page  => ${provider.user}");
    return Scaffold(
      body: provider.user.role == "anonymous"
          ? const UnLoggedView()
          : const LoggedView(),
    );
  }
}
