import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile/models/user/user_model.dart';
import 'package:mobile/providers/user/user_provider.dart';
import 'package:mobile/routes/app_routes.dart';
import 'package:mobile/service/api_client.dart';
import 'package:mobile/service/auth_storage_service.dart';
import 'package:mobile/service/user/user_service.dart';
import 'package:mobile/theme/theme_extensions.dart';
import 'package:mobile/widgets/buttons/primary_button.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _userService = UserService();

  final TextEditingController _emailOuUsuarioController =
      TextEditingController();
  final TextEditingController _senhaController = TextEditingController();

  bool _isLoading = false;

  @override
  void dispose() {
    _emailOuUsuarioController.dispose();
    _senhaController.dispose();
    super.dispose();
  }

  Future<void> _entrar() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    final emailOuUsuario = _emailOuUsuarioController.text.trim();
    final senha = _senhaController.text;

    try {
      final loginResponse = await _userService.login(
        emailOuUsername: emailOuUsuario,
        password: senha,
      );

      final token = loginResponse['token'];
      final accountId = loginResponse['accountId'];

      // Token precisa estar setado ANTES do getProfile, porque é esse
      // interceptor que anexa o header Authorization na chamada.
      ApiClient.token = token;

      // A credencial já foi aceita e o token é válido a partir daqui. Uma
      // falha ao carregar o perfil não pode derrubar o login: entramos com os
      // dados mínimos da resposta de login e o perfil é recarregado depois.
      UserModel usuarioLogado;
      try {
        // Busca os dados completos do perfil usando o accountId (não o id de
        // login/auth), que é o que a API usa pra indexar o profile.
        final profileResponse = await _userService.getProfile(accountId);
        usuarioLogado = UserModel.fromProfileJson(
          profileResponse,
          accountId: accountId,
          token: token,
        );
      } catch (e) {
        debugPrint('Login OK, mas falhou ao carregar o perfil: $e');
        usuarioLogado = UserModel.fromLoginJson(loginResponse);
      }

      await AuthStorageService.saveSession(usuarioLogado);

      if (!mounted) return;
      context.read<UserProvider>().setUser(usuarioLogado);

      // Limpa toda a pilha do fluxo de login: a home passa a ser a unica
      // rota, entao o botao voltar do Android nao retorna para o login.
      Navigator.pushNamedAndRemoveUntil(
        context,
        AppRoutes.home,
        (route) => false,
      );
    } catch (e) {
      debugPrint(e.toString());

      if (!mounted) return;
      // Mostra o motivo que a API devolveu em vez de culpar sempre a senha.
      final motivo = e.toString().replaceFirst('Exception: ', '');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            motivo.isEmpty ? 'Não foi possível entrar.' : motivo,
          ),
        ),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.darkGrey,
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
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
                'Entrar com e-mail',
                style: context.typography.displayLarge.copyWith(
                  color: context.colors.textPrimary,
                ),
              ),
              Text(
                'Digite suas credenciais de acesso',
                style: context.typography.bodyMedium.copyWith(
                  color: context.colors.grey,
                ),
              ),

              SizedBox(height: 30),

              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 220, bottom: 10),
                    child: Text(
                      'E-MAIL OU USUÁRIO',
                      style: context.typography.labelSmall.copyWith(
                        color: context.colors.grey,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 350,
                    child: TextFormField(
                      controller: _emailOuUsuarioController,
                      textInputAction: TextInputAction.next,
                      style: context.typography.bodyLarge.copyWith(
                        color: context.colors.textPrimary,
                      ),
                      cursorColor: context.colors.ambar,
                      inputFormatters: [LengthLimitingTextInputFormatter(320)],
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: context.colors.darkGrey,
                        prefixIcon: const Icon(Icons.email_outlined),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        errorStyle: context.typography.bodySmall.copyWith(
                          color: context.colors.error,
                          fontSize: 12,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: BorderSide(
                            color: context.colors.border,
                            width: 1.3,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: BorderSide(
                            color: context.colors.ambar,
                            width: 1.3,
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: BorderSide(
                            color: context.colors.error,
                            width: 1.3,
                          ),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: BorderSide(
                            color: context.colors.error,
                            width: 1.3,
                          ),
                        ),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Informe seu nome de usuário ou email!';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),

              SizedBox(height: 12),

              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 290, bottom: 10),
                    child: Text(
                      'SENHA',
                      style: context.typography.labelSmall.copyWith(
                        color: context.colors.grey,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 350,
                    child: TextFormField(
                      controller: _senhaController,
                      obscureText: true,
                      textInputAction: TextInputAction.done,
                      style: context.typography.bodyLarge.copyWith(
                        color: context.colors.textPrimary,
                      ),
                      cursorColor: context.colors.ambar,
                      inputFormatters: [LengthLimitingTextInputFormatter(20)],
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: context.colors.darkGrey,
                        prefixIcon: const Icon(Icons.lock_outline),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        errorStyle: context.typography.bodySmall.copyWith(
                          color: context.colors.error,
                          fontSize: 12,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: BorderSide(
                            color: context.colors.border,
                            width: 1.3,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: BorderSide(
                            color: context.colors.ambar,
                            width: 1.3,
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: BorderSide(
                            color: context.colors.error,
                            width: 1.3,
                          ),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: BorderSide(
                            color: context.colors.error,
                            width: 1.3,
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Informe sua senha!';
                        }
                        if (value.length < 8) {
                          return 'A senha deve ter pelo menos 8 caracteres!';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),

              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: SizedBox(
                      width: 350,
                      height: 50,
                      child: PrimaryButton(
                        label: _isLoading ? 'Entrando...' : 'Entrar',
                        onPressed: _isLoading ? () {} : _entrar,
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(top: 90),
                    child: InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, AppRoutes.recoverPassword);
                      },
                      child: Text(
                        'Esqueci minha senha',
                        style: context.typography.titleSmall.copyWith(
                          color: context.colors.error,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
