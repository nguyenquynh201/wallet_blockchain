import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:wallet_blockchain/enum/validate_state.dart';
import 'package:wallet_blockchain/utils/string_utils.dart';
import 'package:wallet_blockchain/viewmodels/auth/sign_in_view_model.dart';
import 'package:wallet_blockchain/views/assets/image_asset.dart';
import 'package:wallet_blockchain/views/constant/ui_colors.dart';
import 'package:wallet_blockchain/views/widgets/ui_button.dart';
import 'package:wallet_blockchain/views/widgets/ui_input.dart';
import 'package:wallet_blockchain/views/widgets/ui_text.dart';

class SignInView extends StatefulWidget {
  const SignInView({Key? key}) : super(key: key);

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  late SignInViewModel _signInViewModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _signInViewModel = SignInViewModel()..onInitView(context);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ChangeNotifierProvider(
      create: (_) => _signInViewModel,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: UIColors.white,
        body: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          child: Container(
            margin: const EdgeInsets.all(20),
            child: Column(
              children: [
                _buildHeader(),
                _buildBody(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 30,
        ),
        SizedBox(
          height: 200,
          width: 200,
          child: SvgPicture.asset(AssetImages.iconLogo),
        ),
        const Padding(
          padding: EdgeInsets.only(bottom: 40, top: 32),
          child: UIText(
            "Welcome To Blockchain App",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  Widget _buildBody() {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 10, top: 8),
              child: UIText("Email"),
            ),
            Selector<SignInViewModel, ValidateEmailState>(
                builder: (_, emailState, __) {
                  return UITextInput(
                    hint: "example@email.com",
                    onChanged: _signInViewModel.onEmailChange,
                    errorMessage:
                        StringUtils.toInvalidEmailString(emailState, context),
                    onFocus: _signInViewModel.restoreValidateEmailState,
                  );
                },
                selector: (_, viewModel) => viewModel.validateEmailState),
            const Padding(
              padding: EdgeInsets.only(
                bottom: 10,
              ),
              child: UIText("Password"),
            ),
            Selector<SignInViewModel, bool>(
                builder: (_, securePassword, __) {
                  return Selector<SignInViewModel, ValidatePasswordState>(
                      builder: (_, passwordState, __) {
                        return UITextInput(
                          hint: "* * * * * *",
                          obscureText: securePassword,
                          keyboardType: TextInputType.visiblePassword,
                          onFocus:
                              _signInViewModel.restoreValidatePasswordState,
                          errorMessage: StringUtils.toInvalidPasswordString(
                              passwordState, context),
                          onChanged: _signInViewModel.onPasswordChange,
                          onRightIconPressed: () {
                            _signInViewModel
                                .updateSecurePassword(!securePassword);
                          },
                        );
                      },
                      selector: (_, viewModel) =>
                          viewModel.validatePasswordState);
                },
                selector: (_, viewModel) => viewModel.securePassword),
            const SizedBox(height: 100),
            UIButton(
              enabled: _signInViewModel.isEnable,
              padding: const EdgeInsets.only(bottom: 18),
              onPressed: () {
                _signInViewModel.clickLogin();
              },
              title: "Login",
              titleStyle: const TextStyle(
                  color: UIColors.white, fontWeight: FontWeight.w700),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: _buildRegisterAccount(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRegisterAccount() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const UIText(
          "Don't have account?",
          style: TextStyle(
            color: UIColors.black,
            fontSize: 15,
            fontWeight: FontWeight.w400,
          ),
        ),
        InkWell(
          onTap: _signInViewModel.navigateToSignUpScreen,
          borderRadius: BorderRadius.circular(4),
          child: Padding(
            padding: const EdgeInsets.all(4),
            child: UIText(
              "Register",
              style: TextStyle(
                color: UIColors.colorButton,
                fontSize: 15,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
