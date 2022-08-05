import 'package:flutter/material.dart';
import 'package:wallet_blockchain/views/assets/image_asset.dart';
import 'package:wallet_blockchain/views/constant/ui_colors.dart';
import 'package:wallet_blockchain/views/widgets/ui_text.dart';

typedef OnChanged = Function(String);
typedef OnSubmit = Function(String);

class UITextInput extends StatelessWidget {
  final String? hint;
  final String? errorMessage;
  final bool obscureText;
  final int? maxLength;
  final TextInputType keyboardType;
  final TextEditingController? controller;
  final VoidCallback? onRightIconPressed;
  final VoidCallback? onFocus;
  final OnChanged? onChanged;
  final OnSubmit? onSubmitted;
  final bool isSize;

  const UITextInput({
    Key? key,
    this.hint = "",
    this.errorMessage,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.controller,
    this.onChanged,
    this.maxLength,
    this.onSubmitted,
    this.onRightIconPressed,
    this.onFocus,
    this.isSize = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: isSize == true ? Colors.transparent : UIColors.labele,
            border: Border.all(
              color: (errorMessage == null || errorMessage!.isEmpty)
                  ? (isSize == true)
                      ? UIColors.colorBackground.withOpacity(0.5)
                      : UIColors.inputBackground
                  : UIColors.borderError,
            ),
          ),
          padding: const EdgeInsets.only(left: 16, right: 4),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  height: isSize == true ? 65 : 50,
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: MediaQuery(
                    data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                    child: TextField(
                      onTap: onFocus,
                      controller: controller,
                      onChanged: onChanged,
                      onSubmitted: onSubmitted,
                      style: const TextStyle(
                        fontSize: 14,
                        height: 2,
                      ),
                      textAlignVertical: TextAlignVertical.center,
                      obscureText: obscureText,
                      autocorrect: false,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: hint,
                        hintStyle: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w300,
                          height: 1.25,
                        ),
                      ),
                      keyboardType: keyboardType,
                    ),
                  ),
                ),
              ),
              if (keyboardType == TextInputType.visiblePassword)
                Material(
                  color: UIColors.inputBackground,
                  borderRadius: BorderRadius.circular(20),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(20),
                    onTap: onRightIconPressed,
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      child: Image.asset(
                        (obscureText)
                            ? AssetImages.iconEyeOff
                            : AssetImages.iconEyeOn,
                        width: 18,
                        height: 15,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                )
            ],
          ),
        ),
        if (!(errorMessage == null || errorMessage!.isEmpty))
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: UIText(
              errorMessage!,
              style: TextStyle(
                color: UIColors.errorMessage,
                fontSize: 13,
              ),
            ),
          ),
        if (errorMessage == null || errorMessage!.isEmpty)
          const SizedBox(height: 20),
      ],
    );
  }
}
