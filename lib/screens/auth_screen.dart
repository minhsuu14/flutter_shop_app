import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../utils/constants.dart';
import '../models/exception.dart';
import '../models/auth.dart';
import 'package:provider/provider.dart';
import '../utils/widget_functions.dart';

enum AuthMode { Signup, Login }

class AuthScreen extends StatelessWidget {
  static const routeName = '/auth';

  const AuthScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;
    // final transformConfig = Matrix4.rotationZ(-8 * pi / 180);
    // transformConfig.translate(-10.0);
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: LayoutBuilder(
        builder: ((context, constraints) => Stack(
              children: <Widget>[
                SingleChildScrollView(
                  child: Container(
                    height: constraints.maxHeight,
                    width: constraints.maxWidth,
                    padding: const EdgeInsets.only(top: 50),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                            height: 76,
                            width: 76,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Theme.of(context).primaryColor,
                            ),
                            child: Center(
                              child: Text(
                                'E',
                                style: textTheme.headline3!.apply(
                                    color: Colors.white, fontWeightDelta: 4),
                              ),
                            )),
                        addVerticalSpace(constraints.maxHeight * 0.17),
                        Text(
                          'Login to E-Shop',
                          style: textTheme.headline6!.apply(fontWeightDelta: 4),
                        ),
                        addVerticalSpace(20),
                        Flexible(
                          flex: deviceSize.width > 600 ? 2 : 1,
                          child: const AuthCard(),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}

class AuthCard extends StatefulWidget {
  const AuthCard({
    Key? key,
  }) : super(key: key);

  @override
  _AuthCardState createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  AuthMode _authMode = AuthMode.Login;
  Map<String, String> _authData = {
    'email': '',
    'password': '',
  };
  var _isLoading = false;
  final _passwordController = TextEditingController();

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      // Invalid!
      return;
    }
    _formKey.currentState?.save();
    setState(() {
      _isLoading = true;
    });
    try {
      if (_authMode == AuthMode.Login) {
        // Log user in
        await Provider.of<AuthProvider>(context, listen: false)
            .signIn(_authData['email']!, _authData['password']!);
      } else {
        // Sign up
        await Provider.of<AuthProvider>(context, listen: false)
            .signUp(_authData['email']!, _authData['password']!);
      }
    } on HttpException catch (error) {
      if (error.toString().contains('EMAIL_EXISTS')) {
        showErrorDialog(
            'The email address is already in use by another account.');
      } else if (error.toString().contains('TOO_MANY_ATTEMPTS_TRY_LATER')) {
        showErrorDialog('Too many attempts, try later.');
      } else if (error.toString().contains('EMAIL_NOT_FOUND')) {
        showErrorDialog('The email address is not found. ');
      } else if (error.toString().contains('INVALID_PASSWORD')) {
        showErrorDialog('Invalid password.');
      } else if (error.toString().contains('USER_DISABLED')) {
        showErrorDialog('This account has been blocked. ');
      }
    } catch (error) {
      rethrow;
    }
    setState(() {
      _isLoading = false;
    });
  }

  void showErrorDialog(String errorMsg) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text('Error'),
              content: Text(errorMsg),
              actions: [
                TextButton(
                    onPressed: () => Navigator.of(context).pop(context),
                    child: const Text('OK')),
              ],
            ));
  }

  void _switchAuthMode() {
    if (_authMode == AuthMode.Login) {
      setState(() {
        _authMode = AuthMode.Signup;
      });
    } else {
      setState(() {
        _authMode = AuthMode.Login;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 8.0,
      child: Container(
        height: _authMode == AuthMode.Signup ? 380 : 310,
        constraints:
            BoxConstraints(minHeight: _authMode == AuthMode.Signup ? 340 : 280),
        width: deviceSize.width * 0.75,
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'E-Mail',
                    labelStyle: textTheme.subtitle1!
                        .apply(fontWeightDelta: 2, color: Colors.grey),
                    border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    prefixIcon: const Icon(Icons.person_outlined),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        !value.contains('@')) {
                      return 'Invalid email!';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _authData['email'] = value!;
                  },
                ),
                addVerticalSpace(10),
                TextFormField(
                  decoration: InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      labelStyle: textTheme.subtitle1!
                          .apply(fontWeightDelta: 2, color: COLOR_GREY),
                      prefixIcon: const Icon(Icons.lock_outline)),
                  obscureText: true,
                  controller: _passwordController,
                  textInputAction: TextInputAction.done,
                  onFieldSubmitted: (_) => _submit(),
                  validator: (value) {
                    if (value == null || value.isEmpty || value.length < 5) {
                      return 'Password is too short!';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _authData['password'] = value!;
                  },
                ),
                addVerticalSpace(10),
                if (_authMode == AuthMode.Signup)
                  TextFormField(
                    enabled: _authMode == AuthMode.Signup,
                    decoration: InputDecoration(
                        labelText: 'Confirm Password',
                        prefixIcon: const Icon(Icons.lock_open_outlined),
                        labelStyle: textTheme.subtitle1!
                            .apply(color: COLOR_GREY, fontWeightDelta: 2),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                    obscureText: true,
                    validator: _authMode == AuthMode.Signup
                        ? (value) {
                            if (value != _passwordController.text) {
                              return 'Passwords do not match!';
                            }
                            return null;
                          }
                        : null,
                  ),
                const SizedBox(
                  height: 20,
                ),
                if (_isLoading)
                  const CircularProgressIndicator()
                else
                  Container(
                    padding: const EdgeInsets.all(13),
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(15)),
                    child: InkWell(
                      splashColor: Colors.deepOrange[700],
                      onTap: _submit,
                      child: Center(
                          child: Text(
                        'LOGIN',
                        style: textTheme.headline6!.apply(color: Colors.white),
                      )),
                    ),
                  ),
                addVerticalSpace(10),
                TextButton(
                  child: Text(
                    '${_authMode == AuthMode.Login ? 'SIGNUP' : 'LOGIN'} INSTEAD',
                  ),
                  onPressed: _switchAuthMode,
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30.0, vertical: 4),
                    textStyle: textTheme.subtitle2!
                        .apply(color: Theme.of(context).primaryColor),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
