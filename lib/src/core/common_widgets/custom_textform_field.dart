import 'package:flutter/material.dart';
import 'package:nvisust_test/src/core/utils/helpers/validators.dart';
import 'package:nvisust_test/src/core/utils/styles/app_colors.dart';
import 'package:nvisust_test/src/core/utils/styles/text_styles.dart';

class CustomTextformField extends StatelessWidget {
  final String? confirmText;
  final String hintText;

  final TextEditingController controller;
  final TextInputType? keyboardType;
  final InputTypes type;

  const CustomTextformField({
    super.key,
    this.confirmText,
    required this.hintText,
    this.keyboardType,
    required this.type,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<bool> isObscured = ValueNotifier<bool>(false);
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: ValueListenableBuilder<bool>(
          valueListenable: isObscured,
          builder: (context, isOb, child) {
            return TextFormField(
              cursorColor: AppColors.primary,
              obscuringCharacter: "*",
              autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: controller,
              style: TextStyles.blackprimary_12_400,
              validator: (value) {
                if (type == InputTypes.email) {
                  return Validators.validateEmail(value);
                } else if (type == InputTypes.password) {
                  return Validators.validatePassword(value);
                }

                return null;
              },
              maxLines: type == InputTypes.long ? 4 : 1,
              obscureText: (type == InputTypes.password && !isObscured.value),
              decoration: InputDecoration(
                isDense: true,
                hintText: hintText,
                hintStyle: TextStyles.blackprimary_12_400,
                errorStyle: TextStyles.red_12_400,
                filled: true,
                fillColor: AppColors.white,
                suffixIcon: type == InputTypes.password
                    ? GestureDetector(
                        onTap: () {
                          isObscured.value = !isObscured.value;
                        },
                        child: isOb
                            ? Icon(Icons.visibility_off_rounded)
                            : Icon(Icons.visibility_rounded))
                    : const SizedBox(),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: AppColors.blackTertiary,
                    )),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: AppColors.blackTertiary,
                    )),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide.none,
                ),
                errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: AppColors.red,
                    )),
                focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: AppColors.red,
                    )),
              ),
            );
          }),
    );
  }
}

enum InputTypes {
  text,

  email,
  long,
  password
}
