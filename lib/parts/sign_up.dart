import 'package:flutter/material.dart';
import 'package:codexhub01/reusable_widgets/reusable.dart';
import 'package:codexhub01/parts/log_in.dart'; // Import Login screen

/// Manages the user role selection locally
class RoleManager {
  static String _selectedRole = "user"; // Default role

  static void setRole(String role) {
    _selectedRole = role;
  }

  static String getRole() => _selectedRole;
}

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String _selectedRole = RoleManager.getRole();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: const Text(
          "Sign Up",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Container(
        width: size.width,
        height: size.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.white,
              Color(0xFFE3F2FD), // Light blue shade
              Colors.white,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Username input
                reusableTextField(
                  "Enter Username",
                  Icons.person_outline,
                  false,
                  _usernameController,
                  textColor: Colors.black,
                  iconColor: Colors.blue.shade700,
                  backgroundColor: Colors.white,
                  borderColor: Colors.blue.shade700,
                ),
                const SizedBox(height: 20),

                // Email input
                reusableTextField(
                  "Enter Email",
                  Icons.email_outlined,
                  false,
                  _emailController,
                  textColor: Colors.black,
                  iconColor: Colors.blue.shade700,
                  backgroundColor: Colors.white,
                  borderColor: Colors.blue.shade700,
                ),
                const SizedBox(height: 20),

                // Password input
                reusableTextField(
                  "Enter Password",
                  Icons.lock_outline,
                  true,
                  _passwordController,
                  textColor: Colors.black,
                  iconColor: Colors.blue.shade700,
                  backgroundColor: Colors.white,
                  borderColor: Colors.blue.shade700,
                ),
                const SizedBox(height: 20),

                // Role Selection label
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Select Your Role",
                    style: TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ),

                // Role dropdown
                DropdownButton<String>(
                  value: _selectedRole,
                  dropdownColor: Colors.white,
                  iconEnabledColor: Colors.blue.shade700,
                  style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w600),
                  onChanged: (String? newRole) {
                    if (newRole != null) {
                      setState(() {
                        _selectedRole = newRole;
                        RoleManager.setRole(newRole);
                      });
                    }
                  },
                  items: ["mentor", "user"].map((role) {
                    return DropdownMenuItem<String>(
                      value: role,
                      child: Text(role.toUpperCase()),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 30),

                // Sign Up / Navigate to Login button (using blue background)
                signInSignUpButton(
                  context,
                  false,
                  () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => const SignIn()),
                    );
                  },
                  backgroundColor: Colors.blue.shade700,
                  textColor: Colors.white,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
