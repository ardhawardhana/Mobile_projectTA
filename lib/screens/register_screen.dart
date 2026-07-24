import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../theme/app_theme.dart';
import '../widgets/common_widgets.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _fullNameController = TextEditingController();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _classController = TextEditingController();
  final _tpqController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _fullNameController.dispose();
    _usernameController.dispose();
    _emailController.dispose();
    _classController.dispose();
    _tpqController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleRegister() async {
    final fullName = _fullNameController.text.trim();
    final username = _usernameController.text.trim();
    final email = _emailController.text.trim();
    final className = _classController.text.trim();
    final tpqName = _tpqController.text.trim();
    final password = _passwordController.text.trim();

    if (fullName.isEmpty ||
        username.isEmpty ||
        email.isEmpty ||
        className.isEmpty ||
        tpqName.isEmpty ||
        password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Harap isi semua kolom pendaftaran.'),
          backgroundColor: AppColors.danger,
        ),
      );
      return;
    }

    if (password.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Kata sandi minimal harus 6 karakter.'),
          backgroundColor: AppColors.danger,
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      await AuthService().signUp(
        email: email,
        password: password,
        username: username,
        fullName: fullName,
        className: className,
        tpqName: tpqName,
      );

      if (mounted) {
        await _showSuccessDialog();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
            backgroundColor: AppColors.danger,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  /// Show a success popup, then send the user back to the Login screen
  /// (AuthService already signed the user out after registration).
  Future<void> _showSuccessDialog() async {
    await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadii.lg),
        ),
        title: const Text('Pendaftaran Berhasil! 🎉'),
        content: const Text(
          'Akun kamu sudah dibuat. Silakan login menggunakan '
          'email dan kata sandi yang baru saja kamu daftarkan.',
        ),
        actions: [
          GradientButton(
            label: 'Masuk Sekarang',
            onTap: () {
              // Close the dialog
              Navigator.of(dialogContext).pop();
              // Close RegisterScreen, revealing the Login screen underneath
              // (the root StreamBuilder now shows LoginScreen since the
              // user was signed out right after registering).
              if (mounted) {
                Navigator.of(context).pop();
              }
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(
        leading: const BackButton(color: AppColors.ink),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Daftar Akun Santri', style: AppText.display),
              const SizedBox(height: 6),
              Text(
                'Isi data diri untuk mulai belajar\ndan mengumpulkan bintang.',
                style: AppText.bodySoft,
              ),
              const SizedBox(height: AppSpacing.xl),
              _Field(
                  label: 'Nama Lengkap',
                  controller: _fullNameController,
                  hint: 'Budi Santoso'),
              _Field(
                  label: 'Username',
                  controller: _usernameController,
                  hint: 'budi01'),
              _Field(
                  label: 'Email (untuk Login Firebase)',
                  controller: _emailController,
                  hint: 'budi@gmail.com',
                  keyboardType: TextInputType.emailAddress),
              Row(
                children: [
                  Expanded(
                    child: _Field(
                        label: 'Kelas',
                        controller: _classController,
                        hint: 'Kelas 4'),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: _Field(
                        label: 'Nama TPQ',
                        controller: _tpqController,
                        hint: 'Darul Ishlah'),
                  ),
                ],
              ),
              _Field(
                label: 'Kata Sandi',
                controller: _passwordController,
                hint: '••••••••',
                obscure: true,
              ),
              const SizedBox(height: AppSpacing.md),
              _isLoading
                  ? const Center(
                      child: CircularProgressIndicator(color: AppColors.primary))
                  : GradientButton(label: 'Daftar', onTap: _handleRegister),
              const SizedBox(height: AppSpacing.xl),
            ],
          ),
        ),
      ),
    );
  }
}

class _Field extends StatelessWidget {
  final String label;
  final String hint;
  final TextEditingController controller;
  final bool obscure;
  final TextInputType? keyboardType;

  const _Field({
    required this.label,
    required this.hint,
    required this.controller,
    this.obscure = false,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: AppText.caption),
          const SizedBox(height: 6),
          TextField(
            controller: controller,
            obscureText: obscure,
            keyboardType: keyboardType,
            decoration: InputDecoration(hintText: hint),
          ),
        ],
      ),
    );
  }
}