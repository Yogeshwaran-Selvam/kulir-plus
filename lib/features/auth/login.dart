import 'package:flutter/material.dart';
import '/app/app.dart';
import 'package:flutter/scheduler.dart';
import 'widgets/widgets.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool _isLogin = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: _body(context),
      resizeToAvoidBottomInset: true,
    );
  }

  Widget _body(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.white, Colors.black],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
        Positioned(left: 75, top: 20, child: AppLotties.loginLottie(context)),
        // Glass container with form
        Positioned(
          top: 300,
          left: 50,
          child: GlassContainer(
            width: 300,
            height: 500,
            child: SingleChildScrollView(
              padding: EdgeInsets.all(10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Header with back button and title
                  Center(
                    child: Text(
                      _isLogin ? 'Login' : 'Register',
                      style: AppTexts.titleLarge(
                        context,
                        font: AppFont.aDLaMDisplay,
                      ),
                    ),
                  ),
                  _isLogin ? _signInWidgets() : _signUpWidgets(),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _signInWidgets() {
    return Column(
      children: [
        // Form fields
        if (!_isLogin)
          GlassTextField(
            label: 'Name',
            controller: _nameController,
            suffixIcon: Icons.person,
          ),
        if (!_isLogin) const SizedBox(height: 16),
        GlassTextField(
          label: 'Email',
          controller: _emailController,
          suffixIcon: Icons.email,
        ),
        const SizedBox(height: 16),
        GlassTextField(
          label: 'Password',
          controller: _passwordController,
          obscureText: true,
          suffixIcon: Icons.visibility,
          isPasswordField: true,
        ),
        const SizedBox(height: 16),
        if (!_isLogin)
          GlassTextField(
            label: 'Confirm Password',
            controller: _confirmPasswordController,
            obscureText: true,
            suffixIcon: Icons.visibility,
            isPasswordField: true,
          ),
        if (!_isLogin) const SizedBox(height: 16),

        // Forgot password and toggle button
        _forgotAndSignUp(context),
        const SizedBox(height: 20),

        // Login/Register button
        _loginBtn(),
        if (_isLogin) const SizedBox(height: 30),

        // Social login section
        if (_isLogin) _signInWith(),
        if (_isLogin) const SizedBox(height: 20),
        if (_isLogin) _signWithBtns(),
      ],
    );
  }

  Widget _signUpWidgets() {
    return Column(
      children: [
        // Form fields
        GlassTextField(
          label: 'Name',
          controller: _nameController,
          suffixIcon: Icons.person,
        ),
        const SizedBox(height: 10),
        GlassTextField(
          label: 'Email',
          controller: _emailController,
          suffixIcon: Icons.email,
        ),
        const SizedBox(height: 10),
        GlassTextField(
          label: 'Password',
          controller: _passwordController,
          obscureText: true,
          suffixIcon: Icons.visibility,
          isPasswordField: true,
        ),
        const SizedBox(height: 10),
        GlassTextField(
          label: 'Confirm Password',
          controller: _confirmPasswordController,
          obscureText: true,
          suffixIcon: Icons.visibility,
          isPasswordField: true,
        ),
        const SizedBox(height: 10),

        // Forgot password and toggle button
        _forgotAndSignUp(context),
        const SizedBox(height: 10),

        // Login/Register button
        _loginBtn(),
      ],
    );
  }

  Widget _signInWith() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(child: Divider(thickness: 1, color: Colors.white)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Text('or sign in with', style: AppTexts.labelLarge(context)),
        ),
        Expanded(child: Divider(thickness: 1, color: Colors.white)),
      ],
    );
  }

  Widget _signWithBtns() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _customSignInBtns(
          () {},
          Image.asset('assets/logo/google-logo.png', width: 24, height: 24),
        ),
        _customSignInBtns(
          () {},
          const Icon(Icons.apple, size: 26),
          color: Colors.black,
        ),
        _customSignInBtns(
          () {},
          const Icon(Icons.facebook, size: 26),
          color: Color(0xff1877F2),
        ),
        _customSignInBtns(
          () {},
          Image.asset('assets/logo/microsoft-logo.png', width: 24, height: 24),
        ),
      ],
    );
  }

  Widget _customSignInBtns(
    VoidCallback onPressed,
    Widget icon, {
    Color? color,
  }) {
    return IconButton(
      onPressed: onPressed,
      icon: icon,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: color,
        elevation: 2,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      ),
    );
  }

  Widget _forgotAndSignUp(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (_isLogin)
          TextButton(
            onPressed: () {
              // Navigate to forgot password page
            },
            child: Text(
              'Forgot Password??...',
              style: AppTexts.labelSmall(context),
            ),
          ),
        if (!_isLogin) const SizedBox.shrink(),
        TextButton(
          onPressed: () => setState(() => _isLogin = !_isLogin),
          child: Text(
            _isLogin ? 'Create an Account...' : 'Already have an Account...',
            style: AppTexts.labelSmall(context),
          ),
        ),
      ],
    );
  }

  Widget _loginBtn() {
    return ConstrainedBox(
      constraints: const BoxConstraints(minWidth: 200, minHeight: 50),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 2,
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          splashFactory: InkSparkle.splashFactory,
        ),
        onPressed: () {
          SchedulerBinding.instance.addPostFrameCallback((_) {
            AppRouter.pushAndRemoveUntil(
              context,
              RouteNames.splash,
              transition: RouteTransitions.scaleTransition,
            );
          });
        },
        child: Text(
          _isLogin ? 'LOGIN' : 'REGISTER',
          style: AppTexts.titleMedium(
            context,
            color: Colors.black,
            font: AppFont.aDLaMDisplay,
          ),
        ),
      ),
    );
  }
}
