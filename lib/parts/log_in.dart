import 'package:codexhub01/utils/reset.dart' as reset;
import 'package:flutter/material.dart';
import 'package:codexhub01/reusable_widgets/reusable.dart';
import 'package:codexhub01/parts/sign_up.dart' as signup;
import 'package:codexhub01/parts/mentor.dart';
import 'package:codexhub01/main.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  SignInState createState() => SignInState();
}

class SignInState extends State<SignIn> {
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();

  Future<void> signInUser() async {
    String email = _emailTextController.text.trim();
    String password = _passwordTextController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      _showErrorDialog("Please fill in all fields.");
      return;
    }

    String userRole = signup.RoleManager.getRole();

    switch (userRole) {
      case "mentor":
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MentorDashboardScreen()),
        );
        break;
      case "user":
      default:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => DashboardScreen()),
        );
        break;
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Error"),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // White background for app
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(24.0),
          width: 360,
          decoration: BoxDecoration(
            color: Colors.white, // White container
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha((0.1 * 255).round()),

                blurRadius: 12,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Log in',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 28),

                // Email input with custom colors
                reusableTextField(
                  "Enter Email",
                  Icons.person_outline,
                  false,
                  _emailTextController,
                  textColor: Colors.black87,
                  iconColor: Colors.blue.shade700,
                  fillColor: Colors.grey.shade50,
                  borderColor: Colors.grey.shade400,
                  focusedBorderColor: Colors.blue.shade700,
                  backgroundColor: Colors.blue,
                  
                ),
                const SizedBox(height: 20),

                // Password input
                reusableTextField(
                  "Enter Password",
                  Icons.lock_outline,
                  true,
                  _passwordTextController,
                  textColor: Colors.black87,
                  iconColor: Colors.blue.shade700,
                  fillColor: Colors.grey.shade50,
                  borderColor: Colors.grey.shade400,
                  focusedBorderColor: Colors.blue.shade700,
                  backgroundColor: Colors.blue,
                ),
                const SizedBox(height: 12),

                _forgotPasswordOption(context),
                const SizedBox(height: 16),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: signInUser,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue.shade700,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 6,
                    ),
                    child: const Text(
                      'Log in',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                signUpOption(context),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget _forgotPasswordOption(BuildContext context) {
  return Align(
    alignment: Alignment.centerRight,
    child: TextButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => reset.ResetPasswordScreen(),
          ),
        );
      },
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
        minimumSize: Size.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: Text(
        "Forgot Password?",
        style: TextStyle(
          color: Colors.blue.shade700,
          fontWeight: FontWeight.w600,
          fontSize: 14,
          decoration: TextDecoration.underline,
        ),
      ),
    ),
  );
}

Row signUpOption(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      const Text(
        "Don't have an account?",
        style: TextStyle(
          color: Colors.black54,
          fontSize: 14,
        ),
      ),
      TextButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => signup.SignUp()),
          );
        },
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          minimumSize: Size.zero,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        child: Text(
          "Sign Up",
          style: TextStyle(
            color: Colors.blue.shade700,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
      ),
    ],
  );
}
