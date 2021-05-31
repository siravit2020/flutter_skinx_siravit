import 'package:flutter/material.dart';
import 'package:flutter_skinx_siravit/config/colors/color_palette.dart';
import 'package:flutter_skinx_siravit/providers/login_provider.dart';
import 'package:flutter_skinx_siravit/servicers/navigation_service.dart';
import 'package:flutter_skinx_siravit/widgets/fill_button.dart';
import 'package:flutter_skinx_siravit/widgets/logo.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 0.08.sw,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _Logo(),
            _LoginForm(),
          ],
        ),
      ),
    );
  }
}

class _LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loginProvider = context.read<LoginProvider>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _LoginTextField(
          controller: loginProvider.emailController,
          hintText: 'อีเมล',
        ),
        SizedBox(
          height: 20.h,
        ),
        _LoginTextField(
          controller: loginProvider.passwordController,
          hintText: 'รหัสผ่าน',
          max: 20,
          obscureText: true,
        ),
        SizedBox(
          height: 60.h,
        ),
        FillButton(
          title: 'เข้าสู่ระบบ',
          color: colorViolet,
          function: () {
            loginProvider.checkAuthentication();
          },
        ),
        SizedBox(
          height: 10.h,
        ),
        FillButton(
          title: 'สร้างบัญชีผู้ใช้',
          color: colorRed,
          function: () {
            NavigationService.instance.navigateTo('/register');
          },
        ),
      ],
    );
  }

}

class _LoginTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final int? max;
  final bool obscureText;
  const _LoginTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    this.max,
    this.obscureText = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 20,
      ),
      decoration: BoxDecoration(
        color: colorGrey,
        borderRadius: BorderRadius.circular(40),
      ),
      child: TextFormField(
        style: theme.bodyText2,
        controller: controller,
        maxLength: max,
        obscureText: obscureText,
        decoration: InputDecoration(
          border: InputBorder.none,
          counterText: "",
          hintText: hintText,
        ),
      ),
    );
  }
}

class _Logo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Column(
      children: [
        Logo(),
        SizedBox(
          height: 20.h,
        ),
        Text(
          'ตามหาคนจ้างงาน ช่วยรับหนูที',
          style: theme.headline6,
        ),
        SizedBox(
          height: 40.h,
        ),
      ],
    );
  }
}
