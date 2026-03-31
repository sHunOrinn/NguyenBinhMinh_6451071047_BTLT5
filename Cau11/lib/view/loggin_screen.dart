import 'package:cau11/widget/custom_text_field.dart';
import 'package:flutter/material.dart';

import '../utils/form_validators.dart';

class LogginView extends StatefulWidget {
  const LogginView({super.key});

  @override
  State<LogginView> createState() => _LogginViewState();
}

class _LogginViewState extends State<LogginView> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();


  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Đăng nhập thành công')),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Đăng nhập'),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          // autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
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
                onPressed: _submitForm,
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.fromMap({
                    WidgetState.any: Colors.teal,
                  }),
                ),
                child: const Text('Đăng nhập'),
              ),
            ],
          )
        )
      ),
    );
  }
}

