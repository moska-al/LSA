import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:meeja/core/constants/colors.dart';
import 'package:meeja/screens/authentication/auth_provider.dart';
import 'package:meeja/screens/authentication/login_screen.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import '../../core/enums/view_state.dart';
import '../widget/bottom_navigation.dart';
import '../widget/custom_button.dart';
import '../widget/custom_textfield.dart';

class SignUp extends StatefulWidget {
  SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String _selectedRole = 'Admin';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AuthenticationProvider(),
      child: Consumer<AuthenticationProvider>(builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Color(0xffFEF6F5),
            title: Center(
              child: Text(
                'SignUp',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ),
          ),
          body: ModalProgressHUD(
            progressIndicator: CircularProgressIndicator(
              color: orangeColor,
            ),
            inAsyncCall: model.state == ViewState.busy,
            child: GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: Form(
                key: model.formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Stack(
                        children: [
                          CircleAvatar(
                            backgroundColor: Color(0xffE7DEDC),
                            radius: 50,
                            backgroundImage: model.userImage != null
                                ? FileImage(model.userImage!)
                                : AssetImage('assets/profile_icon.png')
                                    as ImageProvider,
                          ),
                          Positioned(
                            top: 60,
                            left: 60,
                            child: CircleAvatar(
                              backgroundColor: orangeColor,
                              child: IconButton(
                                onPressed: () {
                                  model.pickImageFromGallery();
                                },
                                icon: Icon(
                                  Icons.camera_alt_outlined,
                                  size: 20,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            // mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              customTextField(
                                textInputAction: TextInputAction.next,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Name can't be empty";
                                  }
                                },
                                onChanged: (value) {
                                  model.appUser.fullName = value;
                                },
                                hinttext: "Enter Full Name",
                                text: 'Full Name',
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              customTextField(
                                textInputAction: TextInputAction.next,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Name can't be empty";
                                  }
                                },
                                onChanged: (value) {
                                  model.appUser.userName = value;
                                },
                                hinttext: "Enter a unique username",
                                text: 'username',
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              customTextField(
                                textInputAction: TextInputAction.next,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Email cannot be empty";
                                  }
                                },
                                onChanged: (value) {
                                  model.appUser.userEmail = value;
                                },
                                hinttext: "Enter your email",
                                text: 'Email',
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              customTextField(
                                textInputAction: TextInputAction.next,
                                validator: (value) {
                                  if (value == null || value.length < 6) {
                                    return "password must not be less than 6 character";
                                  }
                                },
                                onChanged: (value) {
                                  model.appUser.password = value;
                                },
                                hinttext: "Password",
                                text: 'Password',
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              customTextField(
                                textInputAction: TextInputAction.next,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "password can't be empty";
                                  }
                                },
                                onChanged: (value) {
                                  model.appUser.confirmPassword = value;
                                },
                                hinttext: "Confirm Password",
                                text: 'Confirm Password',
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 30),
                                child: DropdownButtonFormField<String>(
                                  value: _selectedRole,
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedRole = value!;
                                      model.appUser.role = value;
                                    });
                                  },
                                  items: [
                                    DropdownMenuItem(
                                      value: 'Admin',
                                      child: Text(
                                        'Admin',
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    DropdownMenuItem(
                                      value: 'Parent',
                                      child: Text(
                                        'Parent',
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    DropdownMenuItem(
                                      value: 'Coach',
                                      child: Text(
                                        'Coach',
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    DropdownMenuItem(
                                      value: 'Gymnast',
                                      child: Text(
                                        'Gymnast',
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ],
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(
                                      vertical: 12.0,
                                      horizontal: 16.0,
                                    ),
                                    filled: true,
                                    fillColor: Colors.grey[200],
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: BorderSide.none,
                                    ),
                                    hintStyle: TextStyle(
                                      fontSize: 16.0,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.black,
                                  ),
                                  icon: Icon(
                                    Icons.arrow_drop_down,
                                    color: Colors.black,
                                  ),
                                  iconSize: 28.0,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              FormField<bool>(
                                validator: (value) {
                                  if (!model.isValue)
                                    return "You must agree to Terms & Privacy Policy";
                                },
                                builder: (formFieldState) {
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Checkbox(
                                            activeColor: orangeColor,
                                            value: model.isValue,
                                            onChanged: (value) {
                                              model.isChecked = value ?? true;
                                            },
                                          ),
                                          RichText(
                                            text: TextSpan(
                                              text: "I accept the Terms",
                                              style: TextStyle(
                                                  color: Colors.black54),
                                              children: <TextSpan>[
                                                TextSpan(
                                                  text: " of Use",
                                                  style: TextStyle(
                                                      color: orangeColor,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                TextSpan(
                                                  text: " &",
                                                  style: TextStyle(
                                                      color: Colors.black54,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                TextSpan(
                                                  text: " Privacy Policy",
                                                  style: TextStyle(
                                                      color: orangeColor,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      if (formFieldState.hasError)
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 8, top: 10),
                                          child: Text(
                                            formFieldState.errorText!,
                                            style: TextStyle(
                                                fontStyle: FontStyle.normal,
                                                fontSize: 13,
                                                color: Color.fromARGB(
                                                    255, 228, 116, 41),
                                                height: 0.5),
                                          ),
                                        )
                                    ],
                                  );
                                },
                              ),
                              SizedBox(
                                height: 5,
                              ),
                            ],
                          ),
                        ),
                      ),
                      CustomButton(
                          title: "SignUp",
                          onTap: () {
                            model.appUser.role = _selectedRole;
                            model.signUpUser(model.appUser, context);
                          }),
                      SizedBox(
                        height: 5,
                      ),
                      RichText(
                        text: TextSpan(
                            text: "Already Have An Account?",
                            style: TextStyle(color: Colors.black54),
                            children: <TextSpan>[
                              TextSpan(
                                text: "Login",
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => LogIn(),
                                      ),
                                    );
                                  },
                                style: TextStyle(
                                    color: orangeColor,
                                    fontWeight: FontWeight.bold),
                              ),
                            ]),
                      ),
                      SizedBox(
                        height: 10,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
