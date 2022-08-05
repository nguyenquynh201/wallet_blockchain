import 'package:flutter/material.dart';
import 'package:wallet_blockchain/views/constant/ui_colors.dart';
import 'package:wallet_blockchain/views/widgets/ui_text.dart';

class UIButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final EdgeInsetsGeometry padding;
  final String title;
  final TextStyle? titleStyle;
  final Color? backgroundColor;
  final bool loading;
  final bool enabled;
  final bool isLine;

  const UIButton(
      {Key? key,
        this.onPressed,
        required this.title,
        this.padding = EdgeInsets.zero,
        this.titleStyle,
        this.backgroundColor,
        this.loading = false,
        this.enabled = true,
        this.isLine = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: isLine == true
          ? OutlinedButton(
        onPressed: (enabled == true) ? onPressed : null,
        style: OutlinedButton.styleFrom(
          // backgroundColor: onPressed != null
          //     ? (backgroundColor ?? UIColors.colorButton)
          //         .withOpacity((enabled == true) ? 1.0 : 0.25)
          //     : UIColors.defaultColorButton,
          fixedSize:
          const Size(double.infinity, 48),
          primary: Colors.black26,
          shape: RoundedRectangleBorder(
            borderRadius:
            BorderRadius.circular(15),
          ),
        ),
        child: _buildChild(),
      )
          : TextButton(
          onPressed: (enabled == true) ? onPressed : null,
          style: TextButton.styleFrom(
            backgroundColor: onPressed != null
                ? (backgroundColor ?? UIColors.colorButton)
                .withOpacity((enabled == true) ? 1.0 : 0.25)
                : UIColors.defaultColorButton,
            fixedSize:
            const Size(double.infinity, 48),
            primary: Colors.black26,
            shape: RoundedRectangleBorder(
              borderRadius:
              BorderRadius.circular(15),
            ),
          ),
          child: _buildChild()),
    );
  }

  Widget _buildChild() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        (loading)
            ? const SizedBox(
          height: 32,
          width: 32,
          child: CircularProgressIndicator(strokeWidth: 2.0),
        )
            : Expanded(
          child: Align(
            alignment: Alignment.center,
            child: FittedBox(
              child: UIText(
                title,
                style: const TextStyle(
                  fontSize: 17,
                ).merge(titleStyle),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
