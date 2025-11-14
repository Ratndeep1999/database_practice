import 'package:flutter/material.dart';
import 'CustomWidgets/label_widget.dart';

class SigningPage extends StatefulWidget {
  const SigningPage({super.key});

  @override
  State<SigningPage> createState() => _SigningPageState();
}

final _formKey = GlobalKey<FormState>();
final _emailController = TextEditingController();

class _SigningPageState extends State<SigningPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Appbar
      appBar: AppBar(
        title: LabelWidget(
          label: "Signing Page",
          fontSize: 30,
          fontWeight: FontWeight.w600,
          fontColor: Colors.black87,
          letterSpacing: 2.0,
        ),
        centerTitle: true,
        backgroundColor: Colors.orange.shade400,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Focus(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Email label
                LabelWidget(
                  label: 'Email Address',
                  fontColor: Colors.black,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w400,
                ),
                SizedBox(height: 18.0),

                /// Text field for Email
                InputTextFieldWidget(),

                SizedBox(height: 50.0),

                /// Password label
                LabelWidget(
                  label: 'Password',
                  fontColor: Colors.black,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w400,
                ),
                SizedBox(height: 18.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class InputTextFieldWidget extends StatelessWidget {
  const InputTextFieldWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _emailController,
      onSaved: (email) {
        debugPrint(email);
      },
      validator: (email) {
        return null;
      },
      // autocorrect: ,
      // autofillHints: ,
      // onFieldSubmitted: ,
      // focusNode: ,
      autofocus: false,
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.emailAddress,
      style: TextStyle(
        fontSize: 18.0,
        color: Colors.black54,
        fontWeight: FontWeight.w400,
      ),
      decoration: InputDecoration(
        hint: Text('Enter your Email id'),
        suffixIcon: Icon(Icons.email, size: 20),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0),
          borderSide: BorderSide(width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0),
          borderSide: BorderSide(color: Colors.black26),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0),
          borderSide: BorderSide(color: Colors.red, width: 2.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0),
          borderSide: BorderSide(color: Colors.red, width: 2.0),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
        isDense: true,
      ),
    );
  }
}
