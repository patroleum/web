import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:patroleum_dashboard/core/app_colors.dart';
import 'package:patroleum_dashboard/core/singleton/responsive_singleton.dart';
enum FieldType { email, password, normal, underLine, number }

// ignore: must_be_immutable
class TextFormFieldBuilder extends StatefulWidget {
  TextFormFieldBuilder(
      {super.key,
        this.controller,
        this.label,
        this.suffixIcon,
        this.onChanged,
        this.keyboardType,
        this.textCapitalization = TextCapitalization.none,
        this.inputFormatters,
        this.prefixText,
        this.hintText,
        this.obscureText = false,
        this.enabled = true,
        this.readOnly = false,
        this.maxLength,
        this.minLines,
        this.validator,
        this.onTap,
        this.autovalidateMode,
        this.maxLines = 1,
        this.focusNode,
        required this.fieldType,
        this.prefixIcon,
        this.textInputAction,
        this.labelColor = AppColors.black,
        this.labelFontWeight = FontWeight.w300,
        this.inputBorderColor,
        this.contentPadding,
        this.inputBackgroundColor = AppColors.dataTextFieldColor,
        this.radius = 8});

  final TextEditingController? controller;
  final String? label;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final Function(String)? onChanged;
  TextInputType? keyboardType;
  final TextCapitalization textCapitalization;

  List<TextInputFormatter>? inputFormatters;
  final String? prefixText;
  final String? hintText;
  final bool obscureText;
  final bool enabled;
  final bool readOnly;
  final int? maxLength;
  final int? minLines;

  String? Function(String?)? validator;
  final Function()? onTap;
  final AutovalidateMode? autovalidateMode;

  final int? maxLines;
  final FocusNode? focusNode;
  final FieldType fieldType;

  final TextInputAction? textInputAction;

  final Color labelColor;

  final FontWeight labelFontWeight;

  final Color? inputBorderColor;

  EdgeInsetsGeometry? contentPadding;

  final Color? inputBackgroundColor;

  final double radius;

  @override
  State<TextFormFieldBuilder> createState() => TextFormFieldBuilderState();
}

class TextFormFieldBuilderState extends State<TextFormFieldBuilder> {
  bool isError = false;
  String? errorString = "";
  Color colorError = AppColors.white;

  @override
  Widget build(BuildContext context) {
    createStyle();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        RichText(
          text: TextSpan(
            style: TextStyle(
                color: widget.labelColor,
                fontSize: 15,
                fontWeight: widget.labelFontWeight),
            children: [
              TextSpan(
                text: widget.label ?? '',
              ),
              const TextSpan(
                text: ' *',
                style: TextStyle(color: AppColors .black, fontWeight: FontWeight.normal),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 4,
        ),
        Container(
            width: ResponsiveSingleton.widthCustom(0.5),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(widget.radius)),
                color: Colors.transparent,
                border: Border.all(
                  color: AppColors.inputBorderColor
                ),
              //color: const Color.fromRGBO(246, 246, 246, 1)
            ),
            child: TextFormField(
              controller: widget.controller,
              //onChanged: widget.onChanged,
              textInputAction: widget.textInputAction,
              focusNode: widget.focusNode,
              autovalidateMode: widget.autovalidateMode,
              onTap: widget.onTap,
              readOnly: widget.readOnly,
              onChanged: widget.onChanged,
              keyboardType: widget.keyboardType,
              textCapitalization: widget.textCapitalization,
              inputFormatters: widget.inputFormatters,
              obscureText: widget.obscureText,
              enabled: widget.enabled,
              maxLines: widget.maxLines,
              maxLength: widget.maxLength, //
              minLines: widget.minLines,
              style: TextStyle(
                  fontWeight: FontWeight.normal,
                  color:
                  widget.enabled ? Colors.grey[800] : Colors.grey,
                  fontSize: 18),
              validator: (String? value) {
                if (widget.validator!(widget.controller!.text)
                    .toString()
                    .isNotEmpty) {
                  setState(() {
                    isError = true;
                    errorString = widget.validator!(widget.controller!.text);
                  });
                  return "";
                } else {
                  setState(() {
                    isError = false;
                    errorString = widget.validator!(widget.controller!.text);
                  });
                }

                return null;
              },
              decoration: InputDecoration(
                counterText: '',
                suffixIcon: widget.suffixIcon != null
                    ? Padding(
                  padding: EdgeInsets.only(
                      right: 10, left: 10),
                  child: widget.suffixIcon,
                )
                    : null,
                prefixIcon: widget.prefixIcon != null
                    ? Padding(
                  padding: EdgeInsets.only(
                      left: 15, right: 10),
                  child: widget.prefixIcon,
                )
                    : null,
                prefixText: widget.prefixText,
                hintText: widget.hintText,
                contentPadding: widget.contentPadding,
                labelStyle:
                const TextStyle(height: 0.8, fontWeight: FontWeight.normal),
                errorStyle: TextStyle(
                  height: 0,
                  color: isError ? colorError : const Color(0xff778FAA),
                ),
                hintStyle: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                border: InputBorder.none,
                focusedErrorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
              ),
            )),
        Visibility(
          replacement: const SizedBox(),
          visible: isError ? true : false,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 4),
              margin: const EdgeInsets.only(top: 14),
              decoration: BoxDecoration(
                  color: AppColors.red, borderRadius: BorderRadius.circular(5)),
              child: Text(
                errorString!,
                style: TextStyle(color: colorError, fontSize: 13),
              ),
            ),
          ),
        )
      ],
    );
  }

  void createStyle() {
    widget.contentPadding =
        widget.contentPadding ?? const EdgeInsets.fromLTRB(12, 15, 12, 15);
    switch (widget.fieldType) {
      case FieldType.email:
        widget.inputFormatters = [
          LengthLimitingTextInputFormatter(60),
        ];
        widget.validator = (value) {
          if (value == null || value.isEmpty) {
            return 'Este campo es obligatorio para continuar';
          }
          if (!RegExp(
              r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
              .hasMatch(value)) {
            return '* Debes de ingresa un correo válido';
          }
          return '';
        };
        break;
      case FieldType.password:
        widget.validator = (value) {
          if (value == null || value.isEmpty) {
            return 'Este campo es obligatorio para continuar';
          }
          return '';
        };
        break;
      case FieldType.normal:
        widget.validator = (value) {
          if (value == null || value.isEmpty) {
            return '* Este campo es obligatorio para continuar';
          }
          return '';
        };
        break;
      case FieldType.underLine:
        break;
      case FieldType.number:
        widget.keyboardType =
        const TextInputType.numberWithOptions(signed: true);
        widget.inputFormatters = [FilteringTextInputFormatter.digitsOnly];
        widget.validator = (value) {
          if (value == null || value.isEmpty) {
            return 'Este campo es obligatorio para continuar';
          }
          return '';
        };
        break;
    }
  }
}