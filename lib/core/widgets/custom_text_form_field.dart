import 'package:evently_app/core/theming/colors_manager.dart';
import 'package:evently_app/core/theming/text_styles.dart';
import 'package:flutter/material.dart';

typedef MyValidator = String? Function(String?)?;

class CustomTextFormField extends StatelessWidget {
  final Color? borderColor;
  final String? hintText;
  final TextStyle? hintStyle;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final String? labelText;
  final TextStyle? labelStyle;
  final int? maxLines;
  final TextEditingController? controller;
  final MyValidator? validator;

  const CustomTextFormField({
    super.key,
    this.controller,
    this.validator,
    this.borderColor,
    this.hintText,
    this.hintStyle,
    this.suffixIcon,
    this.prefixIcon,
    this.labelText,
    this.labelStyle,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxLines ?? 1,
      controller: controller,
      validator: validator,
      cursorColor: ColorsManager.primaryLight,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: labelStyle ?? TextStyles.medium16Grey,
        prefixIcon: prefixIcon ?? null,
        suffixIcon: suffixIcon ?? null,
        hintText: hintText,

        hintStyle: hintStyle ?? TextStyles.medium16Grey,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0),
          borderSide: BorderSide(
            color: borderColor ?? ColorsManager.greyColor,
            width: 1.5,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0),
          borderSide: BorderSide(
            color: borderColor ?? ColorsManager.greyColor,
            width: 1.5,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0),
          borderSide: BorderSide(color: ColorsManager.redColor, width: 1.5),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0),
          borderSide: BorderSide(color: ColorsManager.redColor, width: 1.5),
        ),
      ),
    );
  }
}
