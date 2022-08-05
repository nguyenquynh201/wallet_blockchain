import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:wallet_blockchain/enum/validate_state.dart';
import 'package:wallet_blockchain/utils/string_utils.dart';
import 'package:wallet_blockchain/viewmodels/auth/sign_up_view_model.dart';
import 'package:wallet_blockchain/views/assets/image_asset.dart';
import 'package:wallet_blockchain/views/constant/ui_colors.dart';
import 'package:wallet_blockchain/views/widgets/ui_button.dart';
import 'package:wallet_blockchain/views/widgets/ui_input.dart';
import 'package:wallet_blockchain/views/widgets/ui_text.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({Key? key}) : super(key: key);

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  late SignUpViewModel _signUpViewModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _signUpViewModel = SignUpViewModel()..onInitView(context);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => _signUpViewModel,
      child: Scaffold(
        backgroundColor: UIColors.white,
        body: SingleChildScrollView(
          child: GestureDetector(
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
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(
          height: 30,
        ),
        SizedBox(
          height: 120,
          width: 120,
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(bottom: 10, top: 8),
          child: UIText("Name"),
        ),
        Selector<SignUpViewModel, ValidateEmailState>(
            builder: (_, emailState, __) {
              return UITextInput(
                hint: "Mr.Quynh",
                onChanged: _signUpViewModel.onNameChange,
                onFocus: _signUpViewModel.restoreValidateNameState,
              );
            },
            selector: (_, viewModel) => viewModel.validateEmailState),
        const Padding(
          padding: EdgeInsets.only(bottom: 10, top: 8),
          child: UIText("Email"),
        ),
        Selector<SignUpViewModel, ValidateEmailState>(
            builder: (_, emailState, __) {
              return UITextInput(
                hint: "example@email.com",
                onChanged: _signUpViewModel.onEmailChange,
                errorMessage:
                    StringUtils.toInvalidEmailString(emailState, context),
                onFocus: _signUpViewModel.restoreValidateEmailState,
              );
            },
            selector: (_, viewModel) => viewModel.validateEmailState),
        const Padding(
          padding: EdgeInsets.only(
            bottom: 10,
          ),
          child: UIText("Password"),
        ),
        Selector<SignUpViewModel, bool>(
            builder: (_, securePassword, __) {
              return Selector<SignUpViewModel, ValidatePasswordState>(
                  builder: (_, passwordState, __) {
                    return UITextInput(
                      hint: "* * * * * *",
                      obscureText: securePassword,
                      keyboardType: TextInputType.visiblePassword,
                      onFocus: _signUpViewModel.restoreValidatePasswordState,
                      errorMessage: StringUtils.toInvalidPasswordString(
                          passwordState, context),
                      onChanged: _signUpViewModel.onPasswordChange,
                      onRightIconPressed: () {
                        _signUpViewModel.updateSecurePassword(!securePassword);
                      },
                    );
                  },
                  selector: (_, viewModel) => viewModel.validatePasswordState);
            },
            selector: (_, viewModel) => viewModel.securePassword),
        const Padding(
          padding: EdgeInsets.only(bottom: 10, top: 8),
          child: UIText("Phone Number"),
        ),
        Selector<SignUpViewModel, ValidatePhoneState>(
            builder: (_, phoneState, __) {
              return UITextInput(
                hint: "09xxxxxxxx",
                onChanged: _signUpViewModel.onPhoneChang,
                errorMessage:
                    StringUtils.toInvalidPhoneString(phoneState, context),
                onFocus: _signUpViewModel.restoreValidatePhoneState,
                keyboardType: TextInputType.number,
              );
            },
            selector: (_, viewModel) => viewModel.validatePhoneState),
        const SizedBox(height: 20),
        Selector<SignUpViewModel, bool>(
            builder: (_, enable, __) {
              return UIButton(
                padding: const EdgeInsets.only(bottom: 18),
                enabled: enable,
                onPressed: () {
                  _signUpViewModel.clickRegister();
                },
                title: "Sign Up",
                titleStyle: const TextStyle(
                    color: UIColors.white, fontWeight: FontWeight.w700),
              );
            },
            selector: (_, viewModel) => viewModel.isCreateButtonEnabled)
      ],
    );
  }
}
