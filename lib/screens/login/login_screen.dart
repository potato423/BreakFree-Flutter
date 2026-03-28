// lib/screens/login/login_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../providers/language_provider.dart';
import '../../config/theme.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isSignUp = false;
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    final lang = context.watch<LanguageProvider>();

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 60),
                // Logo
                Center(
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: const Icon(
                      Icons.lock_outline,
                      size: 48,
                      color: AppColors.primary,
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                // Title
                Text(
                  lang.getString('Break Free', 'Break Free'),
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  lang.getString(
                    'Take control of your digital life',
                    '掌控你的数字生活'
                  ),
                  style: const TextStyle(
                    fontSize: 16,
                    color: AppColors.textSecondary,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 48),
                // Email Field
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: lang.getString('Email', '邮箱'),
                    prefixIcon: const Icon(Icons.email_outlined),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return lang.getString(
                        'Please enter your email',
                        '请输入邮箱'
                      );
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                // Password Field
                TextFormField(
                  controller: _passwordController,
                  obscureText: _obscurePassword,
                  decoration: InputDecoration(
                    labelText: lang.getString('Password', '密码'),
                    prefixIcon: const Icon(Icons.lock_outlined),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return lang.getString(
                        'Please enter your password',
                        '请输入密码'
                      );
                    }
                    if (value.length < 6) {
                      return lang.getString(
                        'Password must be at least 6 characters',
                        '密码至少6个字符'
                      );
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                // Submit Button
                ElevatedButton(
                  onPressed: auth.isLoading ? null : _handleSubmit,
                  child: auth.isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : Text(
                          lang.getString(
                            _isSignUp ? 'Sign Up' : 'Sign In',
                            _isSignUp ? '注册' : '登录'
                          ),
                        ),
                ),
                const SizedBox(height: 16),
                // Error Message
                if (auth.error != null)
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.error.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      auth.error!,
                      style: const TextStyle(color: AppColors.error),
                      textAlign: TextAlign.center,
                    ),
                  ),
                const SizedBox(height: 16),
                // Divider
                Row(
                  children: [
                    const Expanded(child: Divider()),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        lang.getString('or', '或'),
                        style: const TextStyle(color: AppColors.textSecondary),
                      ),
                    ),
                    const Expanded(child: Divider()),
                  ],
                ),
                const SizedBox(height: 16),
                // Social Login Buttons
                OutlinedButton.icon(
                  onPressed: () => auth.signInWithGoogle(),
                  icon: const Icon(Icons.g_mobiledata, size: 24),
                  label: Text(lang.getString('Continue with Google', 'Google 登录')),
                ),
                const SizedBox(height: 12),
                OutlinedButton.icon(
                  onPressed: () => auth.signInWithApple(),
                  icon: const Icon(Icons.apple, size: 24),
                  label: Text(lang.getString('Continue with Apple', 'Apple 登录')),
                ),
                const SizedBox(height: 24),
                // Guest Mode
                TextButton(
                  onPressed: () => auth.signInAnonymously(),
                  child: Text(
                    lang.getString('Continue as Guest', '游客模式'),
                  ),
                ),
                const SizedBox(height: 16),
                // Toggle Sign In/Sign Up
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      lang.getString(
                        _isSignUp ? 'Already have an account?' : "Don't have an account?",
                        _isSignUp ? '已有账号？' : '没有账号？'
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          _isSignUp = !_isSignUp;
                        });
                      },
                      child: Text(
                        lang.getString(_isSignUp ? 'Sign In' : 'Sign Up',
                          _isSignUp ? '登录' : '注册'
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _handleSubmit() async {
    if (!_formKey.currentState!.validate()) return;

    final auth = context.read<AuthProvider>();
    
    if (_isSignUp) {
      await auth.signUp(
        _emailController.text,
        _passwordController.text,
      );
    } else {
      await auth.signIn(
        _emailController.text,
        _passwordController.text,
      );
    }
  }
}
