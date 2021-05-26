import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_skinx_siravit/config/colors/color_palette.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_skinx_siravit/constants/type_text_field.dart';
import 'package:flutter_skinx_siravit/dialogs/condition_dialog.dart';
import 'package:flutter_skinx_siravit/dialogs/error_dialog.dart';
import 'package:flutter_skinx_siravit/dialogs/loading_dialog.dart';
import 'package:flutter_skinx_siravit/providers/register_provicer.dart';
import 'package:flutter_skinx_siravit/servicers/authentication_service.dart';
import 'package:flutter_skinx_siravit/servicers/navigation_service.dart';
import 'package:flutter_skinx_siravit/widgets/fill_button.dart';
import 'package:flutter_skinx_siravit/widgets/violet_corner.dart';

class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final registerProvider = context.read<RegisterChangeNotifierProvider>();
    return VioletCornerWidget(
      title: 'สร้างบัญชีผู้ใช้',
      widget: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          SizedBox(
            height: 40.h,
          ),
          _RegisterTextField(
            title: 'ชื่อผู้ใช้งาน',
            type: TypeTextField.name,
            controller: registerProvider.nameController,
          ),
          SizedBox(
            height: 10.h,
          ),
          _RegisterTextField(
            title: 'อีเมล',
            type: TypeTextField.email,
            controller: registerProvider.emailController,
          ),
          SizedBox(
            height: 10.h,
          ),
          _RegisterTextField(
            title: 'รหัสผ่าน',
            type: TypeTextField.password,
            controller: registerProvider.passwordController,
            obscureText: true,
          ),
          SizedBox(
            height: 10.h,
          ),
          _RegisterTextField(
            title: 'ยืนยันรหัสผ่าน',
            type: TypeTextField.confirmPassword,
            controller: registerProvider.confirmPasswordController,
            obscureText: true,
          ),
          SizedBox(
            height: 30.h,
          ),
          _ConditionWidget(),
          SizedBox(
            height: 40.h,
          ),
          FillButton(
            title: 'ยืนยัน',
            color: colorViolet,
            function: () async {
              await checkInput(registerProvider, context);
            },
          )
        ],
      ),
    );
  }

  Future<void> checkInput(
    RegisterChangeNotifierProvider registerProvider,
    BuildContext context,
  ) async {
    registerProvider.check();
    if (registerProvider.messageError.isEmpty) {
      showLoadingDialog(context);
      final result = await AuthenticationServices().register(
        registerProvider.emailController.text,
        registerProvider.passwordController.text,
        registerProvider.nameController.text,
      );

      NavigationService.instance.pop();

      if (result == 'success') {
        registerProvider.clear();
        NavigationService.instance.navigateAndRemoveUntil('home');
      } else
        showErrorDialog(
          context: context,
          message: result,
        );
    }
  }
}

class _ConditionWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    final registerProvider = context.watch<RegisterChangeNotifierProvider>();

    return Column(
      children: [
        Row(
          children: [
            Checkbox(
              activeColor: colorViolet,
              value: registerProvider.checkBoxValue,
              onChanged: (value) {
                registerProvider.checkBoxValue = value!;
              },
            ),
            Expanded(
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'ฉันยอมรับ',
                      style: theme.bodyText1,
                    ),
                    TextSpan(
                      text: ' เงื่อนไขและข้อตกลง ',
                      style: theme.bodyText1!.copyWith(
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          showConditionDialog(context);
                        },
                    ),
                    TextSpan(
                      text: 'เกี่ยวกับการใช้งาน',
                      style: theme.bodyText1,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        if (TypeTextField.checkBox == registerProvider.typeError)
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.only(top: 10.h),
              child: Text(
                registerProvider.messageError,
                style: theme.bodyText2!.copyWith(color: colorRed),
                textAlign: TextAlign.center,
              ),
            ),
          ),
      ],
    );
  }
}

class _RegisterTextField extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  final TypeTextField type;
  final bool obscureText;
  const _RegisterTextField({
    Key? key,
    required this.title,
    required this.controller,
    required this.type,
    this.obscureText = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    final registerProvider = context.watch<RegisterChangeNotifierProvider>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(
            left: 20.w,
            bottom: 5.h,
          ),
          child: Text(
            title,
            style: theme.bodyText1!,
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: 20,
          ),
          decoration: BoxDecoration(
            color: (type == registerProvider.typeError)
                ? colorRed.withOpacity(0.1)
                : Colors.grey.shade200,
            borderRadius: BorderRadius.circular(40),
          ),
          child: TextFormField(
            style: theme.bodyText2,
            onChanged: (value) {
              if (registerProvider.typeError == type)
                registerProvider.typeError = TypeTextField.none;
            },
            controller: controller,
            obscureText: obscureText,
            decoration: InputDecoration(
              border: InputBorder.none,
              counterText: "",
            ),
          ),
        ),
        if (type == registerProvider.typeError)
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.only(top: 10.h),
              child: Text(
                registerProvider.messageError,
                style: theme.bodyText2!.copyWith(color: colorRed),
                textAlign: TextAlign.center,
              ),
            ),
          ),
      ],
    );
  }
}
