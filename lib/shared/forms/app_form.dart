import 'package:flutter/material.dart';

class AppForm extends StatelessWidget {
  const AppForm({
    required this.formKey,
    required this.fields,
    super.key,
    this.padding,
    this.mainAxisAlignment = MainAxisAlignment.start,
  });
  final GlobalKey<FormState> formKey;
  final List<Widget> fields;
  final EdgeInsetsGeometry? padding;
  final MainAxisAlignment mainAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Padding(
        padding: padding ?? EdgeInsets.zero,
        child: Column(
          mainAxisAlignment: mainAxisAlignment,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: fields,
        ),
      ),
    );
  }
}
