import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFieldWithName extends StatefulWidget {
  const CustomTextFieldWithName({
    super.key,
    this.controller,
    this.obscureText = false,
    this.msg,
    this.initialValue,
    this.hintText,
    this.ddName,
    this.keyboardType,
    this.validator,
    this.onChanged,
    this.readOnly = false,
    this.enabled = true,
    this.maxLength,
    this.inputFormatters,
    this.onTap,
    this.onEditingComplete,
  });

  final TextEditingController? controller;
  final String? msg;
  final String? hintText;
  final bool obscureText;
  final String? initialValue;
  final String? ddName;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final bool readOnly;
  final bool enabled;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormatters;
  final VoidCallback? onTap;
  final Function()? onEditingComplete;

  @override
  State<CustomTextFieldWithName> createState() =>
      _CustomTextFieldWithNameState();
}

class _CustomTextFieldWithNameState extends State<CustomTextFieldWithName> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(widget.ddName ?? '', style: TextStyle(fontFamily: 'FontMain')),
            SizedBox(width: 8),
            Text(
              widget.msg ?? '',
              style: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
                fontFamily: 'FontMain',
              ),
            ),
          ],
        ),
        SizedBox(height: 5),

        SizedBox(
          height: 50,
          child: TextFormField(
            obscureText: _obscureText,
            initialValue: widget.controller == null
                ? widget.initialValue
                : null,
            controller: widget.controller,
            validator: widget.validator,
            onChanged: widget.onChanged,
            onTap: widget.onTap,
            onEditingComplete: widget.onEditingComplete,
            readOnly: widget.readOnly,
            enabled: widget.enabled,
            keyboardType: widget.keyboardType ?? TextInputType.text,
            maxLength: widget.maxLength,
            inputFormatters: widget.inputFormatters,
            textAlignVertical: TextAlignVertical.center,
            style: TextStyle(color: Colors.black87, fontFamily: 'FontMain'),

            decoration: InputDecoration(
              hintText: widget.hintText,
              counterText: "",
              contentPadding: const EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 16,
              ),

              suffixIcon: widget.obscureText
                  ? IconButton(
                      icon: Icon(
                        _obscureText ? Icons.visibility_off : Icons.visibility,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                    )
                  : null,

              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black, width: 1),
                borderRadius: BorderRadius.circular(25),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: theme.primaryColor, width: 1.5),
                borderRadius: BorderRadius.circular(25),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red, width: 1),
                borderRadius: BorderRadius.circular(25),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red, width: 1.5),
                borderRadius: BorderRadius.circular(25),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              hintStyle: TextStyle(fontFamily: 'FontMain'),
            ),
          ),
        ),
      ],
    );
  }
}
