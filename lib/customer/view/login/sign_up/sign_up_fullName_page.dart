import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rent_home/customer/view/widgets/widget_utils.dart';
import 'package:rent_home/customer/viewmodel/providers/login_controllers/finally_sign_up_controller.dart';
import 'package:rent_home/customer/viewmodel/providers/user_provider.dart';
import 'package:rent_home/customer/viewmodel/utils.dart';
import 'package:provider/provider.dart';

import 'sign_up_local_widgets/sign_up_phone_pincode.dart';

enum ErrorTextField { confirmError, emptyError }

class SignUpFullNamePage extends StatefulWidget {
  const SignUpFullNamePage({Key? key}) : super(key: key);

  @override
  State<SignUpFullNamePage> createState() => _SignUpFullNamePageState();
}

class _SignUpFullNamePageState extends State<SignUpFullNamePage> {
  ScrollController scrollController = ScrollController();

  textFieldHintText(int index) {
    switch (index) {
      case 0:
        return 'Полное имя';
      case 1:
        return 'Пароль';
      case 2:
        return 'Подтвердить пароль';
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => FinallySignUpController(),
      builder: (context, _) {
        final provider = context.watch<FinallySignUpController>();
        List<TextEditingController> controllers = <TextEditingController>[
          provider.fullNameController,
          provider.passwordController,
          provider.confirmPasswordController,
        ];
        return WillPopScope(
          onWillPop: () async {
            if (provider.scroll) {
              provider.updateScroll(false);
              scrollController.position.animateTo(
                0,
                duration: const Duration(milliseconds: 300),
                curve: Curves.ease,
              );
              return false;
            }
            return true;
          },
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(),
            body: Stack(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: SingleChildScrollView(
                    controller: scrollController,
                    physics: provider.scroll
                        ? const ScrollPhysics()
                        : const NeverScrollableScrollPhysics(),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 0.1.sh),
                            child: WidgetUtils.logo(height: 54.h, width: 170.w),
                          ),
                          for (int i = 0; i < controllers.length; i++)
                            textFieldBox(i, controllers[i], provider),
                          Consumer<UserProvider>(
                            builder: (context, userProvider, child) {
                              return SignUpButton(
                                function: () =>
                                    provider.textFieldCheck(context, userProvider),
                                provider: provider,
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 1.sh,
                  alignment: Alignment.bottomCenter,
                  padding: EdgeInsets.only(bottom: 20.h),
                  child: const SwitchLoginText(index: 0),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  textFieldBox(index, TextEditingController controller,
      FinallySignUpController provider) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextField(
        controller: controller,
        onTap: () {
          provider.textFieldOnTap();
        },
        onSubmitted: (value) {
          provider.updateScroll(false);
          scrollController.position.animateTo(
            0,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        },
        onChanged: (_) => setState(() {}),
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          focusedErrorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blue)),
          errorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red)),
          errorText: provider.onTap
              ? TextFieldCheckError.errorText(
                  controller,
                  false,
                  controller == provider.confirmPasswordController,
                  controller == provider.confirmPasswordController
                      ? provider.errorConfirmPassword
                      : false,
                )
              : null,
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blue)),
          hintText: textFieldHintText(index),
          hintStyle: const TextStyle(fontSize: 15),
          enabled: provider.isLoading ? false : true,
        ),
      ),
    );
  }
}
