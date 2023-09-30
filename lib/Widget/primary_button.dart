import 'package:expence_demo/resource/app_colors.dart';
import 'package:flutter/material.dart';


class PrimaryButton extends StatelessWidget {
  final String? text;

  final double? height;
  final double? width;
  final double? textSize;
  final double? borderRadius;

  final Color? textColor;
  final Color? backGroundColor;

  final FontWeight? fontWeight;

  final VoidCallback? onPressed;

  const PrimaryButton({
    Key? key,
    this.text = '',
    this.height,
    this.width,
    this.textSize,
    this.borderRadius,
    this.textColor,
    this.backGroundColor,
    this.fontWeight,
    @required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 45,
      width: width ?? double.infinity,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              /*if (states.contains(MaterialState.disabled)) {
                return greyColor;
              }*/
              return backGroundColor ?? AppColors.purple;
            },
          ),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: (borderRadius != null)
                  ? BorderRadius.circular(borderRadius!)
                  : BorderRadius.circular(10),
            ),
          ),
          elevation: MaterialStateProperty.resolveWith<double>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.disabled)) {
                return 0;
              }
              return 0;
            },
          ),
          foregroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              /*if (states.contains(MaterialState.disabled)) {
                return greyColor;
              }*/
              return backGroundColor ?? AppColors.yellow;
            },
          ),
          visualDensity:
              const VisualDensity(horizontal: VisualDensity.minimumDensity),
        ),
        onPressed: onPressed,
        child: Text(
          text!,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: textColor ?? AppColors.white,
            fontSize: textSize ?? 14,
            fontWeight: fontWeight ?? FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
