import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:nvisust_test/routes_manager/route_imports.gr.dart';
import 'package:nvisust_test/src/core/common_widgets/custom_textform_field.dart';
import 'package:nvisust_test/src/core/common_widgets/primary_button.dart';
import 'package:nvisust_test/src/core/constants/text_constants.dart';
import 'package:nvisust_test/src/core/utils/extensions/spacing_extension.dart';
import 'package:nvisust_test/src/core/utils/shared_utils/preference_utils.dart';
import 'package:nvisust_test/src/core/utils/styles/text_styles.dart';
import 'package:nvisust_test/src/features/authentication/view_model/auth_view_model.dart';
import 'package:provider/provider.dart';

@RoutePage()
class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  void initState() {
    if (SharedUtils.getUUID.isNotEmpty) {
      context.pushRoute(DashboardRoute());
    }
    super.initState();
  }

  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                TextConstants.welcomeBack,
                style: TextStyles.black_24_600,
              ),
              15.height,
              CustomTextformField(
                hintText: TextConstants.email,
                type: InputTypes.email,
                controller: emailController,
              ),
              5.height,
              CustomTextformField(
                hintText: TextConstants.password,
                type: InputTypes.password,
                controller: passwordController,
              ),
              20.height,
              Consumer<AuthViewModel>(
                builder: (BuildContext context, value, Widget? child) {
                  return ButtonWidget.primary(
                    isLoading: value.isLoading,
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        context.read<AuthViewModel>().googleLogin(
                            emailController.text,
                            passwordController.text,
                            context);
                      }
                    },
                    text: TextConstants.login,
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
