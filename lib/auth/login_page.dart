import 'package:auth_with_nodejs/auth/controller/auth_provider.dart';
import 'package:auth_with_nodejs/shared_widget/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(builder: (context, provider, index) {
      return Scaffold(
          appBar: AppBar(
            title: Text(' ${provider.isLogin ? 'Login' : 'SignUp'} Page'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              children: [
                provider.isLogin
                    ? SizedBox.fromSize()
                    : TextField(
                        controller: provider.name,
                        decoration: const InputDecoration(hintText: 'name'),
                      ),
                SizedBox(height: provider.isLogin ? 0 : 16),
                TextField(
                  controller: provider.email,
                  decoration: const InputDecoration(hintText: 'Email'),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: provider.password,
                  decoration: const InputDecoration(
                    hintText: 'Password',
                  ),
                  obscureText: true,
                ),
                const SizedBox(height: 32),
                PrimaryButton(
                    isLoading: provider.isLoading,
                    text: provider.isLogin ? 'Login' : 'Sign-Up',
                    onTap: () {
                      provider.isLogin
                          ? provider.onLogin(context)
                          : provider.onRegister();
                    }),
                SizedBox(height: 16),
                CustomRichText(
                    title:
                        '${provider.isLogin ? 'Create account' : 'Already have an account?'} ',
                    subtitle: provider.isLogin ? 'Register' : ' Login',
                    onTab: () {
                      provider.toggleButton();
                    },
                    subtitleTextStyle: TextStyle(color: Colors.blue))
              ],
            ),
          ));
    });
  }
}

class CustomRichText extends StatelessWidget {
  const CustomRichText({
    super.key,
    required this.title,
    required this.subtitle,
    required this.onTab,
    required this.subtitleTextStyle,
  });
  final String title, subtitle;
  final TextStyle subtitleTextStyle;
  final VoidCallback onTab;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTab,
      child: RichText(
        text: TextSpan(
          text: title,
          style: const TextStyle(
              color: Colors.black,
              fontSize: 14,
              fontWeight: FontWeight.w400,
              fontFamily: 'Inter'),
          children: <TextSpan>[
            TextSpan(
              text: subtitle,
              style: subtitleTextStyle,
            ),
          ],
        ),
      ),
    );
  }
}
