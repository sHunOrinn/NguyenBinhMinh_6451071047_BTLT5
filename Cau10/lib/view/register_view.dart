import 'package:cau10/widget/custom_text_field.dart';
import 'package:flutter/material.dart';

import '../utils/form_validators.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool isEnabledSubmit = false;

  @override
  void initState() {
    super.initState();
    _fullNameController.addListener(_refreshSubmitState);
    _emailController.addListener(_refreshSubmitState);
    _passwordController.addListener(_refreshSubmitState);
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _refreshSubmitState() {
    final enableSubmit =
        FormValidators.validateRequired(_fullNameController.text, 'Họ tên') == null &&
            FormValidators.isEmailValid(_emailController.text) &&
            FormValidators.validatePassword(_passwordController.text) == null;

    if (enableSubmit != isEnabledSubmit) {
      setState(() {
        isEnabledSubmit = enableSubmit;
      });
    }
  }


  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Đăng ký thành công')),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Đăng ký tài khoản'),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 26),
              CustomTextField(
                label: 'Họ tên',
                hint: 'Nhập họ tên của bạn',
                controller: _fullNameController,
                validator:(value) =>
                    FormValidators.validateRequired(value, 'Họ tên')
              ),
              SizedBox(height: 26),
              CustomTextField(
                label: 'Email',
                hint: 'Nhập email của, bạn',
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                validator: FormValidators.validateEmail
              ),
              SizedBox(height: 26),
              CustomTextField(
                  label: 'Mật khẩu',
                  hint: 'Nhập mật khẩu của, bạn',
                  controller: _passwordController,
                  obscureText: true,
                  validator: FormValidators.validatePassword
              ),
              SizedBox(height: 26),
              // CustomButton(
              //   text: 'Đăng ký',
              //   onPressed: isEnabledSubmit ? _submitForm : null,
              // ),
              ElevatedButton(
                onPressed: isEnabledSubmit ? _submitForm : null,
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.fromMap({
                    WidgetState.disabled: Colors.grey,
                    WidgetState.any: Colors.teal,
                  }),
                ),
                child: const Text('Đăng Ký'),
              ),
            ],
          )
        )
      ),
    );
  }
}

