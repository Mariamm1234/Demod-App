// lib/pages/login.dart

import 'package:demod/providers/userProviser.dart';
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:provider/provider.dart';
import '../models/token.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final businessController = TextEditingController();

    void login(BuildContext context) async {
      final authProvider = Provider.of<UserProvider>(context, listen: false);
      final email = emailController.text.trim().toLowerCase();
      final password = passwordController.text.trim();
      final businessName = businessController.text.trim().toLowerCase();

      if (email.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please enter a valid email address")),
        );
        return;
      }

      if (password.isEmpty || password.length < 6) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text("Password must be at least 6 characters")),
        );
        return;
      }

      final token = TokenDto(
        email: email,
        password: password,
        businessName: businessName,
      );

      final isSuccess = await authProvider.token(token);

      if (authProvider.isAuthenticated) {
        authProvider.count++;
        print("Login successful. Navigating to Shop Page.");
        // Navigator.pushReplacementNamed(context, '/shop_page');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Login failed. Please try again.")),
        );
      }
      if (authProvider.count == 2) {
        Navigator.pushReplacementNamed(context, '/shop_page');
      }
    }

    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            colors: [
              Colors.grey.shade900,
              Colors.grey.shade800,
              Colors.grey.shade400
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 80),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  FadeInUp(
                    duration: const Duration(milliseconds: 1000),
                    child: const Text(
                      "Login",
                      style: TextStyle(color: Colors.white, fontSize: 40),
                    ),
                  ),
                  const SizedBox(height: 10),
                  FadeInUp(
                    duration: const Duration(milliseconds: 1300),
                    child: const Text(
                      "Welcome Back",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(60),
                    topRight: Radius.circular(60),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(30),
                  child: Column(
                    children: <Widget>[
                      const SizedBox(height: 60),
                      FadeInUp(
                        duration: const Duration(milliseconds: 1400),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: const [
                              BoxShadow(
                                color: Color.fromRGBO(225, 95, 27, .3),
                                blurRadius: 20,
                                offset: Offset(0, 10),
                              ),
                            ],
                          ),
                          child: Column(
                            children: <Widget>[
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom:
                                        BorderSide(color: Colors.grey.shade200),
                                  ),
                                ),
                                child: TextField(
                                  controller: emailController,
                                  decoration: const InputDecoration(
                                    hintText: "Email or Phone number",
                                    hintStyle: TextStyle(color: Colors.grey),
                                    border: InputBorder.none,
                                  ),
                                  keyboardType: TextInputType.emailAddress,
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom:
                                        BorderSide(color: Colors.grey.shade200),
                                  ),
                                ),
                                child: TextField(
                                  controller: passwordController,
                                  obscureText: true,
                                  decoration: const InputDecoration(
                                    hintText: "Password",
                                    hintStyle: TextStyle(color: Colors.grey),
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom:
                                        BorderSide(color: Colors.grey.shade200),
                                  ),
                                ),
                                child: TextField(
                                  controller: businessController,
                                  decoration: const InputDecoration(
                                    hintText: "Business Name",
                                    hintStyle: TextStyle(color: Colors.grey),
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                              // Consumer to conditionally show the token TextField
                              Consumer<UserProvider>(
                                builder: (context, authProvider, child) {
                                  if (authProvider.isAuthenticated &&
                                      authProvider.vip != null) {
                                    return Container(
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(
                                              color: Colors.grey.shade200),
                                        ),
                                      ),
                                      child: TextField(
                                        obscureText: true,
                                        readOnly: true,
                                        controller: TextEditingController(
                                            text: authProvider.vip),
                                        decoration: const InputDecoration(
                                          hintText: "Token",
                                          hintStyle:
                                              TextStyle(color: Colors.grey),
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    );
                                  } else {
                                    return const SizedBox.shrink();
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),
                      FadeInUp(
                        duration: const Duration(milliseconds: 1500),
                        child: const Text(
                          "Forgot Password?",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                      const SizedBox(height: 40),
                      FadeInUp(
                        duration: const Duration(milliseconds: 1600),
                        child: MaterialButton(
                          onPressed: () => login(context),
                          height: 50,
                          color: Colors.orange[900],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: const Center(
                            child: Text(
                              "Login",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
