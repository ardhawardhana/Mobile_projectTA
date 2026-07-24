import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../services/auth_service.dart';
import '../theme/app_theme.dart';
import '../widgets/common_widgets.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  // Key untuk mengakses & memvalidasi seluruh form sekaligus
  final _formKey = GlobalKey<FormState>();

  final _fullNameController = TextEditingController();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _classController = TextEditingController();
  final _tpqController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _obscurePassword = true;

  // Regex sederhana untuk validasi format email
  static final _emailRegex = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );

  // Username hanya boleh huruf, angka, dan underscore (tanpa spasi/simbol)
  static final _usernameRegex = RegExp(r'^[a-zA-Z0-9_]+$');

  // Nama hanya boleh huruf dan spasi
  static final _nameRegex = RegExp(r"^[a-zA-Z\s.']+$");

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

  String? _validateFullName(String? value) {
    final v = value?.trim() ?? '';
    if (v.isEmpty) return 'Nama lengkap wajib diisi.';
    if (v.length < 3) return 'Nama lengkap minimal 3 karakter.';
    if (v.length > 50) return 'Nama lengkap maksimal 50 karakter.';
    if (!_nameRegex.hasMatch(v)) {
      return 'Nama hanya boleh berisi huruf dan spasi.';
    }
    return null;
  }

  String? _validateUsername(String? value) {
    final v = value?.trim() ?? '';
    if (v.isEmpty) return 'Username wajib diisi.';
    if (v.length < 3) return 'Username minimal 3 karakter.';
    if (v.length > 20) return 'Username maksimal 20 karakter.';
    if (!_usernameRegex.hasMatch(v)) {
      return 'Username hanya boleh huruf, angka, dan underscore (_), tanpa spasi.';
    }
    return null;
  }

  String? _validateEmail(String? value) {
    final v = value?.trim() ?? '';
    if (v.isEmpty) return 'Email wajib diisi.';
    if (v.length > 100) return 'Email terlalu panjang.';
    if (!_emailRegex.hasMatch(v)) {
      return 'Format email tidak valid (contoh: nama@email.com).';
    }
    return null;
  }

  String? _validateClassOrTpq(String? value, String fieldName) {
    final v = value?.trim() ?? '';
    if (v.isEmpty) return '$fieldName wajib diisi.';
    if (v.length > 40) return '$fieldName maksimal 40 karakter.';
    return null;
  }

  String? _validatePassword(String? value) {
    final v = value?.trim() ?? '';
    if (v.isEmpty) return 'Kata sandi wajib diisi.';
    if (v.length < 6) return 'Kata sandi minimal 6 karakter.';
    if (v.length > 128) return 'Kata sandi maksimal 128 karakter.';
    return null;
  }

  Future<void> _handleRegister() async {
    // Menutup keyboard agar transisi lebih rapi
    FocusScope.of(context).unfocus();

    // Menjalankan semua validator field. Jika ada yang gagal, form akan
    // otomatis menampilkan pesan error di bawah masing-masing field.
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Periksa kembali data yang kamu masukkan.'),
          backgroundColor: AppColors.danger,
        ),
      );
      return;
    }

    final fullName = _fullNameController.text.trim();
    final username = _usernameController.text.trim();
    final email = _emailController.text.trim();
    final className = _classController.text.trim();
    final tpqName = _tpqController.text.trim();
    final password = _passwordController.text.trim();

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
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
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
                  hint: 'Budi Santoso',
                  validator: _validateFullName,
                  maxLength: 50,
                ),
                _Field(
                  label: 'Username',
                  controller: _usernameController,
                  hint: 'budi01',
                  validator: _validateUsername,
                  maxLength: 20,
                  inputFormatters: [
                    FilteringTextInputFormatter.deny(RegExp(r'\s')),
                  ],
                ),
                _Field(
                  label: 'Email (untuk Login Firebase)',
                  controller: _emailController,
                  hint: 'budi@gmail.com',
                  keyboardType: TextInputType.emailAddress,
                  validator: _validateEmail,
                  maxLength: 100,
                  inputFormatters: [
                    FilteringTextInputFormatter.deny(RegExp(r'\s')),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: _Field(
                        label: 'Kelas',
                        controller: _classController,
                        hint: 'Kelas 4',
                        validator: (v) => _validateClassOrTpq(v, 'Kelas'),
                        maxLength: 40,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: _Field(
                        label: 'Nama TPQ',
                        controller: _tpqController,
                        hint: 'Darul Ishlah',
                        validator: (v) => _validateClassOrTpq(v, 'Nama TPQ'),
                        maxLength: 40,
                      ),
                    ),
                  ],
                ),
                _Field(
                  label: 'Kata Sandi',
                  controller: _passwordController,
                  hint: '••••••••',
                  obscure: _obscurePassword,
                  validator: _validatePassword,
                  maxLength: 128,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                    ),
                    onPressed: () {
                      setState(() => _obscurePassword = !_obscurePassword);
                    },
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                _isLoading
                    ? const Center(
                        child:
                            CircularProgressIndicator(color: AppColors.primary))
                    : GradientButton(label: 'Daftar', onTap: _handleRegister),
                const SizedBox(height: AppSpacing.xl),
              ],
            ),
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
  final String? Function(String?)? validator;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? suffixIcon;

  const _Field({
    required this.label,
    required this.hint,
    required this.controller,
    this.obscure = false,
    this.keyboardType,
    this.validator,
    this.maxLength,
    this.inputFormatters,
    this.suffixIcon,
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
          TextFormField(
            controller: controller,
            obscureText: obscure,
            keyboardType: keyboardType,
            validator: validator,
            maxLength: maxLength,
            inputFormatters: inputFormatters,
            decoration: InputDecoration(
              hintText: hint,
              suffixIcon: suffixIcon,
              counterText: '', // sembunyikan counter "0/50" bawaan Flutter
            ),
          ),
        ],
      ),
    );
  }
}