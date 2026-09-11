import 'package:flutter/material.dart';
import 'package:mobile/models/user/user_model.dart';
import 'package:mobile/providers/user/user_provider.dart';
import 'package:mobile/routes/app_routes.dart';
import 'package:mobile/service/api_client.dart';
import 'package:mobile/service/auth_storage_service.dart';
import 'package:mobile/service/user/user_service.dart';
import 'package:mobile/theme/theme_extensions.dart';
import 'package:mobile/widgets/buttons/primary_button.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

class EmailConfirmScreen extends StatefulWidget {
  final String email;
  final String senha;
  final VoidCallback? onEmailConfirmed;

  const EmailConfirmScreen({
    required this.email,
    required this.senha,
    this.onEmailConfirmed,
    super.key,
  });

  @override
  State<EmailConfirmScreen> createState() => _EmailConfirmScreenState();
}

class _EmailConfirmScreenState extends State<EmailConfirmScreen> {
  bool _pinError = false;
  bool _isLoading = false;
  final _pinController = TextEditingController();
  final _userService = UserService();

  Future<void> _aoVerificar() async {
    if (widget.onEmailConfirmed != null) {
      widget.onEmailConfirmed!();
      return;
    }

    try {
      final loginResponse = await _userService.login(
        emailOuUsername: widget.email,
        password: widget.senha,
      );

      final token = loginResponse['token'];
      final accountId = loginResponse['accountId'];

      ApiClient.token = token;

      // Mesmo tratamento da tela de login: a conta já foi criada e o token é
      // válido, então falha ao carregar o perfil não desfaz o cadastro.
      UserModel usuarioLogado;
      try {
        final profileResponse = await _userService.getProfile(accountId);
        usuarioLogado = UserModel.fromProfileJson(
          profileResponse,
          accountId: accountId,
          token: token,
        );
      } catch (e) {
        debugPrint('Cadastro OK, mas falhou ao carregar o perfil: $e');
        usuarioLogado = UserModel.fromLoginJson(loginResponse);
      }

      await AuthStorageService.saveSession(usuarioLogado);

      if (!mounted) return;
      context.read<UserProvider>().setUser(usuarioLogado);

      Navigator.pushNamed(context, AppRoutes.profileEditing);
    } catch (e) {
      debugPrint(e.toString());
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Erro ao entrar após confirmação. Faça login manualmente.',
          ),
        ),
      );
      // Fallback de erro: descarta register e email-confirm, deixando
      // apenas a tela inicial abaixo do login.
      Navigator.pushNamedAndRemoveUntil(
        context,
        AppRoutes.login,
        ModalRoute.withName(AppRoutes.initialScreen),
      );
    }
  }

  Future<void> _verificarCodigo() async {
    if (_pinController.text.length < 6) {
      setState(() => _pinError = true);
      return;
    }

    setState(() {
      _pinError = false;
      _isLoading = true;
    });

    try {
      await _userService.verifyEmail(
        email: widget.email,
        code: _pinController.text,
      );
      await _aoVerificar();
    } catch (e) {
      if (!mounted) return;
      setState(() => _pinError = true);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  void dispose() {
    _pinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final defaultTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: context.typography.headlineSmall.copyWith(
        fontSize: 20,
        color: context.colors.ambar,
      ),
      decoration: BoxDecoration(
        color: context.colors.ambar.withOpacity(0.05),
        border: Border.all(
          color: context.colors.ambar.withOpacity(0.3),
          width: 1.5,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
    );

    final focusedTheme = defaultTheme.copyWith(
      decoration: defaultTheme.decoration!.copyWith(
        border: Border.all(color: context.colors.ambar, width: 2),
        color: context.colors.ambar.withOpacity(0.08),
        boxShadow: [
          BoxShadow(
            color: context.colors.ambar.withOpacity(0.25),
            blurRadius: 8,
            spreadRadius: 1,
          ),
        ],
      ),
    );

    final errorTheme = defaultTheme.copyWith(
      decoration: defaultTheme.decoration!.copyWith(
        border: Border.all(color: context.colors.error, width: 2),
        color: context.colors.error.withOpacity(0.08),
        boxShadow: [
          BoxShadow(
            color: context.colors.error.withOpacity(0.25),
            blurRadius: 8,
            spreadRadius: 1,
          ),
        ],
      ),
    );

    return Scaffold(
      backgroundColor: context.colors.darkGrey,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: SizedBox(
                width: 130,
                height: 300,
                child: Image.asset('assets/img/mascote/mascote.png'),
              ),
            ),

            Text(
              'Verifique seu email',
              style: context.typography.displayLarge.copyWith(
                color: context.colors.textPrimary,
              ),
            ),

            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Enviamos um código de verificação para\n',
                    style: context.typography.titleMedium.copyWith(
                      color: context.colors.grey,
                    ),
                  ),
                  TextSpan(
                    text: widget.email,
                    style: context.typography.titleMedium.copyWith(
                      fontWeight: FontWeight.w700,
                      color: Colors.orange,
                    ),
                  ),
                  TextSpan(
                    text:
                        '\n\nVerifique sua caixa de entrada e insira o\ncódigo abaixo para ativar sua conta ',
                    style: context.typography.bodyMedium.copyWith(
                      color: context.colors.grey,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            Pinput(
              length: 6,
              defaultPinTheme: defaultTheme,
              focusedPinTheme: focusedTheme,
              errorPinTheme: errorTheme,
              controller: _pinController,
              forceErrorState: _pinError,
            ),

            const SizedBox(height: 50),

            PrimaryButton(
              label: _isLoading ? 'Verificando...' : 'Verificar e-mail',
              onPressed: _isLoading ? () {} : _verificarCodigo,
            ),

            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}
